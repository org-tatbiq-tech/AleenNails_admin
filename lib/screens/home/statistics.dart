import 'package:flutter/material.dart';

//class needs to extend StatefulWidget since we need to make changes to the bottom app bar according to the user clicks
class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StatisticsState();
  }
}

class StatisticsState extends State<Statistics> {
  bool clickedCentreFAB = false; //boolean used to handle container animation which expands from the FAB
  int selectedIndex = 0; //to handle which item is currently selected in the bottom app bar
  String text = "Statistics";

  //call this method on click of each bottom app bar item to update the screen
  void updateTabSelection(int index, String buttonText) {
    setState(() {
      selectedIndex = index;
      text = buttonText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Text('Statistics'),
        ),
        //this is the code for the widget container that comes from behind the floating action button (FAB)
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            //if clickedCentreFAB == true, the first parameter is used. If it's false, the second.
            height: clickedCentreFAB ? MediaQuery.of(context).size.height : 0.0,
            width: clickedCentreFAB ? MediaQuery.of(context).size.height : 0,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(clickedCentreFAB ? 0.0 : 350.0), color: Colors.red),
          ),
        )
      ],
    );
  }
}
