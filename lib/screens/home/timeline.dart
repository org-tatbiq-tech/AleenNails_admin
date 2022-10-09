import 'package:appointments/data_types/components.dart';
import 'package:appointments/providers/appointments_mgr.dart';
import 'package:appointments/screens/home/appointments/appointment_details.dart';
import 'package:appointments/widget/appointment_card.dart';
import 'package:appointments/widget/custom_day_view.dart';
import 'package:appointments/widget/custom_expandable_calendar.dart';
import 'package:appointments/widget/custom_text_button.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_loading-indicator.dart';
import 'package:common_widgets/ease_in_animation.dart';
import 'package:common_widgets/empty_list_image.dart';
import 'package:common_widgets/utils/input_validation.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
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
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  List<Appointment> appointments = [];
  bool _isListView = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _isLoading = true;
        _calendarFormat = CalendarFormat.week;
        final appointmentsMgr =
            Provider.of<AppointmentsMgr>(context, listen: false);
        appointmentsMgr
            .setSelectedDay(
              DateTime(
                _selectedDay.year,
                _selectedDay.month,
                _selectedDay.day,
              ),
            )
            .then(
              (value) => _isLoading = false,
            );
      });
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
          style: Theme.of(context).textTheme.headline1?.copyWith(
                color: darken(
                  event.backgroundColor ??
                      Theme.of(context).colorScheme.primary,
                  0.2,
                ),
              ),
        ),
        Expanded(
          child: Text(
            event.description,
            maxLines: maxLines != 0 ? maxLines : 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  color: darken(
                    event.backgroundColor ??
                        Theme.of(context).colorScheme.primary,
                    0.2,
                  ),
                ),
          ),
        ),
      ],
    );
  }

  renderFlutterWeekViewEvent({
    required String title,
    String? description,
    required Color backgroundColor,
    required DateTime start,
    required DateTime end,
    VoidCallback? onTap,
  }) {
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
        color: lighten(backgroundColor, 0.2),
      ),
      start: start,
      end: end,
      onTap: onTap,
    );
  }

  List<Appointment> getAppointments(DateTime date) {
    final appointmentsMgr =
        Provider.of<AppointmentsMgr>(context, listen: false);
    return appointmentsMgr.appointments;
  }

  navigateToAppointmentDetails(Appointment appointment) {
    final appointmentsMgr =
        Provider.of<AppointmentsMgr>(context, listen: false);
    appointmentsMgr.setSelectedAppointment(appointment: appointment);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppointmentDetails(),
      ),
    );
  }

  String getAppointmentDescription(Appointment appointment) {
    String description = '';
    if (appointment.clientPhone.isNotEmpty) {
      description += appointment.clientPhone;
    }
    if (appointment.services.isNotEmpty) {
      description += '\nServices ➙ ${appointment.services.length}';
    }
    if (appointment.notes.isNotEmpty) {
      description += '\nNotes ➙ ${appointment.notes}';
    }
    description += '\nPrice ➙ ${getStringPrice(appointment.totalCost)}';
    description += '\nDuration ➙ ${appointment.totalDurationInMins}min';
    description += '\nStatus ➙ ${appointment.status.name.toUpperCase()}';

    return description;
  }

  List<FlutterWeekViewEvent> getFlutterWeekAppointments(DateTime date) {
    final appointmentsMgr =
        Provider.of<AppointmentsMgr>(context, listen: false);
    List<FlutterWeekViewEvent> events = [];
    for (Appointment appointment in appointmentsMgr.appointments) {
      events.add(
        renderFlutterWeekViewEvent(
          title: appointment.clientName,
          description: getAppointmentDescription(appointment),
          start: date.add(
            Duration(
                hours: appointment.date.hour, minutes: appointment.date.minute),
          ),
          end: date.add(
            Duration(
                hours: appointment.endTime.hour,
                minutes: appointment.endTime.minute),
          ),
          backgroundColor: Color(appointment.services[0].colorID),
          onTap: () => navigateToAppointmentDetails(appointment),
        ),
      );
    }
    return events;
  }

  Widget renderTodayButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: rSize(10),
        vertical: rSize(30),
      ),
      child: Align(
          alignment: Alignment.bottomRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EaseInAnimation(
                onTap: () => {
                  _onDaySelected(
                    DateTime.now(),
                    _focusedDay,
                  )
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: rSize(10),
                    vertical: rSize(10),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(rSize(10)),
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.4),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.arrowUp,
                        size: rSize(18),
                        color: darken(
                          Theme.of(context).colorScheme.primary,
                          0.2,
                        ),
                      ),
                      SizedBox(
                        width: rSize(5),
                      ),
                      Text(
                        'Today',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget getCustomIcon() {
    if (_isListView) {
      return Icon(
        Icons.list,
        size: rSize(26),
      );
    }
    return Icon(
      Icons.calendar_today,
      size: rSize(24),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          withBorder: true,
          withClipPath: false,
          titleText: 'Home',
          customIcon: getCustomIcon(),
          customIconTap: () => setState(() {
            _isListView = !_isListView;
          }),
        ),
      ),
      body: Consumer<AppointmentsMgr>(
        builder: (context, appointmentsMgr, _) => Stack(
          children: [
            Column(
              children: [
                CustomExpandableCalendar(
                  customExpandableCalendarProps: CustomExpandableCalendarProps(
                    focusedDay: _focusedDay,
                    selectedDay: _selectedDay,
                    calendarFormat: _calendarFormat,
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
                  child: _isLoading
                      ? Center(
                          child: CustomLoadingIndicator(
                            customLoadingIndicatorProps:
                                CustomLoadingIndicatorProps(),
                          ),
                        )
                      : AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: !_isListView
                              ? CustomDayView(
                                  customDayViewProps: CustomDayViewProps(
                                    dayViewController: dayViewController,
                                    minimumTime: const HourMinute(hour: 6),
                                    date: _selectedDay,
                                    userZoomAble: false,
                                    events: getFlutterWeekAppointments(
                                        _selectedDay),
                                    initialTime: HourMinute(
                                      hour: DateTime.now().hour,
                                      minute: DateTime.now().minute,
                                    ),
                                  ),
                                )
                              : Visibility(
                                  visible:
                                      getAppointments(_selectedDay).isNotEmpty,
                                  replacement: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      EmptyListImage(
                                        emptyListImageProps:
                                            EmptyListImageProps(
                                          title: 'No appointment on this day.',
                                          iconPath: 'assets/icons/menu.png',
                                          bottomWidgetPosition: 10,
                                          bottomWidget: CustomTextButton(
                                            customTextButtonProps:
                                                CustomTextButtonProps(
                                              onTap: () => {
                                                Navigator.of(context).pushNamed(
                                                    '/newAppointment'),
                                              },
                                              text: 'Add New Appointment',
                                              textColor: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              withIcon: true,
                                              icon: Icon(
                                                FontAwesomeIcons.plus,
                                                size: rSize(16),
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: ListView.separated(
                                    padding: EdgeInsets.only(
                                      top: rSize(20),
                                      left: rSize(20),
                                      right: rSize(20),
                                    ),
                                    itemCount:
                                        getAppointments(_selectedDay).length,
                                    itemBuilder: (context, index) {
                                      return AppointmentCard(
                                        appointmentCardProps:
                                            AppointmentCardProps(
                                          appointmentDetails: getAppointments(
                                              _selectedDay)[index],
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(
                                        height: rSize(10),
                                      );
                                    },
                                  ),
                                ),
                        ),
                ),
              ],
            ),
            !isSameDay(_selectedDay, DateTime.now())
                ? renderTodayButton()
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
