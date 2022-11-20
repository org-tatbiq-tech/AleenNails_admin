import 'dart:async';
import 'dart:io';

import 'package:appointments/data_types/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

/// Clients manager provider
/// Managing and handling clients data and DB interaction

///*************************** Naming **********************************///
const clientsCollection = 'clients';
const clientStorageDir = 'clients';

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

  Future<void> uploadClientImage(File image, String path) async {
    Reference ref = _fst.ref(clientStorageDir).child(path);
    await ref.putFile(image);
  }

  Future<String> getClientImage(String path) async {
    Reference ref = _fst.ref(clientStorageDir).child('${path}_600x600');
    var refStr = 'notFound';
    try {
      refStr = await ref.getDownloadURL();
    } catch (error) {
      return refStr;
    }
    return refStr;
  }

  Future<void> deleteClientImage(String path) async {
    Reference ref = _fst.ref(clientStorageDir).child('${path}_600x600');
    return await ref.delete();
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
  }

  /// Client selection
  late Client selectedClient;
  bool isSelectedClientLoaded = false;

  Future<void> setSelectedClient({
    Client? client,
    String? clientID,
  }) async {
    isSelectedClientLoaded = false;
    if (client != null) {
      // Client is provided, no need to download
      selectedClient = client;
      isSelectedClientLoaded = true;
    } else {
      // download appointment
      Map<String, dynamic>? data;
      _fs.collection(clientsCollection).doc(clientID).get().then(
            (value) => {
              data = value.data(),
              if (data != null)
                {
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
