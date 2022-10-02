import 'dart:async';

import 'package:appointments/data_types/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Appointments manager provider
/// Managing and handling appointments data and DB interaction

///*************************** Naming **********************************///
const appointmentsCollection = 'appointments';

class AppointmentsMgr extends ChangeNotifier {
  AppointmentsMgr() {
    DateTime now = DateTime.now();
    _selectedDay = DateTime(now.year, now.month, now.day);
  }

  ///*************************** Firestore **********************************///
  final FirebaseFirestore _fs = FirebaseFirestore.instance;
  final FirebaseAuth _fa = FirebaseAuth.instance;

  ///************************* Appointments ********************************///
  late DateTime _selectedDay; // Holding current day details

  DateTime get selectedDay {
    return _selectedDay;
  }

  setSelectedDay(DateTime value) async {
    _selectedDay = value;
    print('setting selected day');
    print(_selectedDay);
    await downloadAppointments();
  }

  List<Appointment> _appointments = []; // Holds all DB appointments
  bool initialized = false; // Don't download Appointments unless required
  StreamSubscription<QuerySnapshot>? _appointmentsSub;

  List<Appointment> get appointments {
    if (!initialized) {
      initialized = true;
      downloadAppointments();
    }
    return _appointments;
  }

  Future<void> downloadAppointments() async {
    /// Download appointments from DB
    // query preparation

    var query = _fs
        .collection(appointmentsCollection)
        .where('date', isGreaterThanOrEqualTo: _selectedDay)
        .where(
          'date',
          isLessThanOrEqualTo: DateTime(
            _selectedDay.year,
            _selectedDay.month,
            _selectedDay.day + 1,
          ),
        );

    _appointmentsSub = query.snapshots().listen(
      (snapshot) async {
        _appointments = [];
        if (snapshot.docs.isEmpty) {
          // No data to show - notifying listeners for empty appointments list.
          notifyListeners();
          return;
        }

        // Appointment collection has data to show for this day
        for (var document in snapshot.docs) {
          var data = document.data();
          data['id'] = document.id;
          _appointments.add(Appointment.fromJson(data));
        }
        notifyListeners();
      },
    );
  }

  Future<void> submitNewAppointment(Appointment newAppointment) async {
    /// Submitting new appointment - update DB
    CollectionReference appointmentsColl =
        _fs.collection(appointmentsCollection);
    appointmentsColl.add(newAppointment.toJson());
  }

  /// Appointment selection
  late Appointment selectedAppointment;
  bool isSelectedAppointmentLoaded = false;

  Future<void> setSelectedAppointment(
      {Appointment? appointment, String? appointmentID}) async {
    isSelectedAppointmentLoaded = false;
    if (appointment != null) {
      // Appointment is provided, no need to download
      selectedAppointment = appointment;
      isSelectedAppointmentLoaded = true;
    } else {
      // download appointment
      _fs.collection(appointmentsCollection).doc(appointmentID).get().then(
            (value) => {
              if (value.data() != null)
                {
                  selectedAppointment = Appointment.fromJson(value.data()!),
                  isSelectedAppointmentLoaded = true,
                },
            },
          );
      notifyListeners();
    }
  }
}
