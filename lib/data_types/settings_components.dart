import 'package:appointments/data_types/macros.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Settings components

/// Schedule management
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
    if (schedule == null || schedule.isEmpty) {
      this.schedule = defSchedule;
    } else {
      this.schedule = schedule;
    }
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
        Map<String, dynamic>.from(doc['schedule'] ?? {});

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

class UnavailabilityComp {
  /// Describes when and why is getting to be unavailable
  DateTime? startTime;
  DateTime? endTime;
  String notes;

  UnavailabilityComp({this.startTime, this.endTime, this.notes = ''});

  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime != null ? Timestamp.fromDate(startTime!) : null,
      'endTime': endTime != null ? Timestamp.fromDate(endTime!) : null,
      'notes': notes,
    };
  }

  factory UnavailabilityComp.fromJson(Map<String, dynamic> doc) {
    return UnavailabilityComp(
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
  List<UnavailabilityComp>? unavailabilityList;

  ScheduleManagement({
    workingDays,
    unavailabilityList,
  }) {
    this.workingDays = workingDays ?? WorkingDaysComp();
    this.unavailabilityList = unavailabilityList ?? [];
  }

  Map<String, dynamic> toJson() {
    return {
      'workingDays': workingDays!.toJson(),
      'unavailability': unavailabilityList!.map((e) => e.toJson()).toList(),
    };
  }

  factory ScheduleManagement.fromJson(Map<String, dynamic> doc) {
    List<UnavailabilityComp> unavailabilityList = [];
    for (var unavailabilityElement in doc['unavailability']) {
      unavailabilityList
          .add(UnavailabilityComp.fromJson(unavailabilityElement));
    }
    return ScheduleManagement(
      workingDays: WorkingDaysComp.fromJson(doc['workingDays']),
      unavailabilityList: unavailabilityList,
    );
  }
}

/// Profile
class BusinessInfoComp {
  String name;
  String phone;
  String email;
  String address;
  String? description;
  String? facebookUrl;
  String? instagramUrl;
  String? websiteUrl;
  String? wazeAddressUrl;

  BusinessInfoComp({
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    description = '',
    facebookUrl = '',
    instagramUrl = '',
    websiteUrl = '',
    wazeAddressUrl = '',
  }) {
    this.description = description ?? '';
    this.facebookUrl = facebookUrl ?? '';
    this.instagramUrl = instagramUrl ?? '';
    this.websiteUrl = websiteUrl ?? '';
    this.wazeAddressUrl = wazeAddressUrl ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'description': description,
      'facebookUrl': facebookUrl,
      'instagramUrl': instagramUrl,
      'websiteUrl': websiteUrl,
      'wazeAddressUrl': wazeAddressUrl,
    };
  }

  factory BusinessInfoComp.fromJson(Map<String, dynamic> doc) {
    return BusinessInfoComp(
      name: doc['name'] ?? '',
      phone: doc['phone'] ?? '',
      email: doc['email'] ?? '',
      address: doc['address'] ?? '',
      description: doc['description'] ?? '',
      facebookUrl: doc['facebookUrl'] ?? '',
      instagramUrl: doc['instagramUrl'] ?? '',
      websiteUrl: doc['websiteUrl'] ?? '',
      wazeAddressUrl: doc['wazeAddressUrl'] ?? '',
    );
  }
}

class ProfileMedia {
  // Logo
  // Cover photo
  // Workplace photos
}

class ProfileManagement {
  BusinessInfoComp businessInfo;
  ProfileMedia? profileMedia;

  ProfileManagement({required this.businessInfo, this.profileMedia});

  Map<String, dynamic> toJson() {
    return {
      'businessInfo': businessInfo.toJson(),
    };
  }

  factory ProfileManagement.fromJson(Map<String, dynamic> doc) {
    return ProfileManagement(
      businessInfo: BusinessInfoComp.fromJson(
        doc['businessInfo'],
      ),
    );
  }
}

/// Booking
class BookingSettingComp {
// Hold for now
}
