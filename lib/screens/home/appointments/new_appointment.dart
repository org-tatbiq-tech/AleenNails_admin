import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/date.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/accordion/accordion.dart';
import 'package:appointments/widget/accordion/accordion_section.dart';
import 'package:appointments/widget/accordion/controllers.dart';
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
  int _index = 0;
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
    Widget _builderStep() {
      return Container(
        margin: EdgeInsets.only(top: 10),
        child: Stepper(
          steps: [
            Step(
              title: Text("First"),
              content: Text("This is our first example."),
            ),
            Step(
              title: Text("Second"),
              content: Text("This is our second example."),
            ),
            Step(
              title: Text("Third"),
              content: Text("This is our third example."),
            ),
            Step(
              title: Text("Forth"),
              content: Text("This is our forth example."),
            ),
          ],
          currentStep: _index,
          onStepTapped: (index) {
            setState(() {
              _index = index;
            });
          },
          // controlsBuilder: (BuildContext context,
          //         {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) =>
          //     Container(),
        ),
      );
    }

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
        isDisabled: isDisabled,
        leftIcon: leftIcon,
        header: header,
        content: content,
        contentBorderWidth: 0,
        contentHorizontalPadding: 0,
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
                maxOpenSections: 1,
                contentBorderColor: Theme.of(context).colorScheme.primary,
                contentBackgroundColor: lighten(
                    Theme.of(context).colorScheme.primaryContainer, 0.06),
                headerBackgroundColor:
                    Theme.of(context).colorScheme.primaryContainer,
                headerBackgroundColorOpened:
                    Theme.of(context).colorScheme.primaryContainer,
                headerPadding: EdgeInsets.symmetric(
                  vertical: rSize(10),
                  horizontal: rSize(10),
                ),
                sectionOpeningHapticFeedback: SectionHapticFeedback.selection,
                sectionClosingHapticFeedback: SectionHapticFeedback.selection,
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
                    isOpen: false,
                    isDisabled: true,
                  ),
                  _renderAccordionSection(
                    index: 1,
                    header: _renderServicesHeader(),
                    content: _renderServicesBody(),
                    isDisabled: true,
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
