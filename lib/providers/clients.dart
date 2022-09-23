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

  ///************* appointments *************///
  late Appointment selectedClient;
  bool isSelectedClientLoaded = false;

  Future<void> submitNewClient(Client newClient) async {
    /// Submitting new Client - update DB
    CollectionReference clients = _fs.collection(clientsCollection);
    clients.add(newClient.toJson());
  }
}
