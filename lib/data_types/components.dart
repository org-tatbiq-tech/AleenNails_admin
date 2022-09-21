import 'package:cloud_firestore/cloud_firestore.dart';

import 'macros.dart';

/// Data components

/// Service hold all required data to define, understand and explain
/// a provided service
class Service {
  String id; // Service ID (created by DB)
  String name; // Service name
  double cost; // Service cost
  Duration duration; // Service time duration (2 hours, 1.5 hours,...)
  int colorID; // Service hex color (color.hex/color.toString())
  String desc; // Service description
  String imageFBS; // Firebsae storage image id
  String notMessage; // Service notification message
  bool onlineBooking; // Whether this service allows online booking or not

  Service(
    this.id,
    this.name,
    this.cost,
    this.duration,
    this.colorID,
    this.desc,
    this.imageFBS,
    this.notMessage,
    this.onlineBooking,
  );
}

/// Appointment service - holds partial details on service pin particular
/// appointment (e.g. start time, service with getters)
class AppointmentService {
  String id; // Service ID (if required to fetch from DB)
  String name; // Service name
  DateTime startTime; // Service starting time
  DateTime endTime; // Service ending time
  Duration duration; // service duration
  double cost; // Service cost
  int colorID; // Service color ID (hex or color.toString())

  AppointmentService(
    this.id,
    this.name,
    this.startTime,
    this.endTime,
    this.duration,
    this.cost,
    this.colorID,
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'startTime': Timestamp.fromDate(startTime),
      'endTime': Timestamp.fromDate(endTime),
      'cost': cost,
      'colorID': colorID,
    };
  }
}

/// Appointment holds all required data to define, understand and explain
/// an appointment to its details
class Appointment {
  String id; // Appointment ID (created by DB)
  Status status; // Appointment Status
  String creator; // Appointment creator (which admin/worker/...)
  String clientName; // Client full name
  String clientPhone; // Client phone number
  String clientDocID; // Client database ID
  DateTime creationDate; // Appointment creation date (date and time)
  DateTime date; // Appointment date (date and time)
  String notes; // Appointment detailed notes
  List<AppointmentService> services;

  Appointment(
    this.id,
    this.status,
    this.creator,
    this.clientName,
    this.clientPhone,
    this.clientDocID,
    this.creationDate,
    this.date,
    this.notes,
    this.services,
  );

  double get totalCost {
    return services.fold<double>(0, (sum, item) => sum + item.cost);
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status.toString(),
      'creator': creator,
      'clientName': clientName,
      'clientDocID': clientDocID,
      'clientPhone': clientPhone,
      'creationDate': Timestamp.fromDate(creationDate),
      'date': Timestamp.fromDate(date),
      'notes': notes,
      'services': services.map((service) => service.toJson()).toList(),
    };
  }
}

/// business client
class Client {
  String id; // Client ID (Created by DB)
  String name; // Client full name
  String phone; // Client phone numbers
  String address; // Client physical address
  String email; // Client email

  Client(
    this.id,
    this.name,
    this.phone,
    this.address,
    this.email,
  );
}

class NotificationData {
  String id;
  String description;
  DateTime creationDate;

  NotificationData(
    this.id,
    this.description,
    this.creationDate,
  );
}
