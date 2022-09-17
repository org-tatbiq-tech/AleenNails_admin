import 'package:appointments/widget/custom_container.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';

import '../../widget/rounded_drop_down.dart';

const timePeriods = ["7-Days", "1-Month", "6-Month", "Last-Year", "All"];
const services = ["Sports", "Strategy", "Action", "Shooter", "Other"];

// Services data
const basicData = [
  {'service': 'Sports', 'sold': 275},
  {'service': 'Strategy', 'sold': 115},
  {'service': 'Action', 'sold': 120},
  {'service': 'Shooter', 'sold': 350},
  {'service': 'Other', 'sold': 150},
];

final _monthDayFormat = DateFormat('MM-dd');

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}

final timeSeriesSales = [
  TimeSeriesSales(DateTime(2017, 9, 19), 5),
  TimeSeriesSales(DateTime(2017, 9, 26), 25),
  TimeSeriesSales(DateTime(2017, 10, 3), 100),
  TimeSeriesSales(DateTime(2017, 10, 10), 75),
];

List<Figure> centralPieLabel(
  Offset anchor,
  List<Tuple> selectedTuples,
) {
  final tuple = selectedTuples.last;

  final titleSpan = TextSpan(
    text: tuple['service'].toString() + '\n',
    style: const TextStyle(
      fontSize: 14,
      color: Colors.black87,
    ),
  );

  final valueSpan = TextSpan(
    text: tuple['sold'].toString(),
    style: const TextStyle(
      fontSize: 28,
      color: Colors.black87,
    ),
  );

  final painter = TextPainter(
    text: TextSpan(children: [titleSpan, valueSpan]),
    // textDirection: TextDirection.ltr,
    textAlign: TextAlign.center,
  );
  painter.layout();

  final paintPoint = getPaintPoint(
    const Offset(175, 150),
    painter.width,
    painter.height,
    Alignment.center,
  );

  return [TextFigure(painter, paintPoint)];
}

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StatisticsState();
  }
}

class StatisticsState extends State<Statistics> {
  String selectedBarChartTimePeriod = timePeriods[0];
  String selectedPieChartTimePeriod = timePeriods[0];
  String selectedLineChartTimePeriod = timePeriods[0];
  String selectedLineChartService = services[0];

  Widget getServicesHistogram(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Services histogram',
              style: TextStyle(
                fontSize: rSize(20),
              ),
            ),
            Flexible(
              child: RoundedDropDown(
                value: selectedBarChartTimePeriod,
                hint: "Select period",
                items: timePeriods.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    selectedBarChartTimePeriod = newValue;
                  });
                },
              ),
            ),
          ],
        ),
        Flexible(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Chart(
              data: basicData,
              variables: {
                'service': Variable(
                  accessor: (Map map) => map['service'] as String,
                ),
                'sold': Variable(
                  accessor: (Map map) => map['sold'] as num,
                ),
              },
              elements: [
                IntervalElement(
                  label: LabelAttr(
                      encoder: (tuple) => Label(tuple['sold'].toString())),
                  elevation: ElevationAttr(value: 0, updaters: {
                    'tap': {true: (_) => 5}
                  }),
                  color: ColorAttr(value: Defaults.primaryColor, updaters: {
                    'tap': {false: (color) => color.withAlpha(100)}
                  }),
                )
              ],
              axes: [
                Defaults.horizontalAxis,
                Defaults.verticalAxis,
              ],
              selections: {
                'hover': PointSelection(
                  dim: Dim.x,
                  on: {GestureType.hover},
                  clear: {GestureType.mouseExit},
                )
              },
              tooltip: TooltipGuide(),
              crosshair: CrosshairGuide(),
            ),
          ),
        ),
      ],
    );
  }

  Widget getServicesPieChart(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Services pie chart',
              style: TextStyle(
                fontSize: rSize(20),
              ),
            ),
            Flexible(
              child: RoundedDropDown(
                value: selectedPieChartTimePeriod,
                hint: "Select period",
                items: timePeriods.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    selectedPieChartTimePeriod = newValue;
                  });
                },
              ),
            ),
          ],
        ),
        Flexible(
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            child: Chart(
              data: basicData,
              variables: {
                'service': Variable(
                  accessor: (Map map) => map['service'] as String,
                ),
                'sold': Variable(
                  accessor: (Map map) => map['sold'] as num,
                ),
              },
              transforms: [
                Proportion(
                  variable: 'sold',
                  as: 'percent',
                )
              ],
              elements: [
                IntervalElement(
                  position: Varset('percent') / Varset('service'),
                  label: LabelAttr(
                      encoder: (tuple) => Label(
                            tuple['sold'].toString(),
                            LabelStyle(style: Defaults.runeStyle),
                          )),
                  color:
                      ColorAttr(variable: 'service', values: Defaults.colors10),
                  modifiers: [StackModifier()],
                )
              ],
              coord: PolarCoord(transposed: true, dimCount: 1),
            ),
          ),
        ),
      ],
    );
  }

  Widget getServicesLineChart(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Services line chart',
              style: TextStyle(
                fontSize: rSize(20),
              ),
            ),
            Flexible(
              child: RoundedDropDown(
                value: selectedLineChartTimePeriod,
                hint: "Select period",
                items: timePeriods.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    selectedLineChartTimePeriod = newValue;
                  });
                },
              ),
            ),
            Flexible(
              child: RoundedDropDown(
                value: selectedLineChartService,
                hint: "Select service",
                items: services.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    selectedLineChartService = newValue;
                  });
                },
              ),
            ),
          ],
        ),
        Flexible(
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: 350,
            height: 300,
            child: Chart(
              data: timeSeriesSales,
              variables: {
                'time': Variable(
                  accessor: (TimeSeriesSales datum) => datum.time,
                  scale: TimeScale(
                    formatter: (time) => _monthDayFormat.format(time),
                  ),
                ),
                'sales': Variable(
                  accessor: (TimeSeriesSales datum) => datum.sales,
                ),
              },
              elements: [
                LineElement(
                    shape: ShapeAttr(value: BasicLineShape(dash: [5, 2])))
              ],
              coord: RectCoord(color: const Color(0xffdddddd)),
              axes: [
                Defaults.horizontalAxis,
                Defaults.verticalAxis,
              ],
              selections: {
                'touchMove': PointSelection(
                  on: {
                    GestureType.scaleUpdate,
                    GestureType.tapDown,
                    GestureType.longPressMoveUpdate
                  },
                  dim: Dim.x,
                )
              },
              tooltip: TooltipGuide(
                followPointer: [false, true],
                align: Alignment.topLeft,
                offset: const Offset(-20, -20),
              ),
              crosshair: CrosshairGuide(followPointer: [false, true]),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: getServicesHistogram(context),
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: getServicesPieChart(context),
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: getServicesLineChart(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
