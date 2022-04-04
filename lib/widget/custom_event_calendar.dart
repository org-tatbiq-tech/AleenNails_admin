import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/date.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/calendar_view/flutter_week_view.dart';
import 'package:appointments/widget/ease_in_animation.dart';
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
    double fontHeight = Theme.of(context).textTheme.subtitle1?.height ?? 1.2;

    // This is the height of the title
    double fontHeight2 = Theme.of(context).textTheme.headline1?.height ?? 1.2;
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
                rowHeight: rSize(45),
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
                  headerPadding: EdgeInsets.symmetric(
                    vertical: rSize(5),
                    horizontal: 0,
                  ),
                  formatButtonPadding: EdgeInsets.symmetric(
                      horizontal: rSize(12), vertical: rSize(6)),
                  formatButtonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(rSize(6)),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  formatButtonTextStyle: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.white, fontSize: rSize(14)),
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
                  cellMargin: EdgeInsets.all(rSize(2)),
                  canMarkersOverflow: false,
                  markerSize: rSize(5),
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
