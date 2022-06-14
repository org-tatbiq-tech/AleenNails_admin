import 'package:appointments/animations/fade_animation.dart';
import 'package:appointments/widget/custom_status.dart';
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
  /// Add documentation here
  /// ...
  /// Please don't use text1/text2/..., use meaningful names
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

class Client {
  String? name;
  String? phone;
  String? address;

  Client({
    this.name,
    this.phone,
    this.address,
  });
}

class Service {
  String? id;
  String? name;
  String? duration;
  DateTime? startTime;
  DateTime? endTime;
  double? price;
  String? notes;
  Color? color;
  bool createdByBusiness;

  Service({
    this.id,
    this.name,
    this.duration,
    this.startTime,
    this.endTime,
    this.price,
    this.notes,
    this.color,
    this.createdByBusiness = false,
  });
}

class Appointment {
  String? id;
  List<Service> services;
  DateTime date;
  double totalPrice;
  Status status;

  Appointment({
    this.id,
    this.services = const [],
    required this.date,
    this.totalPrice = 0,
    required this.status,
  });
}
