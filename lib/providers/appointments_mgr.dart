import 'dart:async';

import 'package:appointments/data_types/components.dart';
import 'package:appointments/providers/clients_mgr.dart';
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

  Future<void> setSelectedDay(DateTime value) async {
    _selectedDay = value;
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
    /// Submitting new appointment - update Appointments DB
    CollectionReference appointmentsColl =
        _fs.collection(appointmentsCollection);
    CollectionReference clientsAppointments = _fs
        .collection(clientsCollection)
        .doc(newAppointment.clientDocID)
        .collection(clientsAppointmentsCollection);
    appointmentsColl.add(newAppointment.toJson()).then((docRef) => {
          /// Update client's appointments collections
          newAppointment.id = docRef.id,
          clientsAppointments
              .add(ClientAppointment.fromAppointment(newAppointment).toJson()),
        });
  }

  Future<void> updateAppointment(Appointment updatedAppointment) async {
    /// Update existing Appointment - update DB
    CollectionReference appointmentsColl =
        _fs.collection(appointmentsCollection);
    var data = updatedAppointment.toJson();
    appointmentsColl.doc(updatedAppointment.id).update(data);
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
      Map<String, dynamic>? data;
      _fs.collection(appointmentsCollection).doc(appointmentID).get().then(
            (value) => {
              data = value.data(),
              if (data != null)
                {
                  data!['id'] = value.id,
                  selectedAppointment = Appointment.fromJson(data!),
                  isSelectedAppointmentLoaded = true,
                },
              notifyListeners(),
            },
          );
    }
  }
}
