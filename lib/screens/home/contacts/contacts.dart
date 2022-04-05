import 'package:appointments/widget/contact.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../localization/language/languages.dart';
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

  Widget getContactCard(BuildContext context, Contact contact) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.fromLTRB(0, 0, 0, rSize(20)),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
        rSize(15),
      )),
      child: ListTile(
        onTap: () => Navigator.pushNamed(context, '/contactDetails'),
        subtitle: Text(
          contact.contactPhone,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(fontSize: rSize(16)),
        ),
        trailing: IconTheme(
          data: Theme.of(context).primaryIconTheme,
          child: Icon(
            Icons.chevron_right,
            size: rSize(25),
          ),
        ),
        leading: CircleAvatar(
          radius: rSize(28),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Text(
            contact.contactName[0].toUpperCase() +
                contact.contactName[1].toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(fontSize: rSize(20)),
          ),
        ),
        title: Text(
          contact.contactName,
          style: Theme.of(context)
              .textTheme
              .headline1
              ?.copyWith(fontSize: rSize(20)),
        ),
      ),
    );
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
    return Column(
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
              return getContactCard(context, contacts[index]);
            },
          ),
        ),
      ],
    );
  }
}
