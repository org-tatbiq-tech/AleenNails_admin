import 'package:appointments/data_types/components.dart';
import 'package:appointments/data_types/macros.dart';
import 'package:appointments/widget/appointment_card.dart';
import 'package:appointments/widget/custom_day_view.dart';
import 'package:appointments/widget/custom_expandable_calendar.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:table_calendar/table_calendar.dart';

//class needs to extend StatefulWidget since we need to make changes to the bottom app bar according to the user clicks
class TimeLine extends StatefulWidget {
  const TimeLine({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TimeLineState();
  }
}

class TimeLineState extends State<TimeLine> {
  DayViewController dayViewController = DayViewController();
  late final ValueNotifier<List<FlutterWeekViewEvent>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay;
  List<Appointment> appointments = [];
  bool isListView = false;

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

  List<FlutterWeekViewEvent> _getEventsForDay(DateTime day) {
    return getFlutterWeekAppointments(day);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _calendarFormat = CalendarFormat.week;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  Widget eventTextBuilder(
    FlutterWeekViewEvent event,
    BuildContext context,
    DayView dayView,
    double height,
    double width,
  ) {
    // the height of each row in the description
    double fontSize =
        Theme.of(context).textTheme.subtitle1?.fontSize ?? rSize(16);
    double fontHeight = Theme.of(context).textTheme.subtitle1?.height ?? 1.4;

    // This is the height of the title
    double fontHeight2 = Theme.of(context).textTheme.headline1?.height ?? 1.4;
    double fontSize2 =
        Theme.of(context).textTheme.headline1?.fontSize ?? rSize(22);

    // here will calculate the max available max line in the event
    int maxLines =
        (height - (fontHeight2 * fontSize2)) ~/ (fontHeight * fontSize);

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          event.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .headline1
              ?.copyWith(color: event.backgroundColor),
        ),
        Expanded(
          child: Text(event.description,
              maxLines: maxLines != 0 ? maxLines : 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: event.backgroundColor)),
        ),
      ],
    );
  }

  renderFlutterWeekViewEvent({
    required String title,
    String? description,
    Color? backgroundColor,
    required DateTime start,
    required DateTime end,
    VoidCallback? onTap,
  }) {
    backgroundColor = backgroundColor ?? Colors.red;
    return FlutterWeekViewEvent(
      eventTextBuilder: eventTextBuilder,
      padding: EdgeInsets.symmetric(
        horizontal: rSize(20),
        vertical: rSize(10),
      ),
      title: title,
      description: description ?? '',
      backgroundColor: backgroundColor,
      margin: EdgeInsets.symmetric(
        horizontal: rSize(6),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          rSize(10),
        ),
        color: lighten(backgroundColor, 0.3),
      ),
      start: start,
      end: end,
      onTap: onTap,
    );
  }

  List<FlutterWeekViewEvent> getFlutterWeekAppointments(DateTime date) {
    List<FlutterWeekViewEvent> appointments = [
      renderFlutterWeekViewEvent(
        title: 'Course 1',
        description:
            'A description 3 dsadjkhasd adasjd hnasd adasd alskdjask djsakldjsalkdjasldjkslajdlasjdaskjdklasjdalskdja dsakjdlajdlkasjlkds jlasdkjlkasjlkdjadklajldkasjdklsajlkkdjakldjlks',
        start: date.add(Duration(hours: 19)),
        end: date.add(Duration(hours: 22)),
        onTap: () => Navigator.pushNamed(context, '/appointmentDetails'),
      ),
      renderFlutterWeekViewEvent(
        title: 'Course 2',
        description:
            'A description 3 dsadjkhasd adasjd hnasd adasd alskdjask djsakldjsalkdjasldjkslajdlasjdaskjdklasjdalskdja dsakjdlajdlkasjlkds jlasdkjlkasjlkdjadklajldkasjdklsajlkkdjakldjlks',
        start: date.add(Duration(hours: 23, minutes: 30)),
        end: date.add(Duration(hours: 24)),
        onTap: () => Navigator.pushNamed(context, '/appointmentDetails'),
      ),
      renderFlutterWeekViewEvent(
        title: 'Course 3',
        description:
            'A description 3 dsadjkhasd adasjd hnasd adasd alskdjask djsakldjsalkdjasldjkslajdlasjdaskjdklasjdalskdja dsakjdlajdlkasjlkds jlasdkjlkasjlkdjadklajldkasjdklsajlkkdjakldjlks',
        start: date.add(Duration(hours: 17)),
        end: date.add(Duration(hours: 18, minutes: 30)),
        onTap: () => Navigator.pushNamed(context, '/appointmentDetails'),
      ),
      renderFlutterWeekViewEvent(
        title: 'An event 5',
        description:
            'A description 3 dsadjkhasd adasjd hnasd adasd alskdjask djsakldjsalkdjasldjkslajdlasjdaskjdklasjdalskdja dsakjdlajdlkasjlkds jlasdkjlkasjlkdjadklajldkasjdklsajlkkdjakldjlks',
        start: date.add(Duration(hours: 20)),
        end: date.add(Duration(hours: 21)),
        onTap: () => Navigator.pushNamed(context, '/appointmentDetails'),
      ),
    ];

    return appointments.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomExpandableCalendar(
          customExpandableCalendarProps: CustomExpandableCalendarProps(
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
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: !isListView
                ? CustomDayView(
                    customDayViewProps: CustomDayViewProps(
                      dayViewController: dayViewController,
                      minimumTime: const HourMinute(hour: 6),
                      date: _selectedDay,
                      userZoomAble: false,
                      events: getFlutterWeekAppointments(_selectedDay),
                      initialTime: HourMinute(
                        hour: DateTime.now().hour,
                        minute: DateTime.now().minute,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.only(
                      top: rSize(20),
                      left: rSize(20),
                      right: rSize(20),
                    ),
                    itemCount: appointments.length,
                    itemBuilder: (context, index) {
                      return AppointmentCard(
                        appointmentCardProps: AppointmentCardProps(
                          appointmentDetails: appointments[index],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: rSize(10),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
