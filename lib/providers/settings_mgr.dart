import 'dart:async';
import 'dart:io';

import 'package:appointments/data_types/macros.dart';
import 'package:appointments/data_types/settings_components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// Settings manager provider
/// Managing and handling settings data and DB interaction

///*************************** Naming **********************************///
const settingsCollection = 'settings';
const clientsCollection = 'clients';
const scheduleManagementDoc = 'scheduleManagement';
// const unavailabilitiesCollection = 'unavailability';
const scheduleOverridesCollection = 'scheduleOverrides';
const bookingSettingsDoc = 'bookingSettings';
const profileManagementDoc = 'profile';
const profileStorageDir = 'profile';
const profileWPStorageDir = 'profile/workplace';

class SettingsMgr extends ChangeNotifier {
  SettingsMgr() {
    downloadScheduleManagement();
    downloadProfileManagement();
    downloadBookingSettings();
  }

  ///*************************** Firestore **********************************///
  final FirebaseFirestore _fs = FirebaseFirestore.instance;
  final FirebaseStorage _fst = FirebaseStorage.instance;
  final FirebaseAuth _fa = FirebaseAuth.instance;

  ///************************* Settings *******************************///

  ///*********************** Schedule management ****************************///
  // bool initializedUnavailabilities =
  //     false; // Don't download unavailabilities unless required
  // List<UnavailabilityComp> _unavailabilities =
  //     []; // Holds all DB unavailabilities
  // StreamSubscription<QuerySnapshot>? _unavailabilitiesSub;
  // List<UnavailabilityComp> get unavailabilities {
  //   if (!initializedUnavailabilities) {
  //     initializedUnavailabilities = true;
  //     downloadUnavailabilities();
  //   }
  //   return _unavailabilities;
  // }
  //
  // Future<void> downloadUnavailabilities() async {
  //   /// Download Unavailabilities from DB
  //   var query = _fs
  //       .collection(settingsCollection)
  //       .doc(scheduleManagementDoc)
  //       .collection(unavailabilitiesCollection)
  //       .orderBy('startTime', descending: false);
  //
  //   _unavailabilitiesSub = query.snapshots().listen(
  //     (snapshot) async {
  //       _unavailabilities = [];
  //       if (snapshot.docs.isEmpty) {
  //         // No data to show - notifying listeners for empty unavailabilities list.
  //         notifyListeners();
  //         return;
  //       }
  //
  //       // Unavailabilities collection has data to show
  //       for (var document in snapshot.docs) {
  //         var data = document.data();
  //         data['id'] = document.id;
  //         _unavailabilities.add(UnavailabilityComp.fromJson(data));
  //       }
  //       notifyListeners();
  //     },
  //   );
  // }
  //
  // Future<void> submitNewUnavailability(
  //     UnavailabilityComp newUnavailability) async {
  //   CollectionReference unavailabilitiesColl = _fs
  //       .collection(settingsCollection)
  //       .doc(scheduleManagementDoc)
  //       .collection(unavailabilitiesCollection);
  //
  //   /// Submitting new Unavailability - update DB
  //   await unavailabilitiesColl.add(newUnavailability.toJson());
  // }
  //
  // Future<void> deleteUnavailability(UnavailabilityComp unavailability) async {
  //   CollectionReference unavailabilitiesColl = _fs
  //       .collection(settingsCollection)
  //       .doc(scheduleManagementDoc)
  //       .collection(unavailabilitiesCollection);
  //
  //   /// Submitting new Unavailability - update DB
  //   await unavailabilitiesColl.doc(unavailability.id).delete();
  // }

  bool initializedScheduleOverrides =
      false; // Don't download scheduleOverrides unless required
  List<WorkingDay> _scheduleOverrides = []; // Holds all DB scheduleOverrides
  StreamSubscription<QuerySnapshot>? _scheduleOverridesSub;
  List<WorkingDay> get scheduleOverrides {
    if (!initializedScheduleOverrides) {
      initializedScheduleOverrides = true;
      downloadScheduleOverrides();
    }
    return _scheduleOverrides;
  }

  Future<void> downloadScheduleOverrides() async {
    /// Download scheduleOverrides from DB
    var query = _fs
        .collection(settingsCollection)
        .doc(scheduleManagementDoc)
        .collection(scheduleOverridesCollection)
        .orderBy('date', descending: false);

    _scheduleOverridesSub = query.snapshots().listen(
      (snapshot) async {
        _scheduleOverrides = [];
        if (snapshot.docs.isEmpty) {
          // No data to show - notifying listeners for empty scheduleOverrides list.
          notifyListeners();
          return;
        }

        // scheduleOverrides collection has data to show
        for (var document in snapshot.docs) {
          var data = document.data();
          data['id'] = document.id;
          _scheduleOverrides.add(WorkingDay.fromJson(data));
        }
        notifyListeners();
      },
    );
  }

  Future<void> submitScheduleOverride(WorkingDay newScheduleOverride) async {
    CollectionReference scheduleOverridesColl = _fs
        .collection(settingsCollection)
        .doc(scheduleManagementDoc)
        .collection(scheduleOverridesCollection);

    /// Submitting new scheduleOverride - update DB
    if (newScheduleOverride.id != null && newScheduleOverride.id != '') {
      await scheduleOverridesColl
          .doc(newScheduleOverride.id)
          .set(newScheduleOverride.toJson());
    } else {
      await scheduleOverridesColl.add(newScheduleOverride.toJson());
    }
  }

  Future<void> deleteScheduleOverride(WorkingDay scheduleOverride) async {
    CollectionReference scheduleOverridesColl = _fs
        .collection(settingsCollection)
        .doc(scheduleManagementDoc)
        .collection(scheduleOverridesCollection);

    /// Submitting new scheduleOverride - update DB
    await scheduleOverridesColl.doc(scheduleOverride.id).delete();
  }

  bool checkSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) {
      return false;
    }

    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  WorkingDay getWorkingDay(DateTime date) {
    WorkingDay? workingDay =
        scheduleOverrides.firstWhereOrNull((wd) => checkSameDay(wd.date, date));
    if (workingDay == null) {
      WorkingDay defaultDay = scheduleManagement
          .workingDays!.schedule![DateFormat('EEEE').format(date)]!;
      workingDay = WorkingDay.fromJson(defaultDay.toJson());
      workingDay.date = date;
      workingDay.id = '';
    }
    return workingDay!;
  }

  ScheduleManagement _scheduleManagement =
      ScheduleManagement(); // Holds Working days
  bool initializedScheduleManagement =
      false; // Don't download Schedule management settings unless required
  StreamSubscription<DocumentSnapshot>? _scheduleManagementSub;

  ScheduleManagement get scheduleManagement {
    if (_scheduleManagementSub != null && _scheduleManagementSub!.isPaused) {
      _scheduleManagementSub!.resume();
    }

    if (!initializedScheduleManagement) {
      initializedScheduleManagement = true;
      downloadScheduleManagement();
    }
    return _scheduleManagement;
  }

  void pauseScheduleManagement() {
    if (_scheduleManagementSub != null && !_scheduleManagementSub!.isPaused) {
      _scheduleManagementSub!.pause();
    }
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
    DocumentSnapshot doc = await settingsColl.doc(scheduleManagementDoc).get();
    if (doc.exists) {
      settingsColl
          .doc(scheduleManagementDoc)
          .update(_scheduleManagement.toJson());
    } else {
      settingsColl.doc(scheduleManagementDoc).set(_scheduleManagement.toJson());
    }
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
    if (_profileManagementSub != null && _profileManagementSub!.isPaused) {
      _profileManagementSub!.resume();
    }
    if (!initializedProfileManagement) {
      initializedProfileManagement = true;
      downloadProfileManagement();
    }
    return _profileManagement;
  }

  void pauseProfileManagement() {
    if (_profileManagementSub != null && !_profileManagementSub!.isPaused) {
      _profileManagementSub!.pause();
    }
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
    DocumentSnapshot doc = await settingsColl.doc(profileManagementDoc).get();
    if (doc.exists) {
      settingsColl
          .doc(profileManagementDoc)
          .update(_profileManagement.toJson());
    } else {
      settingsColl.doc(profileManagementDoc).set(_profileManagement.toJson());
    }
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

  ///*********************** Booking settings ****************************///
  BookingSettingComp bookingSettingComp = BookingSettingComp();
  Future<void> saveBookingSettings(
      BookingSettingComp bookingSettingComp) async {
    await _fs
        .collection(settingsCollection)
        .doc(bookingSettingsDoc)
        .set(bookingSettingComp.toJson());
    await downloadBookingSettings();
  }

  Future<void> downloadBookingSettings() async {
    var query = _fs.collection(settingsCollection);
    DocumentSnapshot doc = await query.doc(bookingSettingsDoc).get();
    if (doc.exists) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      bookingSettingComp = BookingSettingComp.fromJson(data);
    } else {
      bookingSettingComp = BookingSettingComp();
    }
  }
}
