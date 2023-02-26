import 'package:appointments/utils/general.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum NotificationCategory {
  appointment,
  user,
}

enum AppointmentStatus {
  confirmed,
  declined,
  cancelled,
  waiting,
  noShow,
  finished,
}

enum PaymentStatus {
  paid,
  unpaid,
}

//TODO rename this class as AppointmentEditor
enum AppointmentCreator {
  business,
  client,
}

enum DiscountType {
  percent,
  fixed,
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
  String? id;
  DateTime? date;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  bool isDayOn;
  List<WorkingDayBreak>? breaks;

  WorkingDay({
    required this.day,
    this.id,
    this.date,
    this.startTime,
    this.endTime,
    breaks,
    this.isDayOn = false,
  }) {
    if (breaks == null) {
      this.breaks = [];
    } else {
      this.breaks = breaks;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'id': id,
      'date': date != null ? Timestamp.fromDate(date!) : null,
      'startTime': timeOfDayToDB(startTime),
      'endTime': timeOfDayToDB(endTime),
      'isDayOn': isDayOn,
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
      id: doc['id'],
      date: doc['date'] != null && doc['date'].toString().isNotEmpty
          ? doc['date'].toDate()
          : null,
      startTime: DBToTimeOfDay(doc['startTime']),
      endTime: DBToTimeOfDay(doc['endTime']),
      breaks: loadBreaks(doc['breaks']),
      isDayOn: doc['isDayOn'],
    );
  }
}
