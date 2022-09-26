import 'package:appointments/utils/general.dart';
import 'package:flutter/material.dart';

enum AppointmentStatus {
  confirmed,
  declined,
  cancelled,
  waiting,
}

enum PaymentStatus {
  paid,
  unpaid,
}

class WorkingDayBreak {
  /// Defines break start and end time
  TimeOfDay startTime;
  TimeOfDay endTime;

  WorkingDayBreak({
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'startTime': timeOfDayToDB(startTime),
      'endTime': timeOfDayToDB(endTime),
    };
  }

  factory WorkingDayBreak.fromJson(Map<String, dynamic> doc) {
    return WorkingDayBreak(
      startTime: DBToTimeOfDay(doc['startTime'])!,
      endTime: DBToTimeOfDay(doc['endTime'])!,
    );
  }
}

class WorkingDay {
  /// Defines working/not working, opening/closing and breaks hours per day
  String day;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  bool isDayOff;
  List<WorkingDayBreak>? breaks;

  WorkingDay({
    required this.day,
    this.startTime,
    this.endTime,
    this.breaks,
    this.isDayOff = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'startTime': timeOfDayToDB(startTime),
      'endTime': timeOfDayToDB(endTime),
      'isDayOff': isDayOff,
      'breaks': breaks == null ? [] : breaks!.map((b) => b.toJson()).toList(),
    };
  }

  factory WorkingDay.fromJson(Map<String, dynamic> doc) {
    List<WorkingDayBreak> loadBreaks(docBreaks) {
      List<WorkingDayBreak> breaks = [];
      for (Map<String, dynamic> b in docBreaks) {
        breaks.add(WorkingDayBreak.fromJson(b));
      }
      return breaks;
    }

    return WorkingDay(
      day: doc['day'],
      startTime: DBToTimeOfDay(doc['startTime']),
      endTime: DBToTimeOfDay(doc['endTime']),
      isDayOff: doc['isDayOff'],
      breaks: loadBreaks(doc['breaks']),
    );
  }
}
