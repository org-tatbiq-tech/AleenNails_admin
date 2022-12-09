import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/langs.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

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

getCurrentLocale(BuildContext context) {
  final localeMgr = Provider.of<LocaleData>(context, listen: false);
  return localeMgr.locale.languageCode;
}

Future<bool> _handleLocationPermission(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(Languages.of(context)!.locationDisabled),
      ),
    );
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            Languages.of(context)!.locationDenied,
          ),
        ),
      );
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          Languages.of(context)!.locationTotallyDenied,
        ),
      ),
    );
    return false;
  }
  return true;
}

Future<Position?> getCurrentPosition(BuildContext context) async {
  Position? currPosition = null;
  final hasPermission = await _handleLocationPermission(context);
  if (!hasPermission) return null;
  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
      .then(
    (Position position) {
      currPosition = position;
    },
  ).catchError((e) => {
            currPosition = null,
          });
  return currPosition;
}
