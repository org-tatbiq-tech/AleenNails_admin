import 'package:appointments/screens/home/contacts/contacts.dart';
import 'package:appointments/screens/home/more.dart';
import 'package:appointments/screens/home/statistics.dart';
import 'package:appointments/screens/home/timeline.dart';
import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_icon.dart';
import 'package:appointments/widget/custom_modal.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:flutter/material.dart';

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
    More(),
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
      floatingActionButton: SizedBox(
        width: rSize(60),
        height: rSize(60),
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              showBottomModal(
                bottomModalProps: BottomModalProps(
                  context: context,
                  child: (Text('dasjdsakjlkjdaskjdalkjdak')),
                  title: 'Modal Title',
                ),
              );
            },
            // tooltip: "Centre FAB",
            child: Container(
              margin: const EdgeInsets.all(15.0),
              child: const Icon(Icons.add),
            ),
            elevation: 4.0,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: rSize(5),
        shape: const CircularNotchedRectangle(),
        child: Container(
          margin: EdgeInsets.fromLTRB(
            rSize(20),
            rSize(10),
            rSize(20),
            rSize(0),
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
                child: CustomIcon(
                  customIconProps: CustomIconProps(
                    iconColor: _selectedPage == 0
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary,
                    icon: null,
                    backgroundColor: Colors.transparent,
                    path: 'assets/icons/home.png',
                    withPadding: true,
                    contentPadding: 2,
                    containerSize: 35,
                  ),
                ),
              ),
              EaseInAnimation(
                onTap: () {
                  setState(() {
                    _selectedPage = 1;
                  });
                },
                child: CustomIcon(
                  customIconProps: CustomIconProps(
                    iconColor: _selectedPage == 1
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary,
                    icon: null,
                    backgroundColor: Colors.transparent,
                    path: 'assets/icons/contacts.png',
                    withPadding: true,
                    contentPadding: 0,
                    containerSize: 35,
                  ),
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
                child: CustomIcon(
                  customIconProps: CustomIconProps(
                    iconColor: _selectedPage == 2
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary,
                    icon: null,
                    backgroundColor: Colors.transparent,
                    path: 'assets/icons/statics.png',
                    withPadding: true,
                    contentPadding: 2,
                    containerSize: 35,
                  ),
                ),
              ),
              EaseInAnimation(
                onTap: () {
                  setState(() {
                    _selectedPage = 3;
                  });
                },
                child: CustomIcon(
                  customIconProps: CustomIconProps(
                    iconColor: _selectedPage == 3
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary,
                    icon: null,
                    backgroundColor: Colors.transparent,
                    path: 'assets/icons/more.png',
                    withPadding: true,
                    contentPadding: 2,
                    containerSize: 35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
