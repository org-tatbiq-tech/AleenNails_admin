import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/date.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/calendar_view/flutter_week_view.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_input_field.dart';
import 'package:appointments/widget/custom_input_field_button.dart';
import 'package:appointments/widget/expandable_calendar.dart';
import 'package:appointments/widget/picker_time_range_modal.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Unavailability extends StatefulWidget {
  const Unavailability({Key? key}) : super(key: key);

  @override
  State<Unavailability> createState() => _UnavailabilityState();
}

class _UnavailabilityState extends State<Unavailability> {
  final TextEditingController _descriptionController = TextEditingController();

  CalendarFormat _calendarFormat = CalendarFormat.week;
  DayViewController dayViewController = DayViewController();
  DateTime? durationValue;
  DateTime _focusedDay = kToday;
  DateTime? _selectedDay = kToday;

  List<CalendarEvent> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _calendarFormat = CalendarFormat.week;
      });

      // _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  void initState() {
    super.initState();
    _descriptionController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  Widget _renderReason() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: rSize(10),
            right: rSize(10),
            bottom: rSize(5),
          ),
          child: Text(
            'Reason',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        SizedBox(
          height: rSize(120),
          child: CustomInputField(
            customInputFieldProps: CustomInputFieldProps(
              controller: _descriptionController,
              hintText: 'Short description of your reason (recommended)',
              isDescription: true,
              keyboardType: TextInputType.multiline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _renderTimePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: rSize(5),
                  left: rSize(10),
                  right: rSize(10),
                ),
                child: Text(
                  'Start',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              CustomInputFieldButton(
                text: getDateTimeFormat(
                  dateTime: durationValue,
                  format: 'HH:mm',
                ),
                onTap: () => showPickerTimeRangeModal(
                  pickerTimeRangeModalProps: PickerTimeRangeModalProps(
                    context: context,
                    title: 'Start Time',
                    startTimeValue: durationValue,
                    pickerTimeRangType: PickerTimeRangType.single,
                    primaryAction: (DateTime x) => setState(() {
                      durationValue = x;
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: rSize(20),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: rSize(5),
                  left: rSize(10),
                  right: rSize(10),
                ),
                child: Text('End',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText2),
              ),
              CustomInputFieldButton(
                text: getDateTimeFormat(
                  dateTime: durationValue,
                  format: 'HH:mm',
                ),
                onTap: () => showPickerTimeRangeModal(
                  pickerTimeRangeModalProps: PickerTimeRangeModalProps(
                    context: context,
                    title: 'End Time',
                    startTimeValue: durationValue,
                    pickerTimeRangType: PickerTimeRangType.single,
                    primaryAction: (DateTime x) => setState(() {
                      durationValue = x;
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          customAppBarProps: CustomAppBarProps(
            titleText: 'Unavailability',
            withBack: true,
            withBorder: true,
            saveTap: () => {},
            withSave: true,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ExpandableCalendar(
                expandableCalendarProps: ExpandableCalendarProps(
                  focusedDay: _focusedDay,
                  selectedDay: _selectedDay,
                  calendarFormat: _calendarFormat,
                  formatButtonVisible: true,
                  firstDay: kToday,
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
                  // availableCalendarFormats: {},
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: rSize(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: rSize(30),
                    ),
                    _renderTimePicker(),
                    SizedBox(
                      height: rSize(40),
                    ),
                    _renderReason(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
