import 'dart:async';

import 'package:appointments/data_types/components.dart';
import 'package:appointments/data_types/macros.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

/// Clients manager provider
/// Managing and handling clients data and DB interaction

///*************************** Naming **********************************///
const clientsCollection = 'clients';
const clientAppointmentsCollection = 'client_appointments';
const clientStorageDir = 'clients';
const appointmentsCollection = 'appointments';

class PhoneNumberUsedException implements Exception {}

class EmailUsedException implements Exception {}

class ClientsMgr extends ChangeNotifier {
  ///*************************** Firestore **********************************///
  final FirebaseFirestore _fs = FirebaseFirestore.instance;
  final FirebaseAuth _fa = FirebaseAuth.instance;
  final FirebaseStorage _fst = FirebaseStorage.instance;

  ///************************* Clients *******************************///
  List<Client> _clients = []; // Holds all DB clients
  bool initialized = false; // Don't download clients unless required
  StreamSubscription<QuerySnapshot>? _clientsSub;

  List<Client> get clients {
    if (!initialized) {
      initialized = true;
      downloadClients();
    }
    return _clients;
  }

  Future<void> downloadClients() async {
    /// Download services from DB
    // query preparation

    var query =
        _fs.collection(clientsCollection).orderBy('fullName', descending: true);

    _clientsSub = query.snapshots().listen(
      (snapshot) async {
        _clients = [];
        if (snapshot.docs.isEmpty) {
          // No data to show - notifying listeners for empty clients list.
          notifyListeners();
          return;
        }

        // Clients collection has data to show
        for (var document in snapshot.docs) {
          var data = document.data();
          data['id'] = document.id;
          _clients.add(Client.fromJson(data));
        }
        notifyListeners();
      },
    );
  }

  Future<bool> checkEmailAvailability(String email, String? byClientId) async {
    if (email.isEmpty) {
      // This is for users created by the admin
      return true;
    }
    if (initialized) {
      for (Client client in _clients) {
        if (client.email == email &&
            (byClientId == null || client.id != byClientId)) {
          return false;
        }
      }
    } else {
      CollectionReference clientsColl = _fs.collection(clientsCollection);
      var clientsResults =
          await clientsColl.where('email', isEqualTo: email).get();
      if (clientsResults.size > 0) {
        if (byClientId == null) {
          return false;
        } else {
          for (var clientDoc in clientsResults.docs) {
            if (clientDoc.id != byClientId) {
              return false;
            }
          }
        }
      }
    }
    return true;
  }

  Future<bool> checkPhoneNumberAvailability(
      String phone, String? byClientId) async {
    if (initialized) {
      for (Client client in _clients) {
        if (client.phone == phone &&
            (byClientId == null || client.id != byClientId)) {
          return false;
        }
      }
    } else {
      CollectionReference clientsColl = _fs.collection(clientsCollection);
      var clientsResults =
          await clientsColl.where('phone', isEqualTo: phone).get();
      if (clientsResults.size > 0) {
        if (byClientId == null) {
          return false;
        } else {
          for (var clientDoc in clientsResults.docs) {
            if (clientDoc.id != byClientId) {
              return false;
            }
          }
        }
      }
    }
    return true;
  }

  Future<void> submitNewClient(Client newClient) async {
    // Validate that phone number is not used by existing client
    bool phoneAvailable =
        await checkPhoneNumberAvailability(newClient.phone, null);
    if (!phoneAvailable) {
      throw PhoneNumberUsedException();
    }
    bool emailAvailable = await checkEmailAvailability(newClient.email, null);
    if (!emailAvailable) {
      throw EmailUsedException();
    }
    CollectionReference clientsColl = _fs.collection(clientsCollection);

    /// Submitting new Client - update DB
    clientsColl.add(newClient.toJson());
  }

  List<ClientAppointment> _selectedUpcomingClientAppointments =
      []; // Holds all selected client upcoming appointments
  bool initializedClientUpcomingAppointments =
      false; // Don't download clients unless required
  StreamSubscription<QuerySnapshot>? _clientUpcomingAppointments;

  List<ClientAppointment> get selectedClientUpcomingAppointments {
    if (!initializedClientAppointments) {
      initializedClientAppointments = true;
      downloadClientUpComingAppointment(
          selectedClient == null ? null : selectedClient!.id);
    }
    return _selectedUpcomingClientAppointments;
  }

  List<ClientAppointment> _selectedClientAppointments =
      []; // Holds all selected client appointments
  bool initializedClientAppointments =
      false; // Don't download clients unless required
  StreamSubscription<QuerySnapshot>? _clientAppointments;

  List<ClientAppointment> get selectedClientNoShowAppointments {
    if (!initializedClientAppointments) {
      initializedClientAppointments = true;
      downloadClientAppointment(
          selectedClient == null ? null : selectedClient!.id);
    }
    return _selectedClientAppointments
        .where((element) => element.status == AppointmentStatus.noShow)
        .toList();
  }

  List<ClientAppointment> get selectedClientCancelledAppointments {
    if (!initializedClientAppointments) {
      initializedClientAppointments = true;
      downloadClientAppointment(
          selectedClient == null ? null : selectedClient!.id);
    }
    return _selectedClientAppointments
        .where((element) => element.status == AppointmentStatus.cancelled)
        .toList();
  }

  List<ClientAppointment> get selectedClientFinishedAppointments {
    if (!initializedClientAppointments) {
      initializedClientAppointments = true;
      downloadClientAppointment(
          selectedClient == null ? null : selectedClient!.id);
    }
    return _selectedClientAppointments
        .where((element) => element.status == AppointmentStatus.finished)
        .toList();
  }

  List<ClientAppointment> get selectedClientAppointments {
    if (!initializedClientAppointments) {
      initializedClientAppointments = true;
      downloadClientAppointment(
          selectedClient == null ? null : selectedClient!.id);
    }
    return _selectedClientAppointments;
  }

  Future<void> downloadClientUpComingAppointment(String? clientID) async {
    if (clientID == null) {
      return;
    }
    Query<Map<String, dynamic>> query = _fs
        .collection(clientsCollection)
        .doc(clientID)
        .collection(clientAppointmentsCollection);
    query = query
        .where('startTime', isGreaterThanOrEqualTo: DateTime.now())
        .where('status', isEqualTo: AppointmentStatus.confirmed.toString());
    _clientUpcomingAppointments = query.snapshots().listen((snapshot) {
      _selectedUpcomingClientAppointments = [];
      if (snapshot.docs.isEmpty) {
        // No data to show - notifying listeners for empty client appointments list.
        notifyListeners();
        return;
      }
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data();
        data['id'] = doc.id;
        _selectedUpcomingClientAppointments
            .add(ClientAppointment.fromJson(data));
      }
      notifyListeners();
    });
  }

  Future<void> downloadClientAppointment(String? clientID) async {
    if (clientID == null) {
      return;
    }
    Query<Map<String, dynamic>> query = _fs
        .collection(clientsCollection)
        .doc(clientID)
        .collection(clientAppointmentsCollection)
        .orderBy('startTime');
    // I added to the query to sort by start time.
    // why we need to do where clause?
    // query = query.where('status',
    //     isNotEqualTo: AppointmentStatus.confirmed.toString());
    _clientAppointments = query.snapshots().listen((snapshot) {
      _selectedClientAppointments = [];
      if (snapshot.docs.isEmpty) {
        // No data to show - notifying listeners for empty client appointments list.
        notifyListeners();
        return;
      }
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data();
        data['id'] = doc.id;
        _selectedClientAppointments.add(ClientAppointment.fromJson(data));
      }
      notifyListeners();
    });
  }

  Future<List<ClientAppointment>> getClientAppointments(String clientID) async {
    Query<Map<String, dynamic>> query = _fs
        .collection(clientsCollection)
        .doc(clientID)
        .collection(clientAppointmentsCollection);
    query = query
        .where('startTime', isGreaterThanOrEqualTo: DateTime.now())
        .where('status', isEqualTo: AppointmentStatus.confirmed.toString())
        .limit(2);
    List<ClientAppointment> appointments = [];
    QuerySnapshot querySnapshot = await query.get();
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      appointments.add(ClientAppointment.fromJson(data));
    }
    return appointments;
  }

  Future<void> updateClientAppointments(Client client) async {
    /// Update client details in all client's appointments
    Query<Map<String, dynamic>> query = _fs
        .collection(clientsCollection)
        .doc(client.id)
        .collection(clientAppointmentsCollection);
    QuerySnapshot querySnapshot = await query.get();
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      var updatedData = {
        'clientName': client.fullName,
        'clientPhone': client.phone,
        'clientEmail': client.email,
      };
      await _fs
          .collection(appointmentsCollection)
          .doc(data['appointmentIdRef'])
          .update(updatedData);
    }
  }

  Future<void> updateClient(String? adminId, Client updatedClient) async {
    /// Validate that phone number is not used by another client
    bool phoneAvailable = await checkPhoneNumberAvailability(
        updatedClient.phone, updatedClient.id);
    if (!phoneAvailable) {
      throw PhoneNumberUsedException();
    }
    bool emailAvailable =
        await checkEmailAvailability(updatedClient.email, updatedClient.id);
    if (!emailAvailable) {
      throw EmailUsedException();
    }

    /// Update existing Client - update DB
    CollectionReference clientsColl = _fs.collection(clientsCollection);
    if (initialized) {
      var oldClientRes = _clients.where((c) => c.id == updatedClient.id);
      if (oldClientRes.isNotEmpty &&
          oldClientRes.first.isApprovedByAdmin !=
              updatedClient.isApprovedByAdmin) {
        updatedClient.lasApprovalEditorId = adminId;
        updatedClient.lasApprovalEditDate = DateTime.now();
      }
    }
    var data = updatedClient.toJson();
    clientsColl.doc(updatedClient.id).update(data);
    updateClientAppointments(updatedClient);
  }

  Future<void> updateClientApproval(
      String? adminId, String clientId, bool approve) async {
    await _fs.collection(clientsCollection).doc(clientId).update({
      'isApprovedByAdmin': approve,
      'lasApprovalEditorId': adminId,
      'lasApprovalEditDate': Timestamp.fromDate(DateTime.now()),
    });
  }

  /// Client selection
  Client? selectedClient;
  bool isSelectedClientLoaded = false;

  Future<void> setSelectedClient({
    Client? client,
    String? clientID,
  }) async {
    isSelectedClientLoaded = false;
    List<ClientAppointment> appointments = [];
    if (client != null) {
      // Client is provided, no need to download
      selectedClient = client;
      isSelectedClientLoaded = true;
    } else {
      // download appointment
      DocumentSnapshot doc =
          await _fs.collection(clientsCollection).doc(clientID).get();
      // Get client upcoming appointments
      // appointments = await getClientAppointments(clientID!),
      await downloadClientAppointment(clientID!);
      await downloadClientUpComingAppointment(clientID);
      if (!doc.exists) {
        notifyListeners();
        return;
      }
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['appointments'] =
          selectedClientAppointments + selectedClientUpcomingAppointments;
      data['id'] = doc.id;
      selectedClient = Client.fromJson(data);
      isSelectedClientLoaded = true;
      notifyListeners();
    }
  }
}
