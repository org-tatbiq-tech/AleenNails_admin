import 'package:appointments/data_types/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Appointments manager provider
/// Managing and handling appointments data and DB interaction

///*************************** Naming **********************************///
const appointmentsCollection = 'appointments';

class AppointmentsMgr extends ChangeNotifier {
  ///*************************** Firestore **********************************///
  final FirebaseFirestore _fs = FirebaseFirestore.instance;
  final FirebaseAuth _fa = FirebaseAuth.instance;

  ///************* appointments *************///
  late Appointment selectedAppointment;
  bool isSelectedAppointmentLoaded = false;

  Future<void> submitNewAppointment(Appointment newAppointment) async {
    /// Submitting new appointment - update DB
    CollectionReference appointments = _fs.collection(appointmentsCollection);
    appointments.add(newAppointment.toJson());
  }
}
