import 'package:appointments/data_types/macros.dart';
import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/screens/home/schedule_management/day_break.dart';
import 'package:appointments/utils/general.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:appointments/utils/layout.dart';
import 'package:common_widgets/custom_text_button.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_input_field_button.dart';
import 'package:common_widgets/ease_in_animation.dart';
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
  bool isSaveDisabled = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      DateTime today = DateTime.now();
      startTime = widget.workingDay.startTime == null
          ? DateTime(
              today.year,
              today.month,
              today.day,
              8,
              0,
            )
          : DateTime(
              today.year,
              today.month,
              today.day,
              widget.workingDay.startTime!.hour,
              widget.workingDay.startTime!.minute,
            );
      startTimeTemp = startTime;
      // startTimeTemp = DateTime(
      //   today.year,
      //   today.month,
      //   today.day,
      //   8,
      //   0,
      // );
      endTime = widget.workingDay.endTime == null
          ? DateTime(
              today.year,
              today.month,
              today.day,
              18,
              0,
            )
          : DateTime(
              today.year,
              today.month,
              today.day,
              widget.workingDay.endTime!.hour,
              widget.workingDay.endTime!.minute,
            );
      endTimeTemp = endTime;
      // endTimeTemp = DateTime(
      //   today.year,
      //   today.month,
      //   today.day,
      //   18,
      //   0,
      // );
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
        setState(() {
          widget.workingDay.breaks ??= [];
          widget.workingDay.breaks!.add(result);
          isSaveDisabled = false;
        });
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
                  Languages.of(context)!.workingOnThisDayLabel.toCapitalized(),
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
                        isSaveDisabled = false;
                      });
                    },
                  ),
                ),
              ),
              Text(
                widget.workingDay.isDayOn
                    ? Languages.of(context)!.openLabel.toCapitalized()
                    : Languages.of(context)!.closedLabel.toCapitalized(),
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontSize: rSize(12),
                    ),
              ),
            ],
          ),
        ],
      );
    }

    Widget renderBreakTime(WorkingDayBreak workingDayBreak) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: rSize(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
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
                      Languages.of(context)!.startLabel.toCapitalized(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  CustomInputFieldButton(
                    isDisabled: true,
                    text: getTimeOfDayFormat(
                      workingDayBreak.startTime,
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
                      Languages.of(context)!.endLabel.toCapitalized(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  CustomInputFieldButton(
                    isDisabled: true,
                    text: getTimeOfDayFormat(
                      workingDayBreak.endTime,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: rSize(20),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: rSize(10)),
              child: Row(
                children: [
                  EaseInAnimation(
                    onTap: () => {
                      setState(
                        () {
                          widget.workingDay.breaks?.removeWhere(
                            (item) => item == workingDayBreak,
                          );
                          isSaveDisabled = false;
                        },
                      )
                    },
                    child: CustomIcon(
                      customIconProps: CustomIconProps(
                        icon: null,
                        path: 'assets/icons/trash.png',
                        withPadding: true,
                        backgroundColor: errorPrimaryColor,
                        iconColor: Colors.white,
                        containerSize: rSize(35),
                        contentPadding: rSize(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    List<Widget> getAllBreaks() {
      if (widget.workingDay.breaks != null) {
        List<Widget> widgetList = widget.workingDay.breaks!.map(
          (WorkingDayBreak workingDayBreak) {
            return renderBreakTime(workingDayBreak);
          },
        ).toList();

        return widgetList;
      }
      return [const SizedBox()];
    }

    Widget renderBreaks() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Languages.of(context)!.breaksLabel.toCapitalized(),
                style: Theme.of(context).textTheme.bodyText2,
              ),
              CustomTextButton(
                customTextButtonProps: CustomTextButtonProps(
                  text: Languages.of(context)!.addBreakLabel.toCapitalized(),
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
          ),
          SizedBox(
            height: rSize(20),
          ),
          Column(
            children: getAllBreaks(),
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
                    Languages.of(context)!.startLabel.toCapitalized(),
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
                      minuteInterval: 5,
                      title:
                          Languages.of(context)!.startTimeLabel.toCapitalized(),
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
                          isSaveDisabled = false;
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
                    Languages.of(context)!.endLabel.toCapitalized(),
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
                      initialDateTime: endTime,
                      title:
                          Languages.of(context)!.endTimeLabel.toCapitalized(),
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
          titleText: getDayName(context, widget.workingDay.day),
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
                Languages.of(context)!
                    .dayDetailsDescriptionLabel
                    .toCapitalized(),
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
                  text: Languages.of(context)!.okLabel.toCapitalized(),
                  isDisabled: isSaveDisabled,
                  onTap: (() => {
                        widget.workingDay.startTime = TimeOfDay(
                          hour: startTime.hour,
                          minute: startTime.minute,
                        ),
                        widget.workingDay.endTime = TimeOfDay(
                          hour: endTime.hour,
                          minute: endTime.minute,
                        ),
                        Navigator.pop(context)
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
