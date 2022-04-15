import 'package:appointments/screens/home/contacts/contacts.dart';
import 'package:appointments/screens/home/profile.dart';
import 'package:appointments/screens/home/statistics.dart';
import 'package:appointments/screens/home/timeline.dart';
import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_modal.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage = 0;
  final screens = [
    TimeLine(),
    Contacts(),
    Statistics(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          withSearch: _selectedPage == 1 ? true : false,
          withBorder: _selectedPage == 0 ? true : false,
        ),
      ),
      body: screens[_selectedPage],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottomModal(
            BottomModalProps(context: context, child: (Text('dasjdsakjlkjdaskjdalkjdak')), title: 'Modal Title'),
          );
        },
        // tooltip: "Centre FAB",
        child: Container(
          margin: const EdgeInsets.all(15.0),
          child: const Icon(Icons.add),
        ),
        elevation: 4.0,
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: rSize(10),
        child: Container(
          margin: EdgeInsets.fromLTRB(
            rSize(20),
            rSize(10),
            rSize(20),
            rSize(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EaseInAnimation(
                onTap: () {
                  setState(() {
                    _selectedPage = 0;
                  });
                },
                child: Icon(
                  FontAwesomeIcons.home,
                  size: rSize(35),
                  color: _selectedPage == 0
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
              EaseInAnimation(
                onTap: () {
                  setState(() {
                    _selectedPage = 1;
                  });
                },
                child: Icon(
                  FontAwesomeIcons.solidAddressBook,
                  size: rSize(35),
                  color: _selectedPage == 1
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(
                width: rSize(80),
              ),
              EaseInAnimation(
                onTap: () {
                  setState(() {
                    _selectedPage = 2;
                  });
                },
                child: Icon(
                  FontAwesomeIcons.chartBar,
                  size: rSize(35),
                  color: _selectedPage == 2
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
              EaseInAnimation(
                onTap: () {
                  setState(() {
                    _selectedPage = 3;
                  });
                },
                child: Icon(
                  Icons.settings,
                  size: rSize(35),
                  color: _selectedPage == 3
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        shape: const CircularNotchedRectangle(),
      ),
    );
  }
}
