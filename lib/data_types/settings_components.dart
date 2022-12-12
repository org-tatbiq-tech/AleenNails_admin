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
  double? latitude;
  double? longitude;

  BusinessInfoComp({
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    description = '',
    facebookUrl = '',
    instagramUrl = '',
    websiteUrl = '',
    this.latitude,
    this.longitude,
  }) {
    this.description = description ?? '';
    this.facebookUrl = facebookUrl ?? '';
    this.instagramUrl = instagramUrl ?? '';
    this.websiteUrl = websiteUrl ?? '';
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
      'latitude': latitude,
      'longitude': longitude,
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
      latitude: doc['latitude'],
      longitude: doc['longitude'],
    );
  }
}

class ProfileMedia {
  String? logoPath;
  String? logoURL;
  String? coverPath;
  String? coverURL;
  Map<String, String>? wpPhotosURLsMap;

  Map<String, String> loadWPImages(Map<String, dynamic> wp) {
    Map<String, String> wps = {};
    for (MapEntry mapEntry in wp.entries) {
      wps[mapEntry.key] = mapEntry.value;
    }
    return wps;
  }

  ProfileMedia(logoPath, logoURL, coverPath, coverURL, wpPhotosURLsMap) {
    this.logoPath = logoPath ?? '';
    this.logoURL = logoURL ?? '';
    this.coverPath = coverPath ?? '';
    this.coverURL = coverURL ?? '';
    Map<String, String> wps = {};
    if (wpPhotosURLsMap != null) {
      wps = loadWPImages(wpPhotosURLsMap);
    }
    this.wpPhotosURLsMap = wps;
  }

  Map<String, dynamic> toJson() {
    return {
      'logoPath': logoPath,
      'logoURL': logoURL,
      'coverPath': coverPath,
      'coverURL': coverURL,
      'wp': wpPhotosURLsMap,
    };
  }

  factory ProfileMedia.fromJson(Map<String, dynamic> doc) {
    return ProfileMedia(
      doc['logoPath'],
      doc['logoURL'],
      doc['coverPath'],
      doc['coverURL'],
      doc['wp'],
    );
  }
}

class ProfileManagement {
  BusinessInfoComp businessInfo;
  ProfileMedia profileMedia;

  ProfileManagement({required this.businessInfo, required this.profileMedia});

  Map<String, dynamic> toJson() {
    return {
      'businessInfo': businessInfo.toJson(),
      'media': profileMedia.toJson(),
    };
  }

  factory ProfileManagement.fromJson(Map<String, dynamic> doc) {
    return ProfileManagement(
      businessInfo: BusinessInfoComp.fromJson(
        doc['businessInfo'] ?? {},
      ),
      profileMedia: ProfileMedia.fromJson(
        doc['media'] ?? {},
      ),
    );
  }
}

/// Booking
class BookingSettingComp {
  int bookingWindowMinutes;
  int reschedulingWindowHours;
  int futureBookingDays;

  BookingSettingComp({
    this.bookingWindowMinutes = 6 * 60,
    this.reschedulingWindowHours = 6,
    this.futureBookingDays = 2 * 30,
  });

  Map<String, dynamic> toJson() {
    return {
      'bookingWindowMins': bookingWindowMinutes,
      'reschedulingWindowHours': reschedulingWindowHours,
      'futureBookingDays': futureBookingDays,
    };
  }

  factory BookingSettingComp.fromJson(Map<String, dynamic> doc) {
    return BookingSettingComp(
      bookingWindowMinutes: doc['bookingWindowMins'],
      reschedulingWindowHours: doc['reschedulingWindowHours'],
      futureBookingDays: doc['futureBookingDays'],
    );
  }
}
