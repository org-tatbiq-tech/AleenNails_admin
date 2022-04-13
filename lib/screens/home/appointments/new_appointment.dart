import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/date.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/accrodion/accordion.dart';
import 'package:appointments/widget/accrodion/accordion_section.dart';
import 'package:appointments/widget/accrodion/controllers.dart';
import 'package:appointments/widget/contact_card.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/expandable_calendar.dart';
import 'package:appointments/widget/slot_card.dart';
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
  Contact? selectedContact;
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

  @override
  Widget build(BuildContext context) {
    _renderAccordionSection({
      required Widget header,
      required Widget content,
      Widget? leftIcon,
      int index = 0,
      bool isDisabled = false,
      bool isOpen = false,
    }) {
      return AccordionSection(
        index: index,
        isOpen: isOpen,
        leftIcon: leftIcon,
        header: header,
        content: content,
        isDisabled: isDisabled,
      );
    }

    _renderSlotsHeader() {
      return Text(
        'Available Slots'.toUpperCase(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.headline1?.copyWith(
              fontSize: rSize(18),
              color: Theme.of(context).colorScheme.primary,
            ),
      );
    }

    _renderSlotsBody(List<String> item) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: rSize(60),
        ),
        child: Center(
          child: SizedBox(
            height: rSize(50),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                horizontal: rSize(10),
              ),
              itemCount: slots.length,
              itemBuilder: (context, index) {
                return SlotCard(
                  item: slots[index],
                );
              },
            ),
          ),
        ),
      );
    }

    _renderServicesHeader() {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'choose your services'.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  fontSize: rSize(18),
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          // EaseInAnimation(
          //   onTap: () => {},
          //   child: IconTheme(
          //     data: Theme.of(context).primaryIconTheme,
          //     child: Icon(
          //       FontAwesomeIcons.plus,
          //       size: rSize(20),
          //     ),
          //   ),
          // ),
        ],
      );
    }

    _renderServicesBody() {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: rSize(100),
        ),
        child: selectedContact != null
            ? ContactCard(
                contactCardProps: ContactCardProps(
                  withNavigation: false,
                  contactDetails: selectedContact!,
                ),
              )
            : Center(
                child: Text(
                  'No Services Selected',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
      );
    }

    _renderClientHeader() {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Choose your client'.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  fontSize: rSize(18),
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          // EaseInAnimation(
          //   onTap: () => {},
          //   child: IconTheme(
          //     data: Theme.of(context).primaryIconTheme,
          //     child: Icon(
          //       selectedContact != null
          //           ? FontAwesomeIcons.userPen
          //           : FontAwesomeIcons.userPlus,
          //       size: rSize(20),
          //     ),
          //   ),
          // ),
        ],
      );
    }

    _renderClientBody() {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: rSize(100),
        ),
        child: selectedContact != null
            ? ContactCard(
                contactCardProps: ContactCardProps(
                  withNavigation: false,
                  contactDetails: selectedContact!,
                ),
              )
            : Center(
                child: Text(
                  'No Client Selected',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
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
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: rSize(15), vertical: rSize(20)),
              child: Accordion(
                contentBorderWidth: 0,
                maxOpenSections: 1,
                contentBorderColor: Theme.of(context).colorScheme.primary,
                contentBackgroundColor:
                    Theme.of(context).colorScheme.background,
                headerBackgroundColor:
                    Theme.of(context).colorScheme.onBackground,
                headerBackgroundColorOpened:
                    Theme.of(context).colorScheme.onBackground,
                contentHorizontalPadding: rSize(0),
                headerPadding: EdgeInsets.symmetric(
                  vertical: rSize(10),
                  horizontal: rSize(10),
                ),
                sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                sectionClosingHapticFeedback: SectionHapticFeedback.light,
                rightIcon: IconTheme(
                  data: Theme.of(context).primaryIconTheme,
                  child: Icon(
                    FontAwesomeIcons.chevronDown,
                    size: rSize(16),
                  ),
                ),
                children: [
                  _renderAccordionSection(
                    index: 0,
                    header: _renderClientHeader(),
                    content: _renderClientBody(),
                    leftIcon: IconTheme(
                      data: Theme.of(context).primaryIconTheme,
                      child: Icon(
                        Icons.person,
                        size: rSize(26),
                      ),
                    ),
                    isDisabled: false,
                    isOpen: false,
                  ),
                  _renderAccordionSection(
                    index: 1,
                    header: _renderServicesHeader(),
                    content: _renderServicesBody(),
                    isDisabled: false,
                    isOpen: false,
                  ),
                  _renderAccordionSection(
                    index: 2,
                    header: _renderSlotsHeader(),
                    content: _renderSlotsBody(slots),
                    isDisabled: false,
                    isOpen: true,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
