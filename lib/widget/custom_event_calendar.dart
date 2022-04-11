import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/date.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/calendar_view/flutter_week_view.dart';
import 'package:appointments/widget/expandable_calendar.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomEventCalendar extends StatefulWidget {
  const CustomEventCalendar({Key? key}) : super(key: key);

  @override
  State<CustomEventCalendar> createState() => _CustomEventCalendarState();
}

class _CustomEventCalendarState extends State<CustomEventCalendar> {
  late final ValueNotifier<List<CalendarEvent>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DayViewController dayViewController = DayViewController();
  DateTime _focusedDay = kToday;
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<CalendarEvent> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  Widget eventTextBuilder(
    FlutterWeekViewEvent event,
    BuildContext context,
    DayView dayView,
    double height,
    double width,
  ) {
    // the height of each row in the description
    double fontSize =
        Theme.of(context).textTheme.subtitle1?.fontSize ?? rSize(16);
    double fontHeight = Theme.of(context).textTheme.subtitle1?.height ?? 1.4;

    // This is the height of the title
    double fontHeight2 = Theme.of(context).textTheme.headline1?.height ?? 1.4;
    double fontSize2 =
        Theme.of(context).textTheme.headline1?.fontSize ?? rSize(22);

    // here will calculate the max available max line in the event
    int maxLines =
        (height - (fontHeight2 * fontSize2)) ~/ (fontHeight * fontSize);

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          event.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .headline1
              ?.copyWith(color: event.backgroundColor),
        ),
        Expanded(
          child: Text(event.description,
              maxLines: maxLines != 0 ? maxLines : 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: event.backgroundColor)),
        ),
      ],
    );
  }

  renderFlutterWeekViewEvent({
    required String title,
    String? description,
    Color? backgroundColor,
    required DateTime start,
    required DateTime end,
    VoidCallback? onTap,
  }) {
    backgroundColor = backgroundColor ?? Theme.of(context).colorScheme.primary;
    return FlutterWeekViewEvent(
      eventTextBuilder: eventTextBuilder,
      padding: EdgeInsets.symmetric(
        horizontal: rSize(20),
        vertical: rSize(10),
      ),
      title: title,
      description: description ?? '',
      backgroundColor: backgroundColor,
      margin: EdgeInsets.symmetric(
        horizontal: rSize(6),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          rSize(10),
        ),
        color: lighten(backgroundColor, 0.35),
      ),
      start: start,
      end: end,
      onTap: onTap,
    );
  }

  List<FlutterWeekViewEvent> getCourses(BuildContext context) {
    print(_focusedDay);
    // return courses[_selectedDay]!;
    DateTime now = DateTime.now();
    DateTime date =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    var day = 'day1';
    if (_focusedDay.day % 2 == 0) {
      day = 'day2';
    }
    Map<String, List<FlutterWeekViewEvent>> courses = {
      'day1': [
        renderFlutterWeekViewEvent(
          title: 'Course 1',
          description:
              'A description 3 dsadjkhasd adasjd hnasd adasd alskdjask djsakldjsalkdjasldjkslajdlasjdaskjdklasjdalskdja dsakjdlajdlkasjlkds jlasdkjlkasjlkdjadklajldkasjdklsajlkkdjakldjlks',
          start: date.add(Duration(hours: 19)),
          end: date.add(Duration(hours: 22)),
          onTap: () => Navigator.pushNamed(context, '/home/courseDetails'),
        ),
        renderFlutterWeekViewEvent(
          title: 'Course 2',
          description:
              'A description 3 dsadjkhasd adasjd hnasd adasd alskdjask djsakldjsalkdjasldjkslajdlasjdaskjdklasjdalskdja dsakjdlajdlkasjlkds jlasdkjlkasjlkdjadklajldkasjdklsajlkkdjakldjlks',
          start: date.add(Duration(hours: 23, minutes: 30)),
          end: date.add(Duration(hours: 24)),
          onTap: () => Navigator.pushNamed(context, '/home/courseDetails'),
        ),
        renderFlutterWeekViewEvent(
          title: 'Course 3',
          description:
              'A description 3 dsadjkhasd adasjd hnasd adasd alskdjask djsakldjsalkdjasldjkslajdlasjdaskjdklasjdalskdja dsakjdlajdlkasjlkds jlasdkjlkasjlkdjadklajldkasjdklsajlkkdjakldjlks',
          start: date.add(Duration(hours: 17)),
          end: date.add(Duration(hours: 18, minutes: 30)),
          onTap: () => Navigator.pushNamed(context, '/home/courseDetails'),
        ),
        renderFlutterWeekViewEvent(
          title: 'An event 5',
          description:
              'A description 3 dsadjkhasd adasjd hnasd adasd alskdjask djsakldjsalkdjasldjkslajdlasjdaskjdklasjdalskdja dsakjdlajdlkasjlkds jlasdkjlkasjlkdjadklajldkasjdklsajlkkdjakldjlks',
          start: date.add(Duration(hours: 20)),
          end: date.add(Duration(hours: 21)),
          onTap: () => Navigator.pushNamed(context, '/home/courseDetails'),
        ),
      ],
      'day2': [
        renderFlutterWeekViewEvent(
          title: 'Course 3',
          description:
              'A description 3 dsadjkhasd adasjd hnasd adasd alskdjask djsakldjsalkdjasldjkslajdlasjdaskjdklasjdalskdja dsakjdlajdlkasjlkds jlasdkjlkasjlkdjadklajldkasjdklsajlkkdjakldjlks',
          backgroundColor: Colors.green,
          start: date.add(Duration(hours: 12, minutes: 30)),
          end: date.add(Duration(hours: 15)),
          onTap: () => Navigator.pushNamed(context, '/home/courseDetails'),
        ),
        renderFlutterWeekViewEvent(
          title: 'Course 9',
          description:
              'A description 3 dsadjkhasd adasjd hnasd adasd alskdjask djsakldjsalkdjasldjkslajdlasjdaskjdklasjdalskdja dsakjdlajdlkasjlkds jlasdkjlkasjlkdjadklajldkasjdklsajlkkdjakldjlks',
          start: date.add(Duration(hours: 17)),
          end: date.add(Duration(hours: 18, minutes: 30)),
          onTap: () => Navigator.pushNamed(context, '/home/courseDetails'),
        ),
        renderFlutterWeekViewEvent(
          title: 'An event 7',
          description:
              'A description 7dadsdasdasaddsadas sandasjdhas dasdhaskjdnasd dahsldjasljd',
          start: date.add(Duration(hours: 22)),
          end: date.add(Duration(hours: 23)),
          onTap: () => Navigator.pushNamed(context, '/home/courseDetails'),
        ),
      ],
    };
    return courses[day]!.toList();
  }

  DateTime date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          ExpandableCalendar(
            expandableCalendarProps: ExpandableCalendarProps(
              focusedDay: _focusedDay,
              selectedDay: _selectedDay,
              calendarFormat: _calendarFormat,
              eventLoader: _getEventsForDay,
              onDaySelected: _onDaySelected,
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
            ),
          ),
          Expanded(
            child: DayView(
              controller: dayViewController,
              hoursColumnStyle: HoursColumnStyle(
                color: Theme.of(context).colorScheme.onBackground,
                textStyle: Theme.of(context).textTheme.subtitle1,
                width: rSize(80),
              ),
              style: DayViewStyle(
                currentTimeCirclePosition: CurrentTimeCirclePosition.left,
                backgroundColor: Colors.transparent,
                backgroundRulesColor: Theme.of(context).colorScheme.primary,
                currentTimeCircleRadius: rSize(5),
                currentTimeCircleColor: Theme.of(context).colorScheme.secondary,
                currentTimeRuleColor: Theme.of(context).colorScheme.secondary,
                currentTimeRuleHeight: rSize(2),
                hourRowHeight: rSize(100),
              ),
              minimumTime: const HourMinute(hour: 6),
              userZoomable: true,
              date: kToday,
              events: getCourses(context),
            ),
          ),
        ],
      ),
    );
  }
}
