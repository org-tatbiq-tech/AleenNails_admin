import 'dart:async';
import 'dart:io';

import 'package:appointments/data_types/settings_components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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
  Future<void> uploadLogoImage(File image) async {
    Reference ref = _fst.ref(profileStorageDir).child('logo.png');
    await ref.putFile(image);
    // Updating logo path
    Reference profRef = _fst.ref(profileStorageDir).child('logo_600x600.png');
    final refStr = await profRef.getDownloadURL();
    _fs.collection(settingsCollection).doc('profile').update({
      'media': {'logo': refStr}
    });
  }

  String getLogoImageUrl() {
    return _profileManagement.profileMedia.logoPath!;
    // Reference ref = _fst.ref(profileStorageDir).child('logo_600x600.png');
    // var refStr = 'notFound';
    // try {
    //   refStr = await ref.getDownloadURL();
    // } catch (error) {
    //   return refStr;
    // }
    // return refStr;
  }

  Future<void> deleteLogoImage() async {
    Reference ref = _fst.ref(profileStorageDir).child('logo_600x600.png');
    // Deleting logo path
    _fs
        .collection(settingsCollection)
        .doc('profile')
        .update({'logo': FieldValue.delete()});
    return await ref.delete();
  }

  Future<void> uploadCoverImage(File image) async {
    Reference ref = _fst.ref(profileStorageDir).child('coverPhoto_600x600.png');
    await ref.putFile(image);
    // Updating logo path
    Reference profRef =
        _fst.ref(profileStorageDir).child('coverPhoto_600x600.png');
    final refStr = await profRef.getDownloadURL();
    _fs.collection(settingsCollection).doc('profile').update({'cover': refStr});
  }

  String getCoverImageUrl() {
    return _profileManagement.profileMedia.coverPath!;
    // Reference ref = _fst.ref(profileStorageDir).child('coverPhoto_600x600.png');
    // var refStr = 'notFound';
    // try {
    //   refStr = await ref.getDownloadURL();
    // } catch (error) {
    //   return refStr;
    // }
    // return refStr;
  }

  Future<void> deleteCoverImage() async {
    Reference ref = _fst.ref(profileStorageDir).child('coverPhoto_600x600.png');
    _fs
        .collection(settingsCollection)
        .doc('profile')
        .update({'cover': FieldValue.delete()});
    return await ref.delete();
  }

  Future<void> uploadWPImages(List<File> imageList) async {
    var uuid = const Uuid();
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
    Reference ref = _fst.ref(profileWPStorageDir).child(image);
    return await ref.delete();
  }
}
