import 'dart:collection';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'data_types.dart';

/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<CalendarEvent>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = {
  for (var item in List.generate(50, (index) => index))
    DateTime.utc(getFirstDay().year, getFirstDay().month, item * 5):
        List.generate(item % 4 + 1,
            (index) => CalendarEvent('CalendarEvent $item | ${index + 1}'))
}..addAll({
    kToday: [
      CalendarEvent('Today\'s CalendarEvent 1'),
      CalendarEvent('Today\'s CalendarEvent 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

DateTime getFirstDay({int years = 0, int months = 3, int days = 0}) {
  return DateTime(
      kToday.year - years, kToday.month - months, kToday.day - days);
}

DateTime getLastDay({int years = 0, int months = 3, int days = 0}) {
  return DateTime(
      kToday.year + years, kToday.month + months, kToday.day + days);
}

String getDateTimeFormat({
  DateTime? dateTime,
  String format = 'HH-mm',
}) {
  final _dateFormat = DateFormat(format);
  return _dateFormat.format(dateTime!);
}

final kToday = DateTime.now();
