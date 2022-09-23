import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_week_view/flutter_week_view.dart';

class CustomDayView extends StatelessWidget {
  final CustomDayViewProps customDayViewProps;

  const CustomDayView({Key? key, required this.customDayViewProps})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DayView(
      inScrollableWidget: true,
      controller: customDayViewProps.dayViewController,
      initialTime: customDayViewProps.initialTime,
      minimumTime: customDayViewProps.minimumTime,
      userZoomable: customDayViewProps.userZoomAble,
      date: customDayViewProps.date ?? DateTime.now(),
      events: customDayViewProps.events,
      hoursColumnStyle: HoursColumnStyle(
        color: Theme.of(context).colorScheme.onBackground,
        textStyle: Theme.of(context).textTheme.subtitle1,
        width: rSize(60),
      ),
      style: DayViewStyle(
        currentTimeCirclePosition: CurrentTimeCirclePosition.left,
        backgroundColor: Colors.transparent,
        backgroundRulesColor: Theme.of(context).colorScheme.primary,
        currentTimeCircleRadius: rSize(6),
        currentTimeCircleColor: Theme.of(context).colorScheme.secondary,
        currentTimeRuleColor: Theme.of(context).colorScheme.secondary,
        currentTimeRuleHeight: rSize(2),
        hourRowHeight: rSize(150),
      ),
      dayBarStyle: DayBarStyle(
        color: Theme.of(context).colorScheme.primary.withAlpha(100),
        textStyle: Theme.of(context).textTheme.bodyText2,
        textAlignment: Alignment.center,
      ),
    );
  }
}

class CustomDayViewProps {
  DateTime? date;
  List<FlutterWeekViewEvent>? events;
  DayViewController dayViewController;
  bool userZoomAble;
  HourMinute? minimumTime;
  HourMinute? initialTime;

  CustomDayViewProps({
    this.date,
    this.events,
    this.userZoomAble = false,
    required this.dayViewController,
    this.minimumTime,
    this.initialTime,
  });
}
