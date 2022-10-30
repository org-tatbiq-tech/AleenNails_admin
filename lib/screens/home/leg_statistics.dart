import 'package:appointments/widget/custom/custom_container.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

//class needs to extend StatefulWidget since we need to make changes to the bottom app bar according to the user clicks
class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StatisticsState();
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

class StatisticsState extends State<Statistics> {
  bool clickedCentreFAB =
      false; //boolean used to handle container animation which expands from the FAB
  int selectedIndex =
      0; //to handle which item is currently selected in the bottom app bar
  String text = "Statistics";
  List<charts.Series<dynamic, String>> seriesList = _createSampleData();
  List<charts.Series<dynamic, int>> seriesPieList = _createPieSampleData();
  final bool animate = false;

  //call this method on click of each bottom app bar item to update the screen
  void updateTabSelection(int index, String buttonText) {
    setState(() {
      selectedIndex = index;
      text = buttonText;
    });
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createPieSampleData() {
    final data = [
      new LinearSales(0, 100),
      new LinearSales(1, 75),
      new LinearSales(2, 25),
      new LinearSales(3, 5),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  BarChartGroupData generateGroupData(int x, int y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(toY: y.toDouble()),
      ],
    );
  }

  Widget getSalesBarChart(BuildContext context) {
    return BarChart(
      BarChartData(
        titlesData: FlTitlesData(
            topTitles: AxisTitles(
              axisNameWidget: Text('Title'),
            ),
            bottomTitles: AxisTitles(
              axisNameWidget: Text('Date'),
            )),
        barGroups: [
          generateGroupData(1, 10),
          generateGroupData(2, 18),
          generateGroupData(3, 4),
          generateGroupData(4, 11),
        ],
        barTouchData: BarTouchData(
            enabled: true,
            handleBuiltInTouches: false,
            touchCallback: (event, response) {
              print('touched');
            },
            mouseCursorResolver: (event, response) {
              return response == null || response.spot == null
                  ? MouseCursor.defer
                  : SystemMouseCursors.click;
            }),
      ),
    );
  }

  Widget getBarChart(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
    );
  }

  Widget getPieChart(BuildContext context) {
    return charts.PieChart(seriesPieList, animate: animate);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomContainer(
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: AspectRatio(
                    aspectRatio: 2,
                    child: getSalesBarChart(context),
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: AspectRatio(
                    aspectRatio: 2,
                    child: getBarChart(context),
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: AspectRatio(
                    aspectRatio: 3,
                    child: getPieChart(context),
                  ),
                ),
              ),
            ],
          ),
        ),
        //this is the code for the widget container that comes from behind the floating action button (FAB)
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            //if clickedCentreFAB == true, the first parameter is used. If it's false, the second.
            height: clickedCentreFAB ? MediaQuery.of(context).size.height : 0.0,
            width: clickedCentreFAB ? MediaQuery.of(context).size.height : 0,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(clickedCentreFAB ? 0.0 : 350.0),
                color: Colors.red),
          ),
        )
      ],
    );
  }
}
