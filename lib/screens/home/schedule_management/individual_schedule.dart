import 'package:appointments/screens/home/schedule_management/day_details.dart';
import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/date.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/calendar_view/flutter_week_view.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:appointments/widget/expandable_calendar.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class IndividualSchedule extends StatefulWidget {
  const IndividualSchedule({Key? key}) : super(key: key);

  @override
  State<IndividualSchedule> createState() => _IndividualScheduleState();
}

class _IndividualScheduleState extends State<IndividualSchedule> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DayViewController dayViewController = DayViewController();
  DateTime _focusedDay = kToday;
  DateTime? _selectedDay;

  List<CalendarEvent> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        // _calendarFormat = CalendarFormat.week;
      });

      // _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  _renderDay({required WorkingDay workingDay}) {
    return EaseInAnimation(
      beginAnimation: 1,
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DayDetails(
              dayTile: workingDay.title,
            ),
          ),
        )
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: rSize(10),
          vertical: rSize(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text(
                workingDay.title,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            Expanded(
              child: workingDay.isEnable
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          getDateTimeFormat(dateTime: workingDay.startTime),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const Text(' - '),
                        Text(
                          getDateTimeFormat(dateTime: workingDay.startTime),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Closed',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
            ),
            IconTheme(
              data: Theme.of(context).primaryIconTheme,
              child: Icon(
                Icons.chevron_right,
                size: rSize(25),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText: 'Opening Calendar',
          withBack: true,
          withBorder: true,
          // customIconTap: () => {_getSettingInfo()},
          // customIcon: CustomIcon(
          //   customIconProps: CustomIconProps(
          //     icon: null,
          //     path: 'assets/icons/question.png',
          //     contentPadding: rSize(8),
          //     withPadding: true,
          //   ),
          // ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          ExpandableCalendar(
            expandableCalendarProps: ExpandableCalendarProps(
              focusedDay: _focusedDay,
              selectedDay: _selectedDay,
              calendarFormat: _calendarFormat,
              formatButtonVisible: false,
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
              // availableCalendarFormats: {},
            ),
          ),
          _renderDay(
            workingDay: WorkingDay(
              title: getDateTimeFormat(
                dateTime: kToday,
                format: 'DDDD-MM-YYYY',
              ),
              startTime: kToday,
              endTime: kToday,
            ),
          )
        ],
      ),
    );
  }
}
