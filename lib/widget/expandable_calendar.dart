import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/date.dart';
import 'package:appointments/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ExpandableCalendar extends StatelessWidget {
  final ExpandableCalendarProps expandableCalendarProps;
  const ExpandableCalendar({
    required this.expandableCalendarProps,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, rSize(15)),
        child: TableCalendar<CalendarEvent>(
          availableCalendarFormats:
              expandableCalendarProps.availableCalendarFormats ??
                  {
                    CalendarFormat.month: Languages.of(context)!.monthLabel,
                    CalendarFormat.week: Languages.of(context)!.weekLabel,
                  },
          firstDay: expandableCalendarProps.firstDay ?? getFirstDay(),
          lastDay: expandableCalendarProps.lastDay ?? getLastDay(),
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
            formatButtonVisible: expandableCalendarProps.formatButtonVisible,
            formatButtonShowsNext: false,
            titleTextStyle: Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(color: Theme.of(context).colorScheme.outline),
            titleCentered: false,
          ),
          focusedDay: expandableCalendarProps.focusedDay,
          selectedDayPredicate: (day) =>
              isSameDay(expandableCalendarProps.selectedDay, day),
          calendarFormat: expandableCalendarProps.calendarFormat,
          rangeSelectionMode: RangeSelectionMode.disabled,
          eventLoader: expandableCalendarProps.eventLoader,
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
          onDaySelected: expandableCalendarProps.onDaySelected,
          onFormatChanged: expandableCalendarProps.onFormatChanged,
          onPageChanged: expandableCalendarProps.onPageChanged,
        ),
      ),
    );
  }
}
