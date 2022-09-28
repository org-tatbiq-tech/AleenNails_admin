String durationToFormat({required Duration duration, String format = ''}) {
  String hours = duration.inHours.toString().padLeft(0, '2');
  String minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  return '$hours:$minutes';
}

DateTime nearestFive(DateTime val) {
  return DateTime(val.year, val.month, val.day, val.hour, val.minute ~/ 5 * 10);
}
