import 'package:appointments/data_types/macros.dart';
import 'package:appointments/screens/home/schedule_management/day_break.dart';
import 'package:appointments/widget/custom_text_button.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_input_field_button.dart';
import 'package:common_widgets/picker_date_time_modal.dart';
import 'package:common_widgets/utils/date.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DayDetails extends StatefulWidget {
  final WorkingDay workingDay;
  const DayDetails({
    Key? key,
    required this.workingDay,
  }) : super(key: key);

  @override
  State<DayDetails> createState() => _DayDetailsState();
}

class _DayDetailsState extends State<DayDetails> {
  DateTime? durationValue;
  late DateTime startTime;
  late DateTime startTimeTemp;
  late DateTime endTime;
  late DateTime endTimeTemp;
  late DateTime endTimeMin;

  @override
  void initState() {
    super.initState();
    setState(() {
      DateTime today = DateTime.now();
      startTime = widget.workingDay.startTime == null
          ? DateTime(today.year, today.month, today.day, 8, 0)
          : DateTime(
              today.year,
              today.month,
              today.day,
              widget.workingDay.startTime!.hour,
              widget.workingDay.startTime!.minute,
            );
      startTimeTemp = DateTime(today.year, today.month, today.day, 8, 0);
      endTime = widget.workingDay.endTime == null
          ? DateTime(today.year, today.month, today.day, 18, 0)
          : DateTime(
              today.year,
              today.month,
              today.day,
              widget.workingDay.endTime!.hour,
              widget.workingDay.endTime!.minute,
            );
      endTimeTemp = DateTime(today.year, today.month, today.day, 18, 0);
      endTimeMin = startTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    addBreak() async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DayBreak(
            breakStartTime: startTime,
            breakEndTime: endTime,
            dayTile: widget.workingDay.day,
          ),
        ),
      );
      if (result != null) {
        widget.workingDay.breaks ??= [];
        widget.workingDay.breaks!.add(result);
      }
    }

    Widget renderSwitch() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Working on this day?',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ),
          SizedBox(
            width: rSize(20),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: rSize(70),
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Switch(
                    activeColor: Theme.of(context).colorScheme.primary,
                    splashRadius: 0,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    inactiveTrackColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    inactiveThumbColor:
                        Theme.of(context).colorScheme.background,
                    value: widget.workingDay.isDayOn,
                    onChanged: (bool state) {
                      setState(() {
                        widget.workingDay.isDayOn = state;
                        widget.workingDay.startTime = TimeOfDay(
                          hour: startTime.hour,
                          minute: startTime.minute,
                        );
                        widget.workingDay.endTime = TimeOfDay(
                          hour: endTime.hour,
                          minute: endTime.minute,
                        );
                      });
                    },
                  ),
                ),
              ),
              Text(
                widget.workingDay.isDayOn ? 'Open' : 'Closed',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontSize: rSize(12),
                    ),
              ),
            ],
          ),
        ],
      );
    }

    Widget renderBreaks() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Breaks',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(
            height: rSize(20),
          ),
          CustomTextButton(
            customTextButtonProps: CustomTextButtonProps(
              text: 'Add Break',
              textColor: Theme.of(context).colorScheme.primary,
              fontSize: rSize(16),
              withIcon: true,
              icon: Icon(
                FontAwesomeIcons.plus,
                size: rSize(16),
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: () => {
                addBreak(),
              },
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
                    dateTime: startTime,
                    format: 'HH:mm',
                  ),
                  onTap: () => showPickerDateTimeModal(
                    pickerDateTimeModalProps: PickerDateTimeModalProps(
                      mode: CupertinoDatePickerMode.time,
                      context: context,
                      initialDateTime: startTime,
                      title: 'Start Time',
                      onDateTimeChanged: (DateTime value) => {
                        setState(() {
                          startTimeTemp = value;
                        }),
                      },
                      primaryAction: () => {
                        setState(() {
                          startTime = startTimeTemp;
                          endTimeMin = startTimeTemp;
                          widget.workingDay.startTime = TimeOfDay(
                            hour: startTime.hour,
                            minute: startTime.minute,
                          );
                          if (startTime.isAfter(endTime)) {
                            endTime = startTimeTemp;
                            widget.workingDay.endTime = TimeOfDay(
                              hour: endTime.hour,
                              minute: endTime.minute,
                            );
                          }
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
                  child: Text(
                    'End',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
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
                      minimumDate: endTimeMin,
                      initialDateTime: endTime,
                      title: 'End Time',
                      onDateTimeChanged: (DateTime value) => {
                        setState(() {
                          endTimeTemp = value;
                        }),
                      },
                      primaryAction: () => {
                        setState(() {
                          endTime = endTimeTemp;
                          widget.workingDay.endTime = TimeOfDay(
                            hour: endTime.hour,
                            minute: endTime.minute,
                          );
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

    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText: widget.workingDay.day,
          withBack: true,
          barHeight: 110,
          withClipPath: true,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        top: false,
        right: false,
        left: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: rSize(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              renderSwitch(),
              SizedBox(
                height: rSize(20),
              ),
              Text(
                'Set your business hours here. Head to Opening Calendar from Settings menu if you need to adjust hours for single day',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontSize: rSize(14),
                    ),
              ),
              Expanded(
                child: AnimatedSwitcher(
                  reverseDuration: const Duration(milliseconds: 400),
                  duration: const Duration(milliseconds: 400),
                  child: widget.workingDay.isDayOn
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: rSize(40),
                            ),
                            renderTimePicker(),
                            SizedBox(
                              height: rSize(40),
                            ),
                            renderBreaks(),
                          ],
                        )
                      : const SizedBox(),
                ),
              ),
              CustomButton(
                customButtonProps: CustomButtonProps(
                  text: 'OK',
                  onTap: (() => Navigator.pop(context)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
