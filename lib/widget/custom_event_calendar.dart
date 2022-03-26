import 'package:appointments/utils/date.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils/data_types.dart';
import '../utils/layout.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, rSize(15)),
              child: TableCalendar<CalendarEvent>(
                firstDay: getFirstDay(),
                lastDay: getLastDay(),
                daysOfWeekHeight: rSize(30),
                rowHeight: rSize(60),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle:
                      Theme.of(context).textTheme.subtitle2!.copyWith(color: Theme.of(context).colorScheme.outline),
                  weekendStyle:
                      Theme.of(context).textTheme.subtitle2!.copyWith(color: Theme.of(context).colorScheme.outline),
                ),
                headerStyle: HeaderStyle(
                  leftChevronIcon: IconTheme(
                    data: Theme.of(context).primaryIconTheme.copyWith(size: rSize(30)),
                    child: const Icon(
                      Icons.chevron_left,
                    ),
                  ),
                  rightChevronIcon: IconTheme(
                    data: Theme.of(context).primaryIconTheme.copyWith(size: rSize(30)),
                    child: const Icon(
                      Icons.chevron_right,
                    ),
                  ),
                  headerPadding: EdgeInsets.fromLTRB(0, rSize(20), 0, rSize(20)),
                  formatButtonPadding: EdgeInsets.symmetric(horizontal: rSize(16), vertical: rSize(8)),
                  formatButtonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(rSize(6)),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  formatButtonTextStyle: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white),
                  formatButtonVisible: true,
                  formatButtonShowsNext: false,
                  titleTextStyle:
                      Theme.of(context).textTheme.headline2!.copyWith(color: Theme.of(context).colorScheme.outline),
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
                  disabledTextStyle:
                      Theme.of(context).textTheme.bodyText1!.copyWith(color: Theme.of(context).colorScheme.outline),
                  defaultTextStyle: Theme.of(context).textTheme.bodyText1!,
                  weekendTextStyle: Theme.of(context).textTheme.bodyText1!,
                  outsideTextStyle: Theme.of(context).textTheme.bodyText1!,
                  holidayTextStyle: Theme.of(context).textTheme.bodyText1!,
                  selectedTextStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
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
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, rSize(20), 0, 0),
              child: ValueListenableBuilder<List<CalendarEvent>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return EaseInAnimation(
                        beginAnimation: 0.98,
                        onTap: () => {print('object')},
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(rSize(5))),
                          margin: EdgeInsets.symmetric(
                            horizontal: rSize(15),
                            vertical: rSize(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: rSize(8), vertical: rSize(16)),
                            child: Text('${value[index]}'),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
