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
  String? description; // Service description
  List<String>? imageFBS; // List of firebase storage image id
  String? noteMessage; // Service notification message
  bool onlineBooking; // Whether this service allows online booking or not
  int? priority;

  Service({
    required this.id,
    required this.name,
    required this.cost,
    required this.duration,
    required this.colorID,
    this.description,
    this.imageFBS,
    this.noteMessage,
    required this.onlineBooking,
    this.priority,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cost': cost,
      'duration': duration.inMinutes.toString(),
      'colorID': colorID,
      'description': description,
      'imageFBS': imageFBS,
      'noteMessage': noteMessage,
      'onlineBooking': onlineBooking,
      'priority': priority,
    };
  }

  factory Service.fromJson(Map<String, dynamic> doc) {
    return Service(
      id: doc["id"],
      name: doc["name"],
      cost: doc['cost'],
      duration: Duration(minutes: int.parse(doc['duration'])),
      colorID: doc['colorID'],
      description: doc['description'],
      noteMessage: doc['noteMessage'],
      onlineBooking: doc['onlineBooking'],
      priority: doc['priority'],
    );
  }
}

/// Appointment service - holds partial details on service pin particular
/// appointment (e.g. start time, service with getters)
class AppointmentService {
  String id; // Service ID (if required to fetch from DB)
  String name; // Service name
  DateTime startTime; // Service starting time
  Duration duration; // service duration
  double cost; // Service cost
  int colorID; // Service color ID (hex or color.toString())

  AppointmentService({
    required this.id,
    required this.name,
    required this.startTime,
    required this.duration,
    required this.cost,
    required this.colorID,
  });

  DateTime get endTime {
    return startTime.add(duration);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'startTime': Timestamp.fromDate(startTime),
      'cost': cost,
      'colorID': colorID,
      'duration': duration.inMinutes.toString(),
    };
  }

  factory AppointmentService.fromJson(Map<String, dynamic> doc) {
    return AppointmentService(
      id: doc['id'],
      name: doc['name'],
      startTime: doc['startTime'].toDate(),
      cost: doc['cost'],
      colorID: doc['colorID'],
      duration: Duration(minutes: int.parse(doc['duration'])),
    );
  }
}

/// PaymentStatus - Describe the status of the payment
enum PaymentStatus {
  paid,
  unpaid,
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
  String? notes; // Appointment detailed notes
  List<AppointmentService> services;
  PaymentStatus paymentStatus;

  Appointment({
    required this.id,
    required this.status,
    required this.creator,
    required this.clientName,
    required this.clientPhone,
    required this.clientDocID,
    required this.creationDate,
    required this.date,
    this.notes,
    required this.services,
    required this.paymentStatus,
  });

  double get totalCost {
    return services.fold<double>(0, (sum, item) => sum + item.cost);
  }

  int get totalDurationInMins {
    return (services.fold<double>(
        0, (sum, item) => sum + item.duration.inMinutes)).toInt();
  }

  DateTime get endTime {
    return date.add(Duration(minutes: totalDurationInMins));
  }

  DateTime get dayDate {
    // Getting day details only (day, month, year)
    return DateTime(date.year, date.month, date.day);
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
      'dayDate': Timestamp.fromDate(dayDate),
      'notes': notes,
      'services': services.map((service) => service.toJson()).toList(),
      'paymentStatus': paymentStatus.toString(),
    };
  }

  factory Appointment.fromJson(Map<String, dynamic> doc) {
    List<AppointmentService> loadServicesFromDoc(List<dynamic> docServices) {
      List<AppointmentService> services = [];
      for (Map<String, dynamic> s in docServices) {
        services.add(AppointmentService.fromJson(s));
      }
      return services;
    }

    PaymentStatus loadPaymentStatus(String status) {
      switch (status) {
        case 'PaymentStatus.paid':
          return PaymentStatus.paid;
        case 'PaymentStatus.unpaid':
          return PaymentStatus.unpaid;
        default:
          return PaymentStatus.unpaid;
      }
    }

    Status loadStatus(String status) {
      switch (status) {
        case 'Status.waiting':
          return Status.waiting;
        case 'Status.unpaid':
          return Status.cancelled;
        case 'Status.confirmed':
          return Status.confirmed;
        case 'Status.declined':
          return Status.declined;
        default:
          return Status.waiting;
      }
    }

    return Appointment(
      id: doc["id"],
      status: loadStatus(doc["status"]),
      creator: doc['creator'],
      clientName: doc['clientName'],
      clientDocID: doc['clientDocID'],
      clientPhone: doc['clientPhone'],
      creationDate: doc['creationDate'].toDate(),
      notes: doc['notes'],
      date: doc['date'].toDate(),
      services: loadServicesFromDoc(doc['services']),
      paymentStatus: loadPaymentStatus(doc['paymentStatus']),
    );
  }
}

/// Client holds all required data to define, understand and explain
/// an client to its details
class Client {
  String id; // Client ID (Created by DB)
  String fullName; // Client full name
  String phone; // Client phone numbers
  String address; // Client physical address
  String email; // Client email
  String? generalNotes; // General notes about client
  String? profileImage; // Profile Image (Avatar)
  DateTime? birthday; // Birthday date
  DateTime creationDate; // Client creation date
  DateTime? acceptedDate; // Birthday date
  double? discount; // general discount for client
  bool? isTrusted; // Birthday date

  Client({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.address,
    required this.email,
    this.generalNotes,
    this.profileImage,
    this.birthday,
    required this.creationDate,
    this.acceptedDate,
    this.discount,
    this.isTrusted,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'phone': phone,
      'address': address,
      'email': email,
      'generalNotes': generalNotes,
      'profileImage': profileImage,
      'birthday': birthday != null ? Timestamp.fromDate(birthday!) : '',
      'creationDate': Timestamp.fromDate(creationDate),
      'acceptedDate': Timestamp.fromDate(creationDate),
      'discount': discount,
      'isTrusted': isTrusted,
    };
  }

  factory Client.fromJson(Map<String, dynamic> doc) {
    return Client(
      id: doc['id'],
      fullName: doc['fullName'],
      phone: doc['phone'],
      address: doc['address'],
      email: doc['email'],
      creationDate: doc['creationDate'].toDate(),
      generalNotes: doc['generalNotes'],
      birthday: doc['birthday'].toDate(),
      discount: doc['discount'],
      isTrusted: doc['isTrusted'],
    );
  }
}

/// NotificationData holds all required data to define, understand and explain
/// an Notification to its details
///
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
