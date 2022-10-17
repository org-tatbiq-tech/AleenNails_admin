import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/screens/home/clients/clients.dart';
import 'package:appointments/screens/home/more.dart';
import 'package:appointments/screens/home/notification/notifications.dart';
import 'package:appointments/screens/home/timeline.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_modal.dart';
import 'package:common_widgets/ease_in_animation.dart';
import 'package:common_widgets/utils/layout.dart';

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
    Clients(),
    Notifications(),
    More(),
  ];

  Widget getModalBody() {
    return Column(
      children: [
        SizedBox(
          height: rSize(10),
        ),
        CustomButton(
          customButtonProps: CustomButtonProps(
            onTap: () => {
              Navigator.pop(context),
              Navigator.of(context).pushNamed('/newAppointment'),
            },
            text: Languages.of(context)!.newAppointmentLabel.toTitleCase(),
          ),
        ),
        SizedBox(
          height: rSize(10),
        ),
        CustomButton(
          customButtonProps: CustomButtonProps(
            onTap: () => {
              Navigator.pop(context),
              Navigator.of(context).pushNamed('/unavailability'),
            },
            text: Languages.of(context)!.unavailabilityLabel.toTitleCase(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: getModalBody(),
                  showDragPen: true,
                  enableDrag: true,
                ),
              );
            },
            elevation: 4.0,
            child: const Icon(Icons.add),
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
            !isDeviceHasNotch()
                ? rSize(20)
                : isAndroid()
                    ? rSize(20)
                    : 0,
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
                        ? darken(Theme.of(context).colorScheme.secondary, 0.2)
                        : Theme.of(context).colorScheme.primary,
                    icon: null,
                    backgroundColor: Colors.transparent,
                    path: 'assets/icons/calendar_full.png',
                    withPadding: true,
                    contentPadding: 1,
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
                        ? darken(Theme.of(context).colorScheme.secondary, 0.2)
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
                        ? darken(Theme.of(context).colorScheme.secondary, 0.2)
                        : Theme.of(context).colorScheme.primary,
                    icon: null,
                    backgroundColor: Colors.transparent,
                    path: 'assets/icons/bell_full.png',
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
                        ? darken(Theme.of(context).colorScheme.secondary, 0.2)
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
