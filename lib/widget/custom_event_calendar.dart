import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/date.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/calendar_view/flutter_week_view.dart';
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
        FlutterWeekViewEvent(
          title: 'Course 1',
          description: 'A description 1',
          start: date.add(Duration(hours: 19)),
          end: date.add(Duration(hours: 22)),
          onTap: () => Navigator.pushNamed(context, '/home/courseDetails'),
        ),
        FlutterWeekViewEvent(
          title: 'Course 2',
          description: 'A description 2',
          start: date.add(Duration(hours: 23, minutes: 30)),
          end: date.add(Duration(hours: 24)),
          onTap: () => Navigator.pushNamed(context, '/home/courseDetails'),
        ),
        FlutterWeekViewEvent(
          title: 'Course 3',
          description: 'A description 3',
          start: date.add(Duration(hours: 17)),
          end: date.add(Duration(hours: 18, minutes: 30)),
          onTap: () => Navigator.pushNamed(context, '/home/courseDetails'),
        ),
        FlutterWeekViewEvent(
          title: 'An event 5',
          description: 'A description 5',
          start: date.add(Duration(hours: 20)),
          end: date.add(Duration(hours: 21)),
          onTap: () => Navigator.pushNamed(context, '/home/courseDetails'),
        ),
      ],
      'day2': [
        FlutterWeekViewEvent(
          title: 'Course 5',
          description: 'A description 5',
          start: date.add(Duration(hours: 10)),
          end: date.add(Duration(hours: 11)),
          onTap: () => Navigator.pushNamed(context, '/home/courseDetails'),
        ),
        FlutterWeekViewEvent(
          title: 'Course 3',
          description: 'A description 3',
          start: date.add(Duration(hours: 12, minutes: 30)),
          end: date.add(Duration(hours: 15)),
          onTap: () => Navigator.pushNamed(context, '/home/courseDetails'),
        ),
        FlutterWeekViewEvent(
          title: 'Course 9',
          description: 'A description 9',
          start: date.add(Duration(hours: 17)),
          end: date.add(Duration(hours: 18, minutes: 30)),
          onTap: () => Navigator.pushNamed(context, '/home/courseDetails'),
        ),
        FlutterWeekViewEvent(
          title: 'An event 7',
          description: 'A description 7',
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
          Card(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, rSize(15)),
              child: TableCalendar<CalendarEvent>(
                firstDay: getFirstDay(),
                lastDay: getLastDay(),
                daysOfWeekHeight: rSize(30),
                rowHeight: rSize(60),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: Theme.of(context).colorScheme.outline),
                  weekendStyle: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: Theme.of(context).colorScheme.outline),
                ),
                headerStyle: HeaderStyle(
                  leftChevronIcon: IconTheme(
                    data: Theme.of(context)
                        .primaryIconTheme
                        .copyWith(size: rSize(30)),
                    child: const Icon(
                      Icons.chevron_left,
                    ),
                  ),
                  rightChevronIcon: IconTheme(
                    data: Theme.of(context)
                        .primaryIconTheme
                        .copyWith(size: rSize(30)),
                    child: const Icon(
                      Icons.chevron_right,
                    ),
                  ),
                  headerPadding:
                      EdgeInsets.fromLTRB(0, rSize(20), 0, rSize(20)),
                  formatButtonPadding: EdgeInsets.symmetric(
                      horizontal: rSize(16), vertical: rSize(8)),
                  formatButtonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(rSize(6)),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  formatButtonTextStyle: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.white),
                  formatButtonVisible: true,
                  formatButtonShowsNext: false,
                  titleTextStyle: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Theme.of(context).colorScheme.outline),
                  titleCentered: false,
                ),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                // rangeStartDay: _rangeStart,
                // rangeEndDay: _rangeEnd,
                calendarFormat: _calendarFormat,
                rangeSelectionMode: RangeSelectionMode.disabled,
                eventLoader: _getEventsForDay,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                calendarStyle: CalendarStyle(
                  cellMargin: EdgeInsets.all(rSize(6)),
                  canMarkersOverflow: false,
                  markerSize: rSize(6),
                  markersAnchor: 1.5,
                  markersAutoAligned: true,
                  markersMaxCount: 1,
                  outsideDaysVisible: false,
                  isTodayHighlighted: true,
                  todayTextStyle: Theme.of(context).textTheme.bodyText1!,
                  todayDecoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  disabledTextStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).colorScheme.outline),
                  defaultTextStyle: Theme.of(context).textTheme.bodyText1!,
                  weekendTextStyle: Theme.of(context).textTheme.bodyText1!,
                  outsideTextStyle: Theme.of(context).textTheme.bodyText1!,
                  holidayTextStyle: Theme.of(context).textTheme.bodyText1!,
                  selectedTextStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white),
                  markerDecoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    shape: BoxShape.circle,
                  ),
                ),
                onDaySelected: _onDaySelected,
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
            ),
          ),
          Expanded(
            child: DayView(
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
                hourRowHeight: rSize(80),
              ),
              initialTime: const HourMinute(hour: 7),
              minimumTime: const HourMinute(hour: 5),
              maximumTime: const HourMinute(hour: 24),
              userZoomable: false,
              date: kToday,
              events: getCourses(context),
            ),
          ),
        ],
      ),
    );
  }
}
