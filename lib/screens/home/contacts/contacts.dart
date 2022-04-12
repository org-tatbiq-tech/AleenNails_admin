import 'package:appointments/utils/data_types.dart';
import 'package:appointments/widget/contact_card.dart';
import 'package:flutter/material.dart';
import '../../../utils/layout.dart';

//class needs to extend StatefulWidget since we need to make changes to the bottom app bar according to the user clicks
class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ContactsState();
  }
}

class ContactsState extends State<Contacts> {
  bool clickedCentreFAB =
      false; //boolean used to handle container animation which expands from the FAB
  int selectedIndex =
      0; //to handle which item is currently selected in the bottom app bar
  String text = "Contacts";

  //call this method on click of each bottom app bar item to update the screen
  void updateTabSelection(int index, String buttonText) {
    setState(() {
      selectedIndex = index;
      text = buttonText;
    });
  }

  @override
  Widget build(BuildContext context) {
    Contact contact = Contact('Saeed', '0543103540', 'Haifa');
    List<Contact> contacts = [
      contact,
      contact,
      contact,
      contact,
      contact,
      contact
    ];
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                vertical: rSize(20),
                horizontal: rSize(20),
              ),
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return ContactCard(
                  contactCardProps: ContactCardProps(
                    contactDetails: contacts[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
