import 'package:appointments/data_types/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Services manager provider
/// Managing and handling services data and DB interaction

///*************************** Naming **********************************///
const servicesCollection = 'services';

class ServicesMgr extends ChangeNotifier {
  ///*************************** Firestore **********************************///
  final FirebaseFirestore _fs = FirebaseFirestore.instance;
  final FirebaseAuth _fa = FirebaseAuth.instance;

  ///************* services *************///
  late Appointment selectedService;
  bool isSelectedServiceLoaded = false;

  Future<void> submitNewService(Service newService) async {
    /// Submitting new service - update DB
    CollectionReference services = _fs.collection(servicesCollection);
    services.add(newService.toJson());
  }
}
