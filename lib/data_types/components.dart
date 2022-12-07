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
  Map<String, String>?
      imagesURL; // Map of firebase storage image path to image URL

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
    imagesURL = {};
    if (images != null) {
      for (MapEntry imageEntry in images.entries) {
        imagesURL![imageEntry.key] = imageEntry.value;
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
      'images': imagesURL,
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
  AppointmentCreator
      lastEditor; // Appointment last editor (which admin/worker/...)
  String clientName; // Client full name
  String clientPhone; // Client phone number
  String clientEmail; // Client Email
  String clientImageURL; // Client Image Url
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
    required this.lastEditor,
    required this.clientName,
    required this.clientPhone,
    required this.clientEmail,
    required this.clientDocID,
    required this.creationDate,
    required this.date,
    this.notes = '',
    this.clientImageURL = '',
    this.discount = 0,
    this.discountType = DiscountType.percent,
    required this.services,
    required this.paymentStatus,
  });

  double get totalCost {
    double cost = services.fold<double>(0, (sum, item) => sum + item.cost);
    if (discount == 0) {
      return cost;
    }

    if (discountType == DiscountType.percent) {
      return cost * (100 - discount) / 100;
    }
    return cost - discount;
  }

  double get servicesCost {
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
      // last editor is now the business
      'lastEditor': AppointmentCreator.business.toString(),
      'clientName': clientName,
      'clientDocID': clientDocID,
      'clientPhone': clientPhone,
      'clientEmail': clientEmail,
      'creationDate': Timestamp.fromDate(creationDate),
      'date': Timestamp.fromDate(date),
      'notes': notes,
      'clientImageURL': clientImageURL,
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
      lastEditor: appointment.lastEditor,
      clientName: appointment.clientName,
      clientPhone: appointment.clientPhone,
      clientEmail: appointment.clientEmail,
      clientDocID: appointment.clientDocID,
      creationDate: appointment.creationDate,
      notes: appointment.notes,
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
      lastEditor: doc['lastEditor'] != null
          ? loadCreator(doc['lastEditor'])
          : AppointmentCreator.business,
      clientName: doc['clientName'],
      clientDocID: doc['clientDocID'],
      clientPhone: doc['clientPhone'],
      clientEmail: doc['clientEmail'],
      creationDate: doc['creationDate'].toDate(),
      notes: doc['notes'],
      clientImageURL: doc['clientImageURL'] ?? "",
      date: doc['date'].toDate(),
      services: loadServicesFromDoc(doc['services']),
      paymentStatus: loadPaymentStatus(doc['paymentStatus']),
      discount: doc['discount'] ?? 0,
      discountType: loadDiscountType(doc['discountType']),
    );
  }
}

/// Clients appointment holds partial details of Appointment,
/// will be saved as part of clients appointments

class ClientAppointment {
  String id;
  String appointmentIdRef; // Appointment ID (if required to fetch from DB)v
  DateTime startTime; // Appointment start date and time
  DateTime endTime; // Appointment end date time
  double totalCost; // Appointment total cost
  List<String> services; // List of services names selected in this appointment
  AppointmentStatus status;

  ClientAppointment({
    required this.id,
    required this.appointmentIdRef,
    required this.startTime,
    required this.endTime,
    required this.totalCost,
    required this.services,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'appointmentIdRef': appointmentIdRef,
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
        appointmentIdRef: doc['appointmentIdRef'],
        startTime: doc['startTime'].toDate(),
        endTime: doc['endTime'].toDate(),
        totalCost: doc['totalCost'].toDouble() ?? 0.0,
        services: doc['services'] == null ? [] : loadServices(doc['services']),
        status: doc['status'] == null
            ? AppointmentStatus.waiting
            : loadAppointmentStatus(doc['status']));
  }

  factory ClientAppointment.fromAppointment(Appointment appointment) {
    List<String> loadServices(List<AppointmentService> appointmentServices) {
      List<String> services = [];
      for (AppointmentService service in appointmentServices) {
        services.add(service.name);
      }
      return services;
    }

    return ClientAppointment(
      id: '',
      appointmentIdRef: appointment.id,
      startTime: appointment.date,
      endTime: appointment.endTime,
      totalCost: appointment.totalCost,
      services: loadServices(appointment.services),
      status: appointment.status,
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
  DateTime? birthday; // Birthday date
  DateTime creationDate; // Client creation date
  DateTime? acceptedDate; // Birthday date
  double? discount; // general discount for client
  bool? isTrusted; // Trusted user
  String imageURL; // Image URL for quick download
  List<ClientAppointment> appointments;
  bool? isApprovedByAdmin; // Admin approved this account

  double get totalRevenue {
    return appointments.fold<double>(0, (sum, item) => sum + item.totalCost);
  }

  int get totalCancelledAppointment {
    int totalCancelledAppointments = 0;
    for (var app in appointments) {
      if (app.status == AppointmentStatus.cancelled) {
        totalCancelledAppointments += 1;
      }
    }
    return totalCancelledAppointments;
  }

  int get totalNoShowAppointment {
    int totalNoShowAppointments = 0;
    for (var app in appointments) {
      if (app.status == AppointmentStatus.noShow) {
        totalNoShowAppointments += 1;
      }
    }
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
    this.imageURL = '',
    this.appointments = const [],
    this.isApprovedByAdmin,
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
      'imageURL': imageURL,
      'isApprovedByAdmin': isApprovedByAdmin,
    };
  }

  factory Client.fromJson(Map<String, dynamic> doc) {
    List<ClientAppointment> loadAppointmentsFromDoc(List clientAppointments) {
      List<ClientAppointment> appointments = [];
      for (var app in clientAppointments) {
        appointments.add(app);
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
      generalNotes: doc['generalNotes'] ?? "",
      birthday: doc['birthday'].toString().isNotEmpty
          ? doc['birthday'].toDate()
          : null,
      discount: doc['discount'],
      isTrusted: doc['isTrusted'] ?? true,
      imageURL: doc['imageURL'] ?? '',
      appointments: doc['appointments'] == null
          ? []
          : loadAppointmentsFromDoc(doc['appointments']),
      isApprovedByAdmin: doc['isApprovedByAdmin'],
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
  NotificationCategory notificationCategory;

  NotificationData({
    required this.id,
    required this.description,
    required this.creationDate,
    required this.notificationCategory,
  });
}
