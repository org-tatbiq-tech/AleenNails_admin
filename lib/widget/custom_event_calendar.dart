import 'package:appointments/utils/date_util.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import '../data_types.dart';

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
    return Column(
      children: [
        Card(
          color: Theme.of(context).cardColor,
          margin: const EdgeInsets.all(0),
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 1.h),
            child: TableCalendar<CalendarEvent>(
              firstDay: getFirstDay(),
              lastDay: getLastDay(),
              daysOfWeekHeight: 3.h,
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
                  data: Theme.of(context).primaryIconTheme.copyWith(size: 7.w),
                  child: const Icon(
                    Icons.chevron_left,
                  ),
                ),
                rightChevronIcon: IconTheme(
                  data: Theme.of(context).primaryIconTheme.copyWith(size: 7.w),
                  child: const Icon(
                    Icons.chevron_right,
                  ),
                ),
                headerPadding: EdgeInsets.fromLTRB(0, 3.w, 0, 3.w),
                formatButtonPadding:
                    EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.w),
                formatButtonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1.w),
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
                canMarkersOverflow: false,
                markerSize: 1.2.w,
                markersAnchor: 1.9,
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
        SizedBox(height: 3.h),
        Expanded(
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
                      elevation: 2,
                      color: Theme.of(context).cardColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.w)),
                      shadowColor: Theme.of(context).shadowColor,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 10.0,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 4.w),
                        child: Text('${value[index]}'),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
