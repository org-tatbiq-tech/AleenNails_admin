class CalendarEvent {
  final String title;
  const CalendarEvent(this.title);
  @override
  String toString() => title;
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

enum Status {
  confirmed,
  declined,
  cancelled,
  waiting,
}
