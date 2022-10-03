import 'dart:async';
import 'dart:io';

import 'package:appointments/data_types/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

/// Services manager provider
/// Managing and handling services data and DB interaction

///*************************** Naming **********************************///
const servicesCollection = 'services';
const servicesStorageDir = 'services';

class ServicesMgr extends ChangeNotifier {
  ///************************* Firestore *******************************///
  final FirebaseFirestore _fs = FirebaseFirestore.instance;
  final FirebaseAuth _fa = FirebaseAuth.instance;
  final FirebaseStorage _fst = FirebaseStorage.instance;

  ///************************* Services *******************************///
  List<Service> _services = []; // Holds all DB services
  bool initialized = false; // Don't download services unless required
  StreamSubscription<QuerySnapshot>? _servicesSub;

  List<Service> get services {
    if (!initialized) {
      initialized = true;
      downloadServices();
    }
    return _services;
  }

  Future<void> downloadServices() async {
    /// Download services from DB
    // query preparation

    var query = _fs
        .collection(servicesCollection)
        .orderBy('priority', descending: true);

    _servicesSub = query.snapshots().listen(
      (snapshot) async {
        _services = [];
        if (snapshot.docs.isEmpty) {
          // No data to show - notifying listeners for empty services list.
          notifyListeners();
          return;
        }

        // Services collection has data to show
        for (var document in snapshot.docs) {
          var data = document.data();
          data['id'] = document.id;
          _services.add(Service.fromJson(data));
        }
        notifyListeners();
      },
    );
  }

  Future<void> uploadServiceImage(String serviceName, File image) async {
    Reference ref = _fst.ref(servicesStorageDir).child('$serviceName.png');
    await ref.putFile(image);
  }

  Future<void> submitNewService(Service newService) async {
    /// Submitting new service - update DB
    CollectionReference servicesColl = _fs.collection(servicesCollection);
    var data = newService.toJson();
    data['priority'] = services.length;
    servicesColl.add(data);
    // await uploadServiceImage(newService.name, image);
  }

  Future<void> updateService(Service updatedService) async {
    /// Update existing service - update DB
    CollectionReference servicesColl = _fs.collection(servicesCollection);
    var data = updatedService.toJson();
    servicesColl.doc(updatedService.id).update(data);
  }

  Future<void> deleteService(Service serviceToDelete) async {
    /// delete existing service - update DB
    CollectionReference servicesColl = _fs.collection(servicesCollection);
    servicesColl.doc(serviceToDelete.id).delete();
  }
}
