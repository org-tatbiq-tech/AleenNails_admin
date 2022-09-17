import 'package:appointments/screens/home/clients/clients.dart';
import 'package:appointments/screens/home/more.dart';
import 'package:appointments/screens/home/statistics.dart';
import 'package:appointments/screens/home/timeline.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_modal.dart';
import 'package:common_widgets/ease_in_animation.dart';
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
    Statistics(),
    More(),
  ];

  getPageTitle() {
    switch (_selectedPage) {
      case 0:
        return 'Home';
      case 1:
        return 'Clients';
      case 2:
        return 'Statics';
      case 3:
        return 'More';
      default:
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
            onTap: () => {},
            text: 'New Appointment',
          ),
        ),
        SizedBox(
          height: rSize(10),
        ),
        CustomButton(
          customButtonProps: CustomButtonProps(
            onTap: () => {},
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
          barHeight: _selectedPage == 3 ? 120 : 70,
          titleText: getPageTitle(),
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
