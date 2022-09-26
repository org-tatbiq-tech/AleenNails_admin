import 'package:appointments/data_types/macros.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Settings components

class WorkingDaysComp {
  /// Defines working status per day
  // Need to take days from localization
  Map<String, WorkingDay>? schedule;
  Map<String, WorkingDay>? defSchedule = {
    'Sunday': WorkingDay(
      day: 'Sunday',
    ),
    'Monday': WorkingDay(
      day: 'Monday',
    ),
    'Tuesday': WorkingDay(
      day: 'Tuesday',
    ),
    'Wednesday': WorkingDay(
      day: 'Wednesday',
    ),
    'Thursday': WorkingDay(
      day: 'Thursday',
    ),
    'Friday': WorkingDay(
      day: 'Friday',
    ),
    'Saturday': WorkingDay(
      day: 'Saturday',
    ),
  };

  String notes;

  WorkingDaysComp({schedule, this.notes = ''}) {
    this.schedule = schedule ?? defSchedule;
  }

  Map<String, dynamic> toJson() {
    return {
      'schedule': schedule!.map(
        (day, workingDay) => MapEntry(
          day,
          workingDay.toJson(),
        ),
      ),
      'notes': notes,
    };
  }

  factory WorkingDaysComp.fromJson(Map<String, dynamic> doc) {
    return WorkingDaysComp(
      schedule: doc['schedule'].map(
        (key, value) => MapEntry(
          key,
          WorkingDay.fromJson(value),
        ),
      ),
      notes: doc['notes'],
    );
  }
}

class Unavailability {
  /// Describes when and why is getting to be unavailable
  DateTime? startTime;
  DateTime? endTime;

  Unavailability({this.startTime, this.endTime});

  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime != null ? Timestamp.fromDate(startTime!) : null,
      'endTime': endTime != null ? Timestamp.fromDate(endTime!) : null,
    };
  }

  factory Unavailability.fromJson(Map<String, dynamic> doc) {
    return Unavailability(
      startTime: doc['startTime'],
      endTime: doc['endTime'],
    );
  }
}

class ScheduleManagement {
  WorkingDaysComp? workingDays;
  Unavailability? unavailability;

  ScheduleManagement({
    workingDays,
    unavailability,
  }) {
    this.workingDays = workingDays ?? WorkingDaysComp();
    this.unavailability = unavailability ?? Unavailability();
  }

  Map<String, dynamic> toJson() {
    return {
      'workingDays': workingDays!.toJson(),
      'unavailability': unavailability!.toJson(),
    };
  }

  factory ScheduleManagement.fromJson(Map<String, dynamic> doc) {
    return ScheduleManagement(
      workingDays: WorkingDaysComp.fromJson(doc['workingDays']),
      unavailability: Unavailability.fromJson(doc['unavailability']),
    );
  }
}
