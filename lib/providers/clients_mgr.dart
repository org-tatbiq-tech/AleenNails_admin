import 'dart:async';

import 'package:appointments/data_types/components.dart';
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
    CollectionReference clientsColl = _fs.collection(clientsCollection);

    /// Submitting new Client - update DB
    clientsColl.add(newClient.toJson());
  }

  Future<List<ClientAppointment>> getClientAppointments(String clientID) async {
    Query<Map<String, dynamic>> query = _fs
        .collection(clientsCollection)
        .doc(clientID)
        .collection(clientAppointmentsCollection);
    query = query.where('startTime', isGreaterThanOrEqualTo: DateTime.now());
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

  Future<void> updateClient(Client updatedClient) async {
    /// Validate that phone number is not used by another client
    bool phoneAvailable = await checkPhoneNumberAvailability(
        updatedClient.phone, updatedClient.id);
    if (!phoneAvailable) {
      throw PhoneNumberUsedException();
    }

    /// Update existing Client - update DB
    CollectionReference clientsColl = _fs.collection(clientsCollection);
    var data = updatedClient.toJson();
    clientsColl.doc(updatedClient.id).update(data);
    updateClientAppointments(updatedClient);
  }

  Future<void> updateClientApproval(String clientId, bool approve) async {
    await _fs
        .collection(clientsCollection)
        .doc(clientId)
        .update({'isApprovedByAdmin': approve});
  }

  /// Client selection
  late Client selectedClient;
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
      Map<String, dynamic>? data;
      _fs.collection(clientsCollection).doc(clientID).get().then(
            (value) async => {
              // Get client upcoming appointments
              appointments = await getClientAppointments(clientID!),
              data = value.data(),
              if (data != null)
                {
                  data!['appointments'] = appointments,
                  data!['id'] = value.id,
                  selectedClient = Client.fromJson(data!),
                  isSelectedClientLoaded = true,
                },
              notifyListeners(),
            },
          );
    }
  }
}
