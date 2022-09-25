import 'dart:async';

import 'package:appointments/data_types/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Clients manager provider
/// Managing and handling clients data and DB interaction

///*************************** Naming **********************************///
const clientsCollection = 'clients';

class ClientsMgr extends ChangeNotifier {
  ///*************************** Firestore **********************************///
  final FirebaseFirestore _fs = FirebaseFirestore.instance;
  final FirebaseAuth _fa = FirebaseAuth.instance;

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
          // No data to show - notifying listeners for empty services list.
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

  late Appointment selectedClient;
  bool isSelectedClientLoaded = false;

  Future<void> submitNewClient(Client newClient) async {
    /// Submitting new Client - update DB
    CollectionReference clientsColl = _fs.collection(clientsCollection);
    clientsColl.add(newClient.toJson());
  }

  Future<void> updateClient(Client updatedClient) async {
    /// Update existing Client - update DB
    CollectionReference clientsColl = _fs.collection(clientsCollection);
    var data = updatedClient.toJson();
    clientsColl.doc(updatedClient.id).update(data);
  }
}
