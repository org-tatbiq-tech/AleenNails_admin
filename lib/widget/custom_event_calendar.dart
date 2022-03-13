import 'package:appointments/utils/date_util.dart';
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
        TableCalendar<CalendarEvent>(
          firstDay: getFirstDay(),
          lastDay: getLastDay(),
          daysOfWeekHeight: 3.h,
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 10.sp, color: Colors.black54),
            weekendStyle: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 10.sp, color: Colors.black54),
          ),
          headerStyle: HeaderStyle(
            headerPadding: EdgeInsets.fromLTRB(0, 3.w, 0, 3.w),
            formatButtonPadding:
                EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.w),
            formatButtonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1.w),
              color: Theme.of(context).colorScheme.primary,
            ),
            formatButtonTextStyle: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 11.sp, color: Colors.white),
            formatButtonVisible: true,
            formatButtonShowsNext: false,
            titleTextStyle: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontSize: 15.sp),
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
            todayTextStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 11.sp, color: Theme.of(context).colorScheme.primary),
            todayDecoration: const BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            disabledTextStyle: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 11.sp, color: Colors.black38),
            defaultTextStyle: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 11.sp, color: Colors.black),
            weekendTextStyle: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 11.sp, color: Colors.black),
            selectedTextStyle: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 11.sp, color: Colors.white),
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
        SizedBox(height: 1.h),
        Container(
          height: 0.1.w,
          // width: double.infinity,
          decoration: BoxDecoration(
              // color: Theme.of(context).colorScheme.primary,
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).shadowColor,
                    offset: const Offset(0, 0),
                    blurStyle: BlurStyle.normal,
                    blurRadius: 1)
              ]),
        ),
        SizedBox(height: 3.h),
        Expanded(
          child: ValueListenableBuilder<List<CalendarEvent>>(
            valueListenable: _selectedEvents,
            builder: (context, value, _) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      onTap: () => print('${value[index]}'),
                      title: Text('${value[index]}'),
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
