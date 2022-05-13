import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/date.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/calendar_view/flutter_week_view.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_input_field.dart';
import 'package:appointments/widget/custom_input_field_button.dart';
import 'package:appointments/widget/picker_date_time_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Unavailability extends StatefulWidget {
  const Unavailability({Key? key}) : super(key: key);

  @override
  State<Unavailability> createState() => _UnavailabilityState();
}

class _UnavailabilityState extends State<Unavailability> {
  final TextEditingController _descriptionController = TextEditingController();

  DayViewController dayViewController = DayViewController();
  DateTime? startDateTime;
  DateTime? startDateTimeTemp;

  DateTime? endTime;
  DateTime? endTimeTemp;
  DateTime? endTimeMin;

  DateTime? _selectedDay = kToday;

  void onDaySelected(DateTime selectedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
      });
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

  Widget renderTimePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 2,
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
                  'Start Date & Time',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              CustomInputFieldButton(
                text: getDateTimeFormat(
                  dateTime: startDateTime,
                  format: 'dd MMM yyyy • HH:mm',
                ),
                onTap: () => showPickerDateTimeModal(
                  pickerDateTimeModalProps: PickerDateTimeModalProps(
                    context: context,
                    minimumDate: DateTime.now(),
                    initialDateTime: startDateTime,
                    title: 'Start Date & Time',
                    onDateTimeChanged: (DateTime value) => {
                      setState(() {
                        startDateTimeTemp = value;
                      }),
                    },
                    primaryAction: () => {
                      setState(() {
                        startDateTime = startDateTimeTemp;
                        endTimeMin = startDateTimeTemp;
                      }),
                    },
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
                  dateTime: endTime,
                  format: 'HH:mm',
                ),
                onTap: () => showPickerDateTimeModal(
                  pickerDateTimeModalProps: PickerDateTimeModalProps(
                    mode: CupertinoDatePickerMode.time,
                    context: context,
                    initialDateTime: endTime ?? endTimeMin,
                    minimumDate: endTimeMin,
                    title: 'End Time',
                    onDateTimeChanged: (DateTime value) => {
                      setState(() {
                        endTimeTemp = value;
                      }),
                    },
                    primaryAction: () => {
                      setState(() {
                        endTime = endTimeTemp;
                      }),
                    },
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
            withBorder: false,
            barHeight: 110,
            withClipPath: true,
            withSave: true,
            saveTap: () => {},
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: rSize(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: rSize(30),
                    ),
                    renderTimePicker(),
                    SizedBox(
                      height: rSize(30),
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
