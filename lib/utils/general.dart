import 'package:appointments/data_types/macros.dart';
import 'package:flutter/material.dart';

import 'layout.dart';

getStatusColor(AppointmentStatus status) {
  switch (status) {
    case AppointmentStatus.confirmed:
      return successPrimaryColor;
    case AppointmentStatus.cancelled:
      return errorPrimaryColor;
    case AppointmentStatus.declined:
      return errorPrimaryColor;
    case AppointmentStatus.waiting:
      return warningPrimaryColor;
    default:
      return informationPrimaryColor;
  }
}

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
