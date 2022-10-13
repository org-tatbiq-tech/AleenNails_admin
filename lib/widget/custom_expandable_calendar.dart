import 'package:appointments/localization/language/languages.dart';
import 'package:common_widgets/utils/date.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:appointments/providers/langs.dart';

class CustomExpandableCalendar extends StatelessWidget {
  final CustomExpandableCalendarProps customExpandableCalendarProps;
  const CustomExpandableCalendar({
    required this.customExpandableCalendarProps,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getLocale() {
      String x = LocaleData().locale.toLanguageTag();
      print(x);
    }

    return Card(
      elevation: 1,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, rSize(15)),
        child: TableCalendar<FlutterWeekViewEvent>(
          // locale: getLocale(), // need to add the chosen locale
          locale: 'he',
          headerVisible: true,
          availableCalendarFormats:
              customExpandableCalendarProps.availableCalendarFormats ??
                  {
                    CalendarFormat.month: Languages.of(context)!.monthLabel,
                    CalendarFormat.week: Languages.of(context)!.weekLabel,
                  },
          firstDay: customExpandableCalendarProps.firstDay ?? getFirstDay(),
          lastDay: customExpandableCalendarProps.lastDay ?? getLastDay(),
          daysOfWeekHeight: rSize(30),
          rowHeight: rSize(45),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
            weekendStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
          headerStyle: HeaderStyle(
            leftChevronIcon: IconTheme(
              data:
                  Theme.of(context).primaryIconTheme.copyWith(size: rSize(30)),
              child: const Icon(
                Icons.chevron_left,
              ),
            ),
            rightChevronIcon: IconTheme(
              data:
                  Theme.of(context).primaryIconTheme.copyWith(size: rSize(30)),
              child: const Icon(
                Icons.chevron_right,
              ),
            ),
            headerPadding: EdgeInsets.symmetric(
              vertical: rSize(5),
              horizontal: 0,
            ),
            formatButtonPadding:
                EdgeInsets.symmetric(horizontal: rSize(12), vertical: rSize(6)),
            formatButtonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(rSize(6)),
              color: Theme.of(context).colorScheme.primary,
            ),
            formatButtonTextStyle: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.white, fontSize: rSize(14)),
            formatButtonVisible:
                customExpandableCalendarProps.formatButtonVisible,
            formatButtonShowsNext: false,
            titleTextStyle: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
            titleCentered: false,
          ),
          focusedDay: customExpandableCalendarProps.focusedDay,
          selectedDayPredicate: (day) =>
              isSameDay(customExpandableCalendarProps.selectedDay, day),
          calendarFormat: customExpandableCalendarProps.calendarFormat,
          rangeSelectionMode: RangeSelectionMode.disabled,
          eventLoader: customExpandableCalendarProps.eventLoader,
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
            disabledTextStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.7),
                ),
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
          onDaySelected: customExpandableCalendarProps.onDaySelected,
          onFormatChanged: customExpandableCalendarProps.onFormatChanged,
          onPageChanged: customExpandableCalendarProps.onPageChanged,
        ),
      ),
    );
  }
}

class CustomExpandableCalendarProps {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final DateTime? firstDay;
  final DateTime? lastDay;
  final CalendarFormat calendarFormat;
  final Map<CalendarFormat, String>? availableCalendarFormats;
  List<FlutterWeekViewEvent> Function(DateTime)? eventLoader;
  void Function(DateTime, DateTime)? onDaySelected;
  void Function(CalendarFormat)? onFormatChanged;
  void Function(DateTime)? onPageChanged;
  final bool formatButtonVisible;
  CustomExpandableCalendarProps({
    required this.focusedDay,
    this.selectedDay,
    this.firstDay,
    this.lastDay,
    required this.calendarFormat,
    this.eventLoader,
    this.onDaySelected,
    this.onFormatChanged,
    this.onPageChanged,
    this.availableCalendarFormats,
    this.formatButtonVisible = true,
  });
}
