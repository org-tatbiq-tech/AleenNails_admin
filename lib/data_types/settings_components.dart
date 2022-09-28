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
    Map<String, dynamic> docSchedule =
        Map<String, dynamic>.from(doc['schedule']);

    Map<String, WorkingDay> wdSchedule = {};
    for (var dayDetails in docSchedule.entries) {
      wdSchedule[dayDetails.key] = WorkingDay.fromJson(dayDetails.value);
    }

    return WorkingDaysComp(
      schedule: wdSchedule,
      notes: doc['notes'],
    );
  }
}

class UnavailabilityData {
  /// Describes when and why is getting to be unavailable
  DateTime? startTime;
  DateTime? endTime;
  String notes;

  UnavailabilityData({this.startTime, this.endTime, this.notes = ''});

  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime != null ? Timestamp.fromDate(startTime!) : null,
      'endTime': endTime != null ? Timestamp.fromDate(endTime!) : null,
      'notes': notes,
    };
  }

  factory UnavailabilityData.fromJson(Map<String, dynamic> doc) {
    return UnavailabilityData(
      startTime: doc['startTime'] != null
          ? doc['startTime'].toDate()
          : doc['startTime'],
      endTime:
          doc['endTime'] != null ? doc['endTime'].toDate() : doc['endTime'],
      notes: doc['notes'],
    );
  }
}

class ScheduleManagement {
  WorkingDaysComp? workingDays;
  UnavailabilityData? unavailability;

  ScheduleManagement({
    workingDays,
    unavailability,
  }) {
    this.workingDays = workingDays ?? WorkingDaysComp();
    this.unavailability = unavailability ?? UnavailabilityData();
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
      unavailability: UnavailabilityData.fromJson(doc['unavailability']),
    );
  }
}
