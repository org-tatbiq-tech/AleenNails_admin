import 'package:appointments/data_types/components.dart';
import 'package:appointments/data_types/macros.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// App data is a provider which holds and manages all application data
/// in addition, the interaction between widgets through notifications.

///*************************** Naming **********************************///
const appointmentCollection = 'appointments';
const clientsCollection = 'clients';
const servicesCollection = 'services';

class AppData extends ChangeNotifier {
  ///*************************** Firestore **********************************///
  final FirebaseFirestore _fs = FirebaseFirestore.instance;
  final FirebaseAuth _fa = FirebaseAuth.instance;

  ///************* appointments *************///
  late Appointment selectedAppointment;
  bool isSelectedAppointmentLoaded = false;

  Future<void> submitNewAppointment(Appointment newAppointment) async {
    /// Submitting new appointment in appointments list
    CollectionReference appointments = _fs.collection(appointmentCollection);
    appointments.add(newAppointment.toJson());
  }

  ///************* Services *************///
  late Service selectedService;
  bool isSelectedServiceLoaded = false;

  List<Client> allContacts = [];
  List<Client> filteredContacts = [];
  AppData() {
    Client contact = Client('10', 'Saeed', '0543103540', 'Haifa', 'email');
    Client contact2 = Client('19129', 'Ahmad', '058955005', 'Bagdad', '1');
    allContacts = [contact, contact2, contact, contact2, contact, contact2];
    filteredContacts = [
      contact,
      contact2,
      contact,
      contact2,
      contact,
      contact2
    ];
    selectedAppointment = Appointment(
      'id',
      Status.waiting,
      'business',
      'Ahmad Manna',
      '0505800955',
      '919',
      DateTime.now(),
      DateTime.now(),
      'nothing',
      [],
    );

    selectedService = Service(
      'id',
      'service1',
      100.00,
      const Duration(hours: 1),
      0xFFb733,
      'desc',
      'imageFBS',
      'Message',
      false,
    );
  }

  List<String> contacts_ = [
    'Action',
    'FPS',
    'Shooter',
    'strategy',
    'saeed',
  ];

  List<String> getContacts_() {
    return contacts_;
  }

  // List<Contact> getContacts() {
  //   return [contact, contact, contact, contact, contact, contact];
  // }

  void getFiltered(String filter) {
    filteredContacts = allContacts.where((element) {
      String result = element.name.toLowerCase();
      String input = filter.toLowerCase();
      return result.contains(input);
    }).toList();
    notifyListeners();
  }
}
