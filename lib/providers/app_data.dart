import 'package:flutter/cupertino.dart';

import '../utils/data_types.dart';

class AppData extends ChangeNotifier {
  List<Client> allContacts = [];
  List<Client> filteredContacts = [];
  AppData() {
    Client contact = Client(
      name: 'Saeed',
      phone: '0543103540',
      address: 'Haifa',
    );
    Client contact2 = Client(
      name: 'Ahmad',
      phone: '058955005',
      address: 'Bagdad',
    );
    allContacts = [contact, contact2, contact, contact2, contact, contact2];
    filteredContacts = [
      contact,
      contact2,
      contact,
      contact2,
      contact,
      contact2
    ];
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
      String result = element.name!.toLowerCase();
      String input = filter.toLowerCase();
      return result.contains(input);
    }).toList();
    notifyListeners();
  }
}
