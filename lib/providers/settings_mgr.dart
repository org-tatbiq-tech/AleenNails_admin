import 'dart:async';
import 'dart:io';

import 'package:appointments/data_types/settings_components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

/// Settings manager provider
/// Managing and handling settings data and DB interaction

///*************************** Naming **********************************///
const settingsCollection = 'settings';
const scheduleManagementDoc = 'scheduleManagement';
const profileManagementDoc = 'profile';
const profileStorageDir = 'profile';
const profileWPStorageDir = 'profile/workplace';

class SettingsMgr extends ChangeNotifier {
  SettingsMgr() {
    downloadScheduleManagement();
    downloadProfileManagement();
  }

  ///*************************** Firestore **********************************///
  final FirebaseFirestore _fs = FirebaseFirestore.instance;
  final FirebaseStorage _fst = FirebaseStorage.instance;

  ///************************* Settings *******************************///

  ///*********************** Schedule management ****************************///
  ScheduleManagement _scheduleManagement =
      ScheduleManagement(); // Holds Working days
  bool initializedScheduleManagement =
      false; // Don't download Schedule management settings unless required
  StreamSubscription<DocumentSnapshot>? _scheduleManagementSub;

  ScheduleManagement get scheduleManagement {
    if (!initializedScheduleManagement) {
      initializedScheduleManagement = true;
      downloadScheduleManagement();
    }
    return _scheduleManagement;
  }

  Future<void> downloadScheduleManagement() async {
    /// Download schedule from DB
    // query preparation
    var query = _fs.collection(settingsCollection);

    _scheduleManagementSub =
        query.doc(scheduleManagementDoc).snapshots().listen(
      (snapshot) async {
        if (!snapshot.exists ||
            snapshot.data() == null ||
            snapshot.data()!.isEmpty) {
          // No data to show - notifying listeners for empty schedule management settings
          notifyListeners();
          return;
        }

        // schedule management doc has data to show
        _scheduleManagement = ScheduleManagement.fromJson(snapshot.data()!);
        notifyListeners();
      },
    );
  }

  Future<void> submitNewScheduleManagement() async {
    /// Submitting new Schedule management - update DB
    CollectionReference settingsColl = _fs.collection(settingsCollection);
    settingsColl
        .doc(scheduleManagementDoc)
        .update(_scheduleManagement.toJson());
  }

  ///*********************** Profile ****************************///
  ProfileManagement _profileManagement = ProfileManagement(
      businessInfo: BusinessInfoComp.fromJson({})); // Holds profile details
  bool initializedProfileManagement =
      false; // Don't download Profile details form settings unless required
  StreamSubscription<DocumentSnapshot>? _profileManagementSub;

  ProfileManagement get profileManagement {
    if (!initializedProfileManagement) {
      initializedProfileManagement = true;
      downloadProfileManagement();
    }
    return _profileManagement;
  }

  Future<void> downloadProfileManagement() async {
    /// Download services from DB
    // query preparation

    var query = _fs.collection(settingsCollection);

    _profileManagementSub = query.doc(profileManagementDoc).snapshots().listen(
      (snapshot) async {
        if (!snapshot.exists ||
            snapshot.data() == null ||
            snapshot.data()!.isEmpty) {
          // No data to show - notifying listeners for empty schedule management settings
          notifyListeners();
          return;
        }

        // schedule management doc has data to show
        _profileManagement = ProfileManagement.fromJson(snapshot.data()!);
        notifyListeners();
      },
    );
  }

  Future<void> submitNewProfile() async {
    /// Submitting new Profile details - update DB
    CollectionReference settingsColl = _fs.collection(settingsCollection);
    settingsColl.doc(profileManagementDoc).update(_profileManagement.toJson());
  }

  ///*********************** Storage ****************************///
  Future<void> uploadLogoImage(File image) async {
    Reference ref = _fst.ref(profileStorageDir).child('logo.png');
    await ref.putFile(image);
  }

  Future<String> getLogoImage() async {
    Reference ref = _fst.ref(profileStorageDir).child('logo.png');
    var refStr = 'notFound';
    try {
      refStr = await ref.getDownloadURL();
    } catch (error) {
      return refStr;
    }
    return refStr;
  }

  Future<void> deleteLogoImage() async {
    Reference ref = _fst.ref(profileStorageDir).child('logo.png');
    return await ref.delete();
  }

  Future<void> uploadCoverImage(File image) async {
    Reference ref = _fst.ref(profileStorageDir).child('coverPhoto.png');
    await ref.putFile(image);
  }

  Future<String> getCoverImage() async {
    Reference ref = _fst.ref(profileStorageDir).child('coverPhoto.png');
    var refStr = 'notFound';
    try {
      refStr = await ref.getDownloadURL();
    } catch (error) {
      return refStr;
    }
    return refStr;
  }

  Future<void> deleteCoverImage() async {
    Reference ref = _fst.ref(profileStorageDir).child('coverPhoto.png');
    return await ref.delete();
  }

  Future<void> uploadWPImages(List<File> imageList) async {
    var uuid = Uuid();
    for (File image in imageList) {
      Reference ref =
          _fst.ref(profileWPStorageDir).child('WP${uuid.v4()}_image.png');
      await ref.putFile(image);
    }
  }

  Future<Map<String, String>> getWPImages() async {
    /// Return map of file name --> url
    Map<String, String> filesMap = {};
    Reference ref = _fst.ref(profileWPStorageDir);
    var refStr = 'notFound';
    try {
      await ref.listAll().then(
            (res) async => {
              for (var imageRef in res.items)
                {
                  refStr = await imageRef.getDownloadURL(),
                  filesMap[imageRef.name] = refStr,
                },
            },
          );
    } catch (error) {
      return {};
    }
    return filesMap;
  }

  Future<void> deleteWPImage(String image) async {
    Reference ref = _fst.ref(profileStorageDir).child(image);
    return await ref.delete();
  }
}
