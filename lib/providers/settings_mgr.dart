import 'dart:async';

import 'package:appointments/data_types/settings_components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Settings manager provider
/// Managing and handling settings data and DB interaction

///*************************** Naming **********************************///
const settingsCollection = 'settings';
const scheduleManagementDoc = 'scheduleManagement';
const profileManagementDoc = 'profile';

class SettingsMgr extends ChangeNotifier {
  SettingsMgr() {
    downloadScheduleManagement();
    downloadProfileManagement();
  }

  ///*************************** Firestore **********************************///
  final FirebaseFirestore _fs = FirebaseFirestore.instance;
  final FirebaseAuth _fa = FirebaseAuth.instance;

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
}
