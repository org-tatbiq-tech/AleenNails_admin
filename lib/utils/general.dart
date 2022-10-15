import 'package:appointments/localization/language/languages.dart';
import 'package:flutter/material.dart';

Map timeOfDayToDB(TimeOfDay? timeOfDay) {
  // Converter from TimeOfDay to firebase DB document
  if (timeOfDay == null) {
    return {
      'hour': null,
      'minute': null,
    };
  }
  return {
    'hour': timeOfDay.hour,
    'minute': timeOfDay.minute,
  };
}

TimeOfDay? DBToTimeOfDay(Map data) {
  // Converter from firebase DB document to TimeOfDay
  if (data['hour'] == null || data['minute'] == null) {
    return null;
  }

  return TimeOfDay(
    hour: data['hour'],
    minute: data['minute'],
  );
}

String getTimeOfDayFormat(TimeOfDay? timeOfDay) {
  if (timeOfDay == null) {
    return '';
  }
  return '${timeOfDay.hour.toString().padLeft(2, '0')}:${timeOfDay.minute.toString().padLeft(2, '0')}';
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

String getDayName(context, day) {
  /// Returns name by selected lang
  switch (day) {
    case "Sunday":
      return Languages.of(context)!.labelSunday;
    case "Monday":
      return Languages.of(context)!.labelMonday;
    case "Tuesday":
      return Languages.of(context)!.labelTuesday;
    case "Wednesday":
      return Languages.of(context)!.labelWednesday;
    case "Thursday":
      return Languages.of(context)!.labelThursday;
    case "Friday":
      return Languages.of(context)!.labelFriday;
    case "Saturday":
      return Languages.of(context)!.labelSaturday;
    default:
      return "!";
  }
}
