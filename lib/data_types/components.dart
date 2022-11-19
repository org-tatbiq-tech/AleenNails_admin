import 'package:cloud_firestore/cloud_firestore.dart';

import 'macros.dart';

/// Data components
/// Helpers
AppointmentStatus loadAppointmentStatus(String status) {
  switch (status) {
    case 'AppointmentStatus.waiting':
      return AppointmentStatus.waiting;
    case 'AppointmentStatus.cancelled':
      return AppointmentStatus.cancelled;
    case 'AppointmentStatus.confirmed':
      return AppointmentStatus.confirmed;
    case 'AppointmentStatus.declined':
      return AppointmentStatus.declined;
    case 'AppointmentStatus.noShow':
      return AppointmentStatus.noShow;
    default:
      return AppointmentStatus.waiting;
  }
}

/// Service hold all required data to define, understand and explain
/// a provided service
class Service {
  String id; // Service ID (created by DB)
  String name; // Service name
  double cost; // Service cost
  Duration duration; // Service time duration (2 hours, 1.5 hours,...)
  int colorID; // Service hex color (color.hex/color.toString())
  String? description; // Service description
  String? noteMessage; // Service notification message
  bool onlineBooking; // Whether this service allows online booking or not
  int? priority;
  List<String>? images; // List of firebase storage image id

  Service({
    required this.id,
    required this.name,
    required this.cost,
    required this.duration,
    required this.colorID,
    this.description,
    this.noteMessage,
    required this.onlineBooking,
    this.priority,
    images,
  }) {
    this.images = [];
    if (images != null) {
      for (var image in images) {
        this.images!.add(image);
      }
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cost': cost,
      'duration': duration.inMinutes.toString(),
      'colorID': colorID,
      'description': description,
      'noteMessage': noteMessage,
      'onlineBooking': onlineBooking,
      'priority': priority,
      'images': images,
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
      images: doc['images'],
    );
  }
}

/// Appointment service - holds partial details on service per particular
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

/// Appointment holds all required data to define, understand and explain
/// an appointment to its details
class Appointment {
  String id; // Appointment ID (created by DB)
  AppointmentStatus status; // Appointment Status
  AppointmentCreator creator; // Appointment creator (which admin/worker/...)
  String clientName; // Client full name
  String clientPhone; // Client phone number
  String clientEmail; // Client Email
  String clientImagePath; // Client Image Url
  String clientDocID; // Client database ID
  DateTime creationDate; // Appointment creation date (date and time)
  DateTime date; // Appointment date (date and time)
  String notes; // Appointment detailed notes
  double discount;
  DiscountType discountType;
  List<AppointmentService> services;
  PaymentStatus paymentStatus;

  Appointment({
    required this.id,
    required this.status,
    required this.creator,
    required this.clientName,
    required this.clientPhone,
    required this.clientEmail,
    required this.clientDocID,
    required this.creationDate,
    required this.date,
    this.notes = '',
    this.clientImagePath = '',
    this.discount = 0,
    this.discountType = DiscountType.percent,
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

  Map<String, dynamic> toJson() {
    return {
      'status': status.toString(),
      'creator': creator.toString(),
      'clientName': clientName,
      'clientDocID': clientDocID,
      'clientPhone': clientPhone,
      'clientEmail': clientEmail,
      'creationDate': Timestamp.fromDate(creationDate),
      'date': Timestamp.fromDate(date),
      'notes': notes,
      'clientImagePath': clientImagePath,
      'services': services.map((service) => service.toJson()).toList(),
      'paymentStatus': paymentStatus.toString(),
      'endTime': endTime,
      'totalCost': totalCost,
      'discount': discount,
      'discountType': discountType.toString(),
    };
  }

  factory Appointment.fromAppointment(Appointment appointment) {
    return Appointment(
      id: appointment.id,
      status: appointment.status,
      creator: appointment.creator,
      clientName: appointment.clientName,
      clientPhone: appointment.clientPhone,
      clientEmail: appointment.clientEmail,
      clientDocID: appointment.clientDocID,
      creationDate: appointment.creationDate,
      date: appointment.date,
      services: List<AppointmentService>.from(appointment.services),
      paymentStatus: appointment.paymentStatus,
    );
  }
  factory Appointment.fromJson(Map<String, dynamic> doc) {
    List<AppointmentService> loadServicesFromDoc(List<dynamic> docServices) {
      List<AppointmentService> services = [];
      for (Map<String, dynamic> s in docServices) {
        services.add(AppointmentService.fromJson(s));
      }
      return services;
    }

    AppointmentCreator loadCreator(String creatorStr) {
      if (creatorStr == 'AppointmentCreator.business') {
        return AppointmentCreator.business;
      }
      return AppointmentCreator.client;
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

    DiscountType loadDiscountType(String? discountType) {
      if (discountType == null) return DiscountType.percent;
      switch (discountType) {
        case 'DiscountType.percent':
          return DiscountType.percent;
        case 'DiscountType.fixed':
          return DiscountType.fixed;
        default:
          return DiscountType.percent;
      }
    }

    return Appointment(
      id: doc["id"],
      status: loadAppointmentStatus(doc["status"]),
      creator: loadCreator(doc['creator']),
      clientName: doc['clientName'],
      clientDocID: doc['clientDocID'],
      clientPhone: doc['clientPhone'],
      clientEmail: doc['clientEmail'],
      creationDate: doc['creationDate'].toDate(),
      notes: doc['notes'],
      clientImagePath: doc['clientImagePath'],
      date: doc['date'].toDate(),
      services: loadServicesFromDoc(doc['services']),
      paymentStatus: loadPaymentStatus(doc['paymentStatus']),
      discount: doc['discount'] ?? 0.0,
      discountType: loadDiscountType(doc['discountType']),
    );
  }
}

/// Clients appointment holds partial details of Appointment,
/// will be saved as part of clients appointments

class ClientAppointment {
  String id; // Appointment ID (if required to fetch from DB)
  DateTime startTime; // Appointment start date and time
  DateTime endTime; // Appointment end date time
  double totalCost; // Appointment total cost
  List<String> services; // List of services names selected in this appointment
  AppointmentStatus status;

  ClientAppointment({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.totalCost,
    required this.services,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startTime': Timestamp.fromDate(startTime),
      'endTime': Timestamp.fromDate(endTime),
      'totalCost': totalCost,
      'services': services,
      'status': status.toString(),
    };
  }

  factory ClientAppointment.fromJson(Map<String, dynamic> doc) {
    List<String> loadServices(List<dynamic> servicesDoc) {
      List<String> services = [];
      for (var service in servicesDoc) {
        services.add(service);
      }
      return services;
    }

    return ClientAppointment(
        id: doc['id'],
        startTime: doc['startTime'].toDate(),
        endTime: doc['endTime'].toDate(),
        totalCost: doc['totalCost'].toDouble() ?? 0.0,
        services: doc['services'] == null ? [] : loadServices(doc['services']),
        status: doc['status'] == null
            ? AppointmentStatus.waiting
            : loadAppointmentStatus(doc['status']));
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
  DateTime? birthday; // Birthday date
  DateTime creationDate; // Client creation date
  DateTime? acceptedDate; // Birthday date
  double? discount; // general discount for client
  bool? isTrusted; // Birthday date
  String imagePath; // Image Path
  Map<String, ClientAppointment> appointments;

  double get totalRevenue {
    return appointments.values
        .fold<double>(0, (sum, item) => sum + item.totalCost);
  }

  int get totalCancelledAppointment {
    int totalCancelledAppointments = 0;
    appointments.forEach((key, value) {
      if (value.status == AppointmentStatus.cancelled) {
        totalCancelledAppointments += 1;
      }
    });
    return totalCancelledAppointments;
  }

  int get totalNoShowAppointment {
    int totalNoShowAppointments = 0;
    appointments.forEach((key, value) {
      if (value.status == AppointmentStatus.noShow) {
        totalNoShowAppointments += 1;
      }
    });
    return totalNoShowAppointments;
  }

  Client({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.address,
    required this.email,
    this.generalNotes,
    this.birthday,
    required this.creationDate,
    this.acceptedDate,
    this.discount,
    this.isTrusted,
    this.imagePath = '',
    this.appointments = const {},
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'phone': phone,
      'address': address,
      'email': email,
      'generalNotes': generalNotes,
      'birthday': birthday != null ? Timestamp.fromDate(birthday!) : '',
      'creationDate': Timestamp.fromDate(creationDate),
      'acceptedDate': Timestamp.fromDate(creationDate),
      'discount': discount,
      'isTrusted': isTrusted,
      'imagePath': imagePath,
      'appointments':
          appointments.map((key, value) => MapEntry(key, value.toJson())),
    };
  }

  factory Client.fromJson(Map<String, dynamic> doc) {
    Map<String, ClientAppointment> loadAppointmentsFromDoc(
        Map<String, dynamic> docAppointments) {
      Map<String, ClientAppointment> appointments = {};
      for (var app in docAppointments.entries) {
        appointments[app.key] = ClientAppointment.fromJson(app.value);
      }
      return appointments;
    }

    return Client(
      id: doc['id'],
      fullName: doc['fullName'],
      phone: doc['phone'],
      address: doc['address'],
      email: doc['email'],
      creationDate: doc['creationDate'].toDate(),
      generalNotes: doc['generalNotes'],
      birthday: doc['birthday'].toString().isNotEmpty
          ? doc['birthday'].toDate()
          : null,
      discount: doc['discount'],
      isTrusted: doc['isTrusted'],
      imagePath: doc['imagePath'],
      appointments: doc['appointments'] == null
          ? {}
          : loadAppointmentsFromDoc(doc['appointments']),
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
