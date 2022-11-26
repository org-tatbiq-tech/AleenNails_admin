import 'dart:async';
import 'dart:io';

import 'package:appointments/data_types/settings_components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
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
        print('Notigy dsadjsjadlka');
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
    // Firstly delete logo path, so image won't be available.
    _fs.collection(settingsCollection).doc('profile').update(
      {
        'media.logoURL': FieldValue.delete(),
        'media.logoPath': FieldValue.delete(),
      },
    );
    final metaData = SettableMetadata(
      customMetadata: {
        'type': 'logo',
      },
    );
    await ref.putFile(image, metaData);
  }

  Future<String> getLogoImageUrl() async {
    if (_profileManagement.profileMedia.logoURL!.isNotEmpty) {
      return _profileManagement.profileMedia.logoURL!;
    } else if (_profileManagement.profileMedia.logoPath!.isNotEmpty) {
      // Logo path exist, but not URL, need to download and update
      Reference fileRef = _fst.ref(profileStorageDir).child('logo_600x600.png');
      final refStr = await fileRef.getDownloadURL();
      _profileManagement.profileMedia.logoURL = refStr;
      _fs.collection(settingsCollection).doc('profile').update(
        {'media.logoURL': refStr},
      );
      return _profileManagement.profileMedia.logoURL!;
    }
    return '';
  }

  Future<void> deleteLogoImage() async {
    Reference ref = _fst.ref(profileStorageDir).child('logo_600x600.png');
    // Deleting logo path and URL
    _fs.collection(settingsCollection).doc('profile').update(
      {
        'media.logoURL': FieldValue.delete(),
        'media.logoPath': FieldValue.delete()
      },
    );
    return await ref.delete();
  }

  /// COVER
  Future<void> uploadCoverImage(File image) async {
    Reference ref = _fst.ref(profileStorageDir).child('cover.png');
    _fs.collection(settingsCollection).doc('profile').update(
      {
        'media.coverURL': FieldValue.delete(),
        'media.coverPath': FieldValue.delete(),
      },
    );

    // Create file metadata to update proper document
    final metaData = SettableMetadata(
      customMetadata: {
        'type': 'cover',
      },
    );
    await ref.putFile(image, metaData);
  }

  Future<String> getCoverImageUrl() async {
    if (_profileManagement.profileMedia.coverURL!.isNotEmpty) {
      return _profileManagement.profileMedia.coverURL!;
    } else if (_profileManagement.profileMedia.coverPath!.isNotEmpty) {
      // Cover path exist, but not URL, need to download and update
      Reference fileRef =
          _fst.ref(profileStorageDir).child('cover_600x600.png');
      final refStr = await fileRef.getDownloadURL();
      _profileManagement.profileMedia.logoURL = refStr;
      _fs.collection(settingsCollection).doc('profile').update(
        {'media.coverURL': refStr},
      );
      return _profileManagement.profileMedia.logoURL!;
    }
    return '';
  }

  Future<void> deleteCoverImage() async {
    Reference ref = _fst.ref(profileStorageDir).child('cover_600x600.png');
    // Deleting cover path and URL
    _fs.collection(settingsCollection).doc('profile').update(
      {
        'media.coverURL': FieldValue.delete(),
        'media.coverPath': FieldValue.delete()
      },
    );
    return await ref.delete();
  }

  /// WP
  Future updateResizedWPUrls(List<String> newFiles) async {
    /// Updating profile work place images urls as individual process
    /// List of names of new files added
    Map<String, String> filesMap = {};
    print('upadting new files');
    print(newFiles);
    while (true) {
      try {
        for (String fileName in newFiles) {
          print('file $fileName');
          Reference fileRef =
              _fst.ref(profileWPStorageDir).child('${fileName}_600x600.png');
          final refStr = await fileRef.getDownloadURL();
          filesMap[fileRef.name] = refStr;
        }
        print('updated');
        print(filesMap);
        _fs.collection(settingsCollection).doc('profile').update(
          {'media.wp': filesMap},
        );
        _profileManagement.profileMedia.wpPhotosURLsMap = filesMap;
        break;
      } catch (e) {
        sleep(const Duration(seconds: 2));
        filesMap = {};
      }
    }
  }

  Future<void> uploadWPImages(List<File> imageList) async {
    var uuid = const Uuid();
    List<String> newFiles = [];
    for (File image in imageList) {
      String fileName = 'WP${uuid.v4()}_image';
      Reference ref = _fst.ref(profileWPStorageDir).child('$fileName.png');
      await ref.putFile(image);
      newFiles.add(fileName);
    }
    print('updating WP');
    updateResizedWPUrls(newFiles);
    print('continued');
    // compute(updateResizedWPUrls, newFiles);
  }

  Map<String, String> getWPImagesUrls() {
    /// Return map of file name --> url
    return _profileManagement.profileMedia.wpPhotosURLsMap!;
  }

  Future<void> deleteWPImage(String image) async {
    Reference ref = _fst.ref(profileWPStorageDir).child(image);
    await ref.delete();
    ref = _fst.ref(profileWPStorageDir);
    // Create and save map of file name --> url
    Map<String, String> filesMap = {};
    var refStr = '';
    ref.listAll().then(
          (res) async => {
            for (var imageRef in res.items)
              {
                refStr = await imageRef.getDownloadURL(),
                filesMap[imageRef.name] = refStr,
              },
            _fs
                .collection(settingsCollection)
                .doc('profile')
                .update({'media.wp': filesMap}),
          },
        );
  }
}
