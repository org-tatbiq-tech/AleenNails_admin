import 'dart:async';
import 'dart:io';

import 'package:appointments/data_types/settings_components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Settings manager provider
/// Managing and handling settings data and DB interaction

///*************************** Naming **********************************///
const settingsCollection = 'settings';
const clientsCollection = 'clients';
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
  final FirebaseAuth _fa = FirebaseAuth.instance;

  ///************************* Settings *******************************///

  Future<void> saveToken(String token) async {
    // Saving token into store document
    await _fs.collection(clientsCollection).doc(_fa.currentUser?.uid).update(
      {
        'tokens': FieldValue.arrayUnion(
          [token],
        ),
      },
    );
  }

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
    businessInfo: BusinessInfoComp.fromJson({}),
    profileMedia: ProfileMedia.fromJson({}),
  ); // Holds profile details
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
  /// LOGO
  Future<void> uploadLogoImage(File image) async {
    Reference ref = _fst.ref(profileStorageDir).child('logo.png');
    await ref.putFile(image);

    // Image file is already resized, updating path and url
    String refURL = await ref.getDownloadURL();
    await _fs.collection(settingsCollection).doc('profile').update(
      {
        'media.logoURL': refURL,
        'media.logoPath': ref.name,
      },
    );
    _profileManagement.profileMedia.logoURL = refURL;
    notifyListeners();
  }

  Future<void> deleteLogoImage() async {
    Reference ref = _fst.ref(profileStorageDir).child('logo.png');
    // Deleting logo path and URL
    _fs.collection(settingsCollection).doc('profile').update(
      {
        'media.logoURL': FieldValue.delete(),
        'media.logoPath': FieldValue.delete()
      },
    );
    notifyListeners();
    await ref.delete();
  }

  /// COVER
  Future<void> uploadCoverImage(File image) async {
    Reference ref = _fst.ref(profileStorageDir).child('cover.png');
    await ref.putFile(image);

    // Image file is already resized, updating path and url
    String refURL = await ref.getDownloadURL();
    await _fs.collection(settingsCollection).doc('profile').update(
      {
        'media.coverURL': refURL,
        'media.coverPath': ref.name,
      },
    );
    _profileManagement.profileMedia.coverURL = refURL;
    notifyListeners();
  }

  Future<void> deleteCoverImage() async {
    Reference ref = _fst.ref(profileStorageDir).child('cover.png');
    // Deleting cover path and URL
    _fs.collection(settingsCollection).doc('profile').update(
      {
        'media.coverURL': FieldValue.delete(),
        'media.coverPath': FieldValue.delete()
      },
    );
    await ref.delete();
    notifyListeners();
  }

  /// WP
  Future<void> uploadWPImages(Map<String, File> imagesMap) async {
    Map<String, String> filesMap = {};
    for (MapEntry imageEntry in imagesMap.entries) {
      String fileName = 'WP${imageEntry.key}_image';
      Reference ref = _fst.ref(profileWPStorageDir).child('$fileName.png');
      await ref.putFile(imageEntry.value);
      String imageUrl = await ref.getDownloadURL();
      filesMap['media.wp.$fileName'] = imageUrl;
    }
    await _fs.collection(settingsCollection).doc('profile').update(filesMap);
  }

  Future<void> deleteWPImage(String image) async {
    String fileName = 'WP${image}_image';
    if (image.endsWith('_image')) {
      fileName = image;
    }
    Reference ref = _fst.ref(profileWPStorageDir).child('$fileName.png');
    await _fs.collection(settingsCollection).doc('profile').update({
      'media.wp.$fileName': FieldValue.delete(),
    });
    await ref.delete();
  }
}
