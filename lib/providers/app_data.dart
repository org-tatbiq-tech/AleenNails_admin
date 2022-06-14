import 'package:appointments/data_types/components.dart';
import 'package:appointments/data_types/macros.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// App data is a provider which holds and manages all application data
/// in addition, the interaction between widgets through notifications.

class AppData extends ChangeNotifier {
  ///************* appointments *************///
  late Appointment selectedAppointment;
  bool isSelectedAppointmentLoaded = false;

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
        'nothing', []);

    selectedService = Service(
      'id',
      'service1',
      100.00,
      const Duration(hours: 1),
      Colors.red.toString(),
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
