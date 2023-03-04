import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/settings_mgr.dart';
import 'package:appointments/utils/general.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_container.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_input_field_button.dart';
import 'package:common_widgets/custom_modal.dart';
import 'package:common_widgets/picker_date_time_modal.dart';
import 'package:common_widgets/utils/date.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class AddLeave extends StatefulWidget {
  const AddLeave({Key? key}) : super(key: key);

  @override
  State<AddLeave> createState() => _AddLeaveState();
}

class _AddLeaveState extends State<AddLeave> {
  DateTime? durationValue;
  late DateTime startTime;
  late DateTime startTimeTemp;
  late DateTime endTime;
  late DateTime endTimeTemp;
  late DateTime endTimeMin;
  late SettingsMgr settingsMgr;
  bool isSaveDisabled = true;
  DateTime today = DateTime.now();
  @override
  void initState() {
    super.initState();
    settingsMgr = Provider.of<SettingsMgr>(context, listen: false);
    setState(() {
      startTime = DateTime(
        today.year,
        today.month,
        today.day,
      );
      startTimeTemp = startTime;
      endTime = DateTime(
        today.year,
        today.month,
        today.day,
      );
      endTimeTemp = endTime;
      endTimeMin = startTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    String getDuration() {
      return (endTime.difference(startTime).inDays + 1).toString();
    }

    addVacation() {
      getDateRangeMessage() {
        if (isSameDay(startTime, endTime)) {
          return '${getDateTimeFormat(
            dateTime: startTime,
            format: 'EEEE, dd-MMM-yyyy',
            locale: getCurrentLocale(context),
          )} ';
        }
        return '${getDateTimeFormat(
          dateTime: startTime,
          format: 'EEEE, dd-MMM-yyyy',
          locale: getCurrentLocale(context),
        )} ${Languages.of(context)!.arrowLabel} ${getDateTimeFormat(
          dateTime: endTime,
          format: 'EEEE, dd-MMM-yyyy',
          locale: getCurrentLocale(context),
        )}';
      }

      submitVacation() {
        settingsMgr.submitNewVacation(startTime, endTime);
        Navigator.pop(context, {'added': true});
      }

      showBottomModal(
        bottomModalProps: BottomModalProps(
          context: context,
          centerTitle: true,
          primaryButtonText: Languages.of(context)!.confirmLabel.toUpperCase(),
          primaryAction: () => {submitVacation()},
          secondaryButtonText: Languages.of(context)!.cancelLabel.toUpperCase(),
          footerButton: ModalFooter.both,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomIcon(
                customIconProps: CustomIconProps(
                  icon: null,
                  path: 'assets/icons/cancel.png',
                  withPadding: true,
                  backgroundColor: Theme.of(context).colorScheme.error,
                  iconColor: Colors.white,
                  containerSize: 80,
                  contentPadding: 20,
                ),
              ),
              SizedBox(
                height: rSize(30),
              ),
              Text(
                Languages.of(context)!.addVacationMessage.toCapitalized(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                getDateRangeMessage(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                '${getDuration()} ${Languages.of(context)!.daysLabel}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      );
    }

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
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                CustomInputFieldButton(
                  fontSize: 16,
                  text: getDateTimeFormat(
                    dateTime: startTime,
                    format: 'EEEE, dd-MMM',
                    locale: getCurrentLocale(context),
                  ),
                  onTap: () => showPickerDateTimeModal(
                    pickerDateTimeModalProps: PickerDateTimeModalProps(
                      mode: CupertinoDatePickerMode.date,
                      context: context,
                      minimumDate: DateTime(
                        today.year,
                        today.month,
                        today.day,
                      ),
                      // maximumDate: widget.breakEndTime,
                      initialDateTime: startTime,
                      primaryButtonText:
                          Languages.of(context)!.saveLabel.toTitleCase(),
                      secondaryButtonText:
                          Languages.of(context)!.cancelLabel.toTitleCase(),
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
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                CustomInputFieldButton(
                  fontSize: 16,
                  text: getDateTimeFormat(
                    dateTime: endTime,
                    format: 'EEEE, dd-MMM',
                    locale: getCurrentLocale(context),
                  ),
                  onTap: () => showPickerDateTimeModal(
                    pickerDateTimeModalProps: PickerDateTimeModalProps(
                      mode: CupertinoDatePickerMode.date,
                      context: context,
                      minimumDate: endTimeMin,
                      // maximumDate: widget.breakEndTime,
                      initialDateTime: endTime,
                      primaryButtonText:
                          Languages.of(context)!.saveLabel.toTitleCase(),
                      secondaryButtonText:
                          Languages.of(context)!.cancelLabel.toTitleCase(),
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

    return CustomContainer(
      imagePath: 'assets/images/background4.png',
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          customAppBarProps: CustomAppBarProps(
            titleText: Languages.of(context)!.addLeaveLabel.toTitleCase(),
            withBack: true,
            isTransparent: true,
          ),
        ),
        body: SafeArea(
          top: false,
          right: false,
          left: false,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: rSize(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: rSize(30),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: rSize(30)),
                  child: Text(
                    Languages.of(context)!.addLeaveMessage.toTitleCase(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Expanded(child: renderTimePicker()),
                Divider(color: Theme.of(context).colorScheme.primary),
                Padding(
                  padding: EdgeInsets.only(bottom: rSize(40), top: rSize(5)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          Languages.of(context)!.durationLabel,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(
                          height: rSize(5),
                        ),
                        Text(
                          '${getDuration()} ${Languages.of(context)!.daysLabel}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                CustomButton(
                  customButtonProps: CustomButtonProps(
                    text: Languages.of(context)!.saveLabel.toTitleCase(),
                    onTap: () => {addVacation()},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
