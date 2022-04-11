import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/date.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/expandable_calendar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

class NewAppointment extends StatefulWidget {
  const NewAppointment({Key? key}) : super(key: key);

  @override
  State<NewAppointment> createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  late final ValueNotifier<List<CalendarEvent>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = kToday;
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<CalendarEvent> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText: 'New Appointment',
          withBack: true,
          // withSearch: true,
          // barHeight: 90,
          withClipPath: false,
          customIcon: Icon(
            FontAwesomeIcons.calendarPlus,
            size: rSize(22),
          ),
          customIconTap: () => {},
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          ExpandableCalendar(
            expandableCalendarProps: ExpandableCalendarProps(
              focusedDay: _focusedDay,
              selectedDay: _selectedDay,
              calendarFormat: _calendarFormat,
              eventLoader: _getEventsForDay,
              onDaySelected: _onDaySelected,
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
            ),
          ),
          Expanded(child: Container())
        ],
      ),
    );
  }
}
