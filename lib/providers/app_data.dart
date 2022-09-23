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
    Client contact = Client(
      id: '10',
      fullName: 'Saeed',
      phone: '0543103540',
      address: 'Haifa',
      creationDate: DateTime.now(),
      email: 'das@gma.com',
    );
    Client contact2 = Client(
      id: '101',
      fullName: 'Ahmad',
      phone: '05431233540',
      address: 'Israel',
      email: 'adjsa@fm.com',
      creationDate: DateTime.now(),
    );
    allContacts = [contact, contact2, contact, contact2, contact, contact2];
    filteredContacts = [
      contact,
      contact2,
    ];
    selectedAppointment = Appointment(
      id: 'id',
      clientName: 'ahmad',
      clientDocID: '123231',
      clientPhone: '0505800955',
      creationDate: DateTime.now(),
      creator: 'Business',
      date: DateTime.now(),
      paymentStatus: PaymentStatus.paid,
      services: [],
      status: Status.confirmed,
      notes: 'No notes',
    );

    selectedService = Service(
      id: 'id',
      name: 'service1',
      cost: 100.00,
      duration: const Duration(hours: 1),
      colorID: 0xFF38713B,
      description: 'desc',
      imageFBS: ['imageFBS'],
      noteMessage: 'Message',
      onlineBooking: false,
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
      String result = element.fullName.toLowerCase();
      String input = filter.toLowerCase();
      return result.contains(input);
    }).toList();
    notifyListeners();
  }
}
