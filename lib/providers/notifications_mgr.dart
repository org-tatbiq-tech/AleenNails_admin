import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data_types/components.dart';

const adminsCollection = 'admins';
const adminNotificationsCollection = 'notifications';

class NotificationsMgr extends ChangeNotifier {
  ///*************************** Firestore **********************************///
  final FirebaseFirestore _fs = FirebaseFirestore.instance;

  static const int kNotificationLimit = 100;

  ///************************* Notifications *******************************///
  List<NotificationData> _notifications = []; // Holds all admin notifications
  bool initialized = false; // Don't download notifications unless required
  StreamSubscription<QuerySnapshot>? _notificationsSub;

  void resetNotifications() {
    _notificationsSub?.cancel();
    _notificationsSub = null;
    _notifications = [];
    initialized = false;
  }

  List<NotificationData> getNotifications(adminEmail) {
    if (!initialized && adminEmail != null) {
      initialized = true;
      downloadNotifications(adminEmail);
    }
    return _notifications;
  }

  Future<void> downloadNotifications(adminEmail) async {
    /// Download Notifications from DB
    // query preparation
    var query = _fs
        .collection(adminsCollection)
        .doc(adminEmail)
        .collection(adminNotificationsCollection)
        .orderBy('creationDate', descending: true)
        .limit(kNotificationLimit);

    _notificationsSub = query.snapshots().listen(
      (snapshot) async {
        _notifications = [];
        if (snapshot.docs.isEmpty) {
          // No data to show - notifying listeners for empty clients list.
          notifyListeners();
          return;
        }

        // Notifications collection has data to show
        for (var document in snapshot.docs) {
          var data = document.data();
          data['id'] = document.id;
          _notifications.add(NotificationData.fromJson(data));
        }
        notifyListeners();
      },
    );
  }

  Future<void> markNotificationOpened(notificationId, adminEmail) async {
    await _fs
        .collection(adminsCollection)
        .doc(adminEmail)
        .collection(adminNotificationsCollection)
        .doc(notificationId)
        .update({'isOpened': true});
    setSelectedNotification(notificationId);
  }

  Future<String> getNotificationType(notificationId, adminEmail) async {
    var notificationResult = await _fs
        .collection(adminsCollection)
        .doc(adminEmail)
        .collection(adminNotificationsCollection)
        .doc(notificationId)
        .get();
    return notificationResult.data()!['data']['category'];
  }

  Future<void> deleteNotification(notificationId, adminEmail) async {
    if (notificationId != null) {
      await _fs
          .collection(adminsCollection)
          .doc(adminEmail)
          .collection(adminNotificationsCollection)
          .doc(notificationId)
          .delete();
      if (notificationId == selectedNotificationId) {
        setSelectedNotification(null);
      }
    }
  }

  /// notification selection
  String? selectedNotificationId;
  void setSelectedNotification(String? notificationId) {
    selectedNotificationId = notificationId;
  }
}
