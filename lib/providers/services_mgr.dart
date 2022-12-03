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

  Future<Map<String, String>> uploadServiceImages(
      String serviceID, Map<String, File> imagesMap) async {
    Map<String, String> serviceImages = {};
    for (MapEntry imageEntry in imagesMap.entries) {
      String photoName = '${imageEntry.key}.png';
      Reference ref =
          _fst.ref('$servicesStorageDir/$serviceID').child(photoName);
      await ref.putFile(imageEntry.value);
      String imageURL = await ref.getDownloadURL();
      serviceImages[imageEntry.key] = imageURL;
    }
    return serviceImages;
  }

  Future<void> submitNewService(
      Service newService, Map<String, File> imagesMap) async {
    /// Submitting new service - update DB
    /// Images map contains new media images to upload

    CollectionReference servicesColl = _fs.collection(servicesCollection);
    var data = newService.toJson();
    data['priority'] = services.length;
    DocumentReference doc = await servicesColl.add(data);
    Map<String, String> serviceImages =
        await uploadServiceImages(doc.id, imagesMap);
    newService.imagesURL!.addAll(serviceImages);
    await servicesColl.doc(doc.id).update({'images': newService.imagesURL!});
  }

  Future<void> deleteServiceImage(String serviceID, String image) async {
    Reference ref =
        _fst.ref('$servicesStorageDir/$serviceID').child('$image.png');
    await ref.delete();
    await _fs.collection(servicesCollection).doc(serviceID).update({
      'images.$image': FieldValue.delete(),
    });
  }

  Future<void> deleteServiceImages(
      String serviceID, List<String> imagesIDs) async {
    for (String imageName in imagesIDs) {
      Reference ref =
          _fst.ref('$servicesStorageDir/$serviceID').child('$imageName.png');
      await ref.delete();
    }
  }

  Future<void> updateService(
      Service updatedService, Map<String, File> imagesMap) async {
    /// Update existing service - update DB
    Map<String, String> serviceImages =
        await uploadServiceImages(updatedService.id, imagesMap);
    updatedService.imagesURL!.addAll(serviceImages);
    CollectionReference servicesColl = _fs.collection(servicesCollection);
    var data = updatedService.toJson();
    servicesColl.doc(updatedService.id).update(data);
  }

  Future<void> deleteService(Service serviceToDelete) async {
    /// delete existing service - update DB
    CollectionReference servicesColl = _fs.collection(servicesCollection);
    await deleteServiceImages(
        serviceToDelete.id, serviceToDelete.imagesURL!.keys.toList());
    servicesColl.doc(serviceToDelete.id).delete();
  }
}
