import 'package:appointments/data_types/macros.dart';
import 'package:appointments/localization/language/languages.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:common_widgets/custom_input_field_button.dart';
import 'package:common_widgets/picker_date_time_modal.dart';
import 'package:common_widgets/utils/date.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DayBreak extends StatefulWidget {
  final String dayTile;
  final DateTime breakStartTime;
  final DateTime breakEndTime;
  const DayBreak({
    Key? key,
    this.dayTile = '',
    required this.breakStartTime,
    required this.breakEndTime,
  }) : super(key: key);

  @override
  State<DayBreak> createState() => _DayBreakState();
}

class _DayBreakState extends State<DayBreak> {
  late DateTime startTime;
  late DateTime startTimeTemp;
  late DateTime endTime;
  late DateTime endTimeTemp;
  late DateTime endTimeMin;

  @override
  void initState() {
    super.initState();
    setState(() {
      startTime = widget.breakStartTime;
      startTimeTemp = widget.breakStartTime;
      endTime = widget.breakEndTime;
      endTimeTemp = widget.breakEndTime;
      endTimeMin = startTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget renderTimePicker() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                    Languages.of(context)!.startLabel.toTitleCase(),
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
                      minuteInterval: 5,
                      minimumDate: widget.breakStartTime,
                      maximumDate: widget.breakEndTime,
                      initialDateTime: startTime,
                      title:
                          Languages.of(context)!.startTimeLabel.toTitleCase(),
                      onDateTimeChanged: (DateTime value) => {
                        setState(() {
                          startTimeTemp = value;
                        }),
                      },
                      primaryAction: () => {
                        setState(() {
                          startTime = startTimeTemp;
                          endTimeMin = startTimeTemp;
                          if (startTime.isAfter(endTime)) {
                            endTime = startTimeTemp;
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
              mainAxisAlignment: MainAxisAlignment.start,
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
                    Languages.of(context)!.endLabel.toTitleCase(),
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
                      minuteInterval: 5,
                      minimumDate: endTimeMin,
                      maximumDate: widget.breakEndTime,
                      initialDateTime: endTime,
                      title: Languages.of(context)!.endTimeLabel.toTitleCase(),
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

    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText:
              '${widget.dayTile} ${Languages.of(context)!.breakLabel.toTitleCase()}',
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: renderTimePicker()),
              CustomButton(
                customButtonProps: CustomButtonProps(
                  text: Languages.of(context)!.addBreakLabel.toTitleCase(),
                  onTap: (() => Navigator.pop(
                        context,
                        WorkingDayBreak(
                          startTime: TimeOfDay(
                            hour: startTime.hour,
                            minute: startTime.minute,
                          ),
                          endTime: TimeOfDay(
                            hour: endTime.hour,
                            minute: endTime.minute,
                          ),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
