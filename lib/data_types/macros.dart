import 'package:flutter/material.dart';

// TODO: Ahmad add documentation in each of the classed below
// Where it is used and how ?
/// Add documentation here - general documentation
/// ...

class CalendarEvent {
  /// Add documentation here
  /// ...

  final String title;
  const CalendarEvent(this.title);
  @override
  String toString() => title;
}

class LiquidSwipeData {
  final Color gradientStart;
  final Color gradientEnd;
  final String image;
  final String title;
  final String subTitle;
  final String description;

  LiquidSwipeData({
    this.gradientStart = Colors.white,
    this.gradientEnd = Colors.white,
    required this.image,
    this.title = '',
    this.subTitle = '',
    this.description = '',
  });
}

class WorkingDayBreak {
  DateTime startTime;
  DateTime endTime;

  WorkingDayBreak({
    required this.startTime,
    required this.endTime,
  });
}

class WorkingDay {
  String title;
  String subTitle;
  DateTime? selectedDate;
  DateTime startTime;
  DateTime endTime;
  bool isDayOff;
  List<WorkingDayBreak>? breaks;

  WorkingDay({
    required this.title,
    this.subTitle = '',
    required this.startTime,
    required this.endTime,
    this.selectedDate,
    this.breaks,
    this.isDayOff = false,
  });
}

enum Status {
  confirmed,
  declined,
  cancelled,
  waiting,
}
