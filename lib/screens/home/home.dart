import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_event_calendar.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:flutter/material.dart';

import '../../widget/custom_modal.dart';

//class needs to extend StatefulWidget since we need to make changes to the bottom app bar according to the user clicks
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  bool clickedCentreFAB =
      false; //boolean used to handle container animation which expands from the FAB
  int selectedIndex =
      0; //to handle which item is currently selected in the bottom app bar
  String text = "Home";

  //call this method on click of each bottom app bar item to update the screen
  void updateTabSelection(int index, String buttonText) {
    setState(() {
      selectedIndex = index;
      text = buttonText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(withSearch: true),
      ),
      body: Stack(
        children: <Widget>[
          CustomEventCalendar(),
          //this is the code for the widget container that comes from behind the floating action button (FAB)
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 250),
              //if clickedCentreFAB == true, the first parameter is used. If it's false, the second.
              height:
                  clickedCentreFAB ? MediaQuery.of(context).size.height : 0.0,
              width: clickedCentreFAB ? MediaQuery.of(context).size.height : 0,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(clickedCentreFAB ? 0.0 : 350.0),
                  color: Colors.red),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottomModal(
            BottomModalProps(
                context: context,
                child: (Text('dasjdsakjlkjdaskjdalkjdak')),
                title: 'Modal Title'),
          );
        },
        // tooltip: "Centre FAB",
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Icon(Icons.add),
        ),
        elevation: 4.0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          margin: EdgeInsets.only(left: 12.0, right: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EaseInAnimation(
                onTap: () {
                  updateTabSelection(0, "Home");
                },
                child: Icon(
                  Icons.home,
                  size: rSize(40),
                  color: selectedIndex == 0
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
              EaseInAnimation(
                onTap: () {
                  updateTabSelection(1, "Outgoing");
                },
                child: Icon(
                  Icons.report,
                  size: rSize(40),
                  color: selectedIndex == 1
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(
                width: rSize(80),
              ),
              EaseInAnimation(
                onTap: () {
                  updateTabSelection(2, "Incoming");
                },
                child: Icon(
                  Icons.person,
                  size: rSize(40),
                  color: selectedIndex == 2
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
              EaseInAnimation(
                onTap: () {
                  updateTabSelection(3, "Settings");
                },
                child: Icon(
                  Icons.home,
                  size: rSize(40),
                  color: selectedIndex == 3
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
