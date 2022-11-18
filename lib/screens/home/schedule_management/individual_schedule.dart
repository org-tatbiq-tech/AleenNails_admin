import 'package:appointments/data_types/macros.dart';
import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/langs.dart';
import 'package:appointments/utils/general.dart';
import 'package:common_widgets/custom_expandable_calendar.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/ease_in_animation.dart';
import 'package:common_widgets/utils/date.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:provider/provider.dart';
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
  DateTime? _selectedDay = kToday;

  List<FlutterWeekViewEvent> _getEventsForDay(DateTime day) {
    // return kEvents[day] ?? [];
    return [];
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
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => DayDetails(
        //       isIndividual: true,
        //       dayTile: getDateTimeFormat(
        //         isDayOfWeek: true,
        //         dateTime: _selectedDay,
        //         format: 'EEE, dd MMM yyyy',
        //       ),
        //     ),
        //   ),
        // )
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: rSize(10),
          left: rSize(10),
          right: rSize(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    workingDay.day,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(
                    height: rSize(2),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    getTimeOfDayFormat(workingDay.startTime!),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    ' - ',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    getTimeOfDayFormat(workingDay.endTime!),
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
    getLocale() {
      final localeMgr = Provider.of<LocaleData>(context, listen: false);
      return localeMgr.locale.languageCode;
    }

    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText: 'Opening Calendar',
          withBack: true,
          withBorder: true,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          CustomExpandableCalendar(
            customExpandableCalendarProps: CustomExpandableCalendarProps(
              focusedDay: _focusedDay,
              selectedDay: _selectedDay,
              calendarFormat: _calendarFormat,
              locale: getLocale(),
              availableCalendarFormats: {
                CalendarFormat.month: Languages.of(context)!.monthLabel
              },
              formatButtonVisible: false,
              firstDay: kToday,
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
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: rSize(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: rSize(20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomIcon(
                      customIconProps: CustomIconProps(
                        icon: null,
                        path: 'assets/icons/tab_hand.png',
                        iconColor: Theme.of(context).colorScheme.primary,
                        containerSize: rSize(30),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    SizedBox(
                      width: rSize(5),
                    ),
                    Text(
                      'Adjust opening hours for any day independently.',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(fontSize: rSize(14)),
                    ),
                  ],
                ),
                Divider(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.7),
                  height: rSize(30),
                  thickness: rSize(1),
                ),
                _renderDay(
                  workingDay: WorkingDay(
                    day: getDateTimeFormat(
                      dateTime: _selectedDay,
                      format: 'EEEE',
                      locale: getCurrentLocale(context),
                    ),
                    // startTime: kToday,
                    // endTime: kToday,
                  ),
                ),
                Divider(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.5),
                  height: rSize(30),
                  thickness: rSize(1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
