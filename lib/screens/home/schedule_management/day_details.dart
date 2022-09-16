import 'package:common_widgets/utils/date.dart';
import 'package:common_widgets/utils/date.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_input_field_button.dart';
import 'package:appointments/widget/custom_text_button.dart';
import 'package:common_widgets/picker_date_time_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DayDetails extends StatefulWidget {
  final String dayTile;
  final bool isIndividual;
  const DayDetails({
    Key? key,
    this.dayTile = '',
    this.isIndividual = false,
  }) : super(key: key);

  @override
  State<DayDetails> createState() => _DayDetailsState();
}

class _DayDetailsState extends State<DayDetails> {
  DateTime? durationValue;
  bool _isWorking = false;
  bool _isChanged = false;
  DateTime? startTime;
  DateTime? startTimeTemp;
  DateTime? endTime;
  DateTime? endTimeTemp;
  DateTime? endTimeMin;

  @override
  Widget build(BuildContext context) {
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
                    value: _isWorking,
                    onChanged: (bool state) {
                      setState(() {
                        _isWorking = state;
                        _isChanged = true;
                      });
                    },
                  ),
                ),
              ),
              Text(
                _isWorking ? 'Open' : 'Closed',
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
              onTap: () => {},
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
                      minimumDate: endTimeMin,
                      initialDateTime: endTime ?? endTimeMin,
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

    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText: widget.dayTile,
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
                height: widget.isIndividual ? 0 : rSize(20),
              ),
              widget.isIndividual
                  ? const SizedBox()
                  : Text(
                      'Set your business hours here. Head to Opening Calendar from Settings menu if you need to adjust hours for single day',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontSize: rSize(14),
                          ),
                    ),
              Expanded(
                child: AnimatedSwitcher(
                  reverseDuration: const Duration(milliseconds: 400),
                  duration: const Duration(milliseconds: 400),
                  child: _isWorking
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height:
                                  widget.isIndividual ? rSize(20) : rSize(40),
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
              widget.isIndividual
                  ? Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: CustomButton(
                            customButtonProps: CustomButtonProps(
                              isDisabled: !_isChanged,
                              text: 'Reset',
                              isPrimary: false,
                              isSecondary: true,
                              onTap: (() => Navigator.pop(context)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: rSize(20),
                        ),
                        Expanded(
                          flex: 2,
                          child: CustomButton(
                            customButtonProps: CustomButtonProps(
                              text: 'Save',
                              onTap: (() => Navigator.pop(context)),
                            ),
                          ),
                        ),
                      ],
                    )
                  : CustomButton(
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
