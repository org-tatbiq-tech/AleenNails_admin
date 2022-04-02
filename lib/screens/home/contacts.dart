import 'package:appointments/widget/contact.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../localization/language/languages.dart';
import '../../utils/layout.dart';

//class needs to extend StatefulWidget since we need to make changes to the bottom app bar according to the user clicks
class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ContactsState();
  }
}

class ContactsState extends State<Contacts> {
  bool clickedCentreFAB = false; //boolean used to handle container animation which expands from the FAB
  int selectedIndex = 0; //to handle which item is currently selected in the bottom app bar
  String text = "Contacts";

  //call this method on click of each bottom app bar item to update the screen
  void updateTabSelection(int index, String buttonText) {
    setState(() {
      selectedIndex = index;
      text = buttonText;
    });
  }

  Widget getContactName(Contact contact) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        children: [
          Icon(
            FontAwesomeIcons.userAlt,
            color: Theme.of(context).colorScheme.secondary,
            size: rSize(22),
          ),
          Wrap(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: rSize(10), vertical: rSize(5)),
                child: Text(
                  Languages.of(context)!.labelContactName + ':',
                  style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: rSize(25)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: rSize(10), vertical: rSize(5)),
                child: Text(
                  contact.contactName,
                  style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: rSize(22)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getContactPhone(Contact contact) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        children: [
          Icon(
            FontAwesomeIcons.phoneAlt,
            color: Theme.of(context).colorScheme.secondary,
            size: rSize(22),
          ),
          Wrap(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: rSize(10), vertical: rSize(5)),
                child: Text(
                  Languages.of(context)!.labelContactPhone + ':',
                  style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: rSize(25)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: rSize(10), vertical: rSize(5)),
                child: Text(
                  contact.contactPhone,
                  style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: rSize(22)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getContactAddress(Contact contact) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        children: [
          Icon(
            FontAwesomeIcons.mapMarkedAlt,
            color: Theme.of(context).colorScheme.secondary,
            size: rSize(22),
          ),
          Wrap(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: rSize(10), vertical: rSize(5)),
                child: Text(
                  Languages.of(context)!.labelContactAddress + ':',
                  style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: rSize(25)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: rSize(10), vertical: rSize(5)),
                child: Text(
                  contact.address,
                  style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: rSize(22)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getContactCard(BuildContext context, Contact contact) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(7),
        child: Stack(children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Column(
                    children: <Widget>[
                      getContactName(contact),
                      SizedBox(
                        height: rSize(20),
                      ),
                      getContactPhone(contact),
                      SizedBox(
                        height: rSize(20),
                      ),
                      getContactAddress(contact),
                      SizedBox(
                        height: rSize(20),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Contact contact = Contact('Saeed', '0543103540', 'Haifa');
    List<Contact> contacts = [contact, contact, contact, contact, contact, contact];
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
// scrollDirection: Axis.horizontal,
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  width: double.maxFinite,
                  child: getContactCard(context, contacts[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
