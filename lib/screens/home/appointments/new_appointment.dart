import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/date.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/contact_card.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_text_button.dart';
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
  Contact? selectedContact = Contact('name', 'phone', 'address');
  DateTime? _selectedDay;
  List<String> slots = [
    '11:00',
    '12:00',
    '13:00',
    '14:30',
    '15:00',
    '16:00',
    '17:00',
    '18:00'
  ];
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

  Widget _renderSlot(BuildContext context, item) {
    return SizedBox(
      width: rSize(80),
      child: Card(
        // margin: EdgeInsets.fromLTRB(0, 0, 0, rSize(20)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            rSize(15),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              item,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _renderClient() {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Client',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontSize: rSize(18),
                    ),
              ),
              CustomTextButton(
                  customTextButtonProps: CustomTextButtonProps(
                      onTap: () => {},
                      textStyle:
                          Theme.of(context).textTheme.bodyText2?.copyWith(
                                fontSize: rSize(18),
                                color: Theme.of(context).colorScheme.primary,
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.solid,
                                decorationThickness: rSize(10),
                              ),
                      text: selectedContact != null
                          ? 'Change Contact'
                          : 'Select Contact'))
            ],
          ),
          SizedBox(
            height: rSize(20),
          ),
          selectedContact != null
              ? ContactCard(
                  contactCardProps: ContactCardProps(
                    withNavigation: false,
                    contactDetails: selectedContact!,
                  ),
                )
              : Center(
                  child: Text(
                    'No Contact Selected',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
        ],
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText: 'New Appointment',
          withBack: true,
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
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: rSize(20),
              vertical: rSize(30),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _renderClient(),
                SizedBox(
                  height: rSize(20),
                ),
                SizedBox(
                  height: rSize(50),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    // padding: EdgeInsets.only(
                    //   top: rSize(20),
                    //   left: rSize(20),
                    //   right: rSize(20),
                    // ),
                    itemCount: slots.length,
                    itemBuilder: (context, index) {
                      return _renderSlot(context, slots[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
