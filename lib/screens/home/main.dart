import 'package:appointments/screens/home/clients/client.dart';
import 'package:appointments/screens/home/clients/clients.dart';
import 'package:appointments/screens/home/more.dart';
import 'package:appointments/screens/home/notification/notifications.dart';
import 'package:appointments/screens/home/timeline.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_modal.dart';
import 'package:common_widgets/ease_in_animation.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage = 0;
  bool _isListView = false;
  final screens = [
    TimeLine(),
    Clients(),
    Notifications(),
    More(),
  ];

  getPageTitle() {
    switch (_selectedPage) {
      case 0:
        return 'Home';
      case 1:
        return 'Clients';
      case 2:
        return 'Notifications';
      case 3:
        return 'More';
      default:
    }
  }

  double getBarHeight() {
    switch (_selectedPage) {
      case 3:
        return 120;
      default:
        return 70;
    }
  }

  Widget? getCustomIcon() {
    switch (_selectedPage) {
      case 0:
        if (_isListView) {
          return Icon(
            Icons.list,
            size: rSize(26),
          );
        }
        return Icon(
          Icons.calendar_today,
          size: rSize(24),
        );

      case 1:
        return Icon(
          FontAwesomeIcons.plus,
          size: rSize(20),
        );

      case 2:
        return Icon(
          Icons.refresh,
          size: rSize(24),
        );
      default:
        return null;
    }
  }

  getCustomIconTap() {
    switch (_selectedPage) {
      case 0:
        return () => {
              setState(() {
                _isListView = !_isListView;
              }),
            };
      case 1:
        return () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ClientWidget(),
                ),
              ),
            };
      case 2:
        return () => {};
      default:
        return null;
    }
  }

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
            text: 'New Appointment',
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
            text: 'Add Unavailability',
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          withSearch: _selectedPage == 1 ? true : false,
          isLogoMode: _selectedPage == 3 ? true : false,
          logoHeight: rSize(75),
          withBorder: _selectedPage == 0 ? true : false,
          withClipPath: _selectedPage == 3 ? true : false,
          barHeight: getBarHeight(),
          titleText: getPageTitle(),
          customIcon: getCustomIcon(),
          customIconTap: getCustomIconTap(),
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
                  child: getModalBody(),
                  showDragPen: true,
                  enableDrag: true,
                  // title: 'Modal Title',
                ),
              );
            },
            elevation: 4.0,
            // tooltip: "Centre FAB",
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
                        ? darken(Theme.of(context).colorScheme.secondary, 0.2)
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
