import 'package:appointments/data_types/settings_components.dart';
import 'package:appointments/providers/settings_mgr.dart';
import 'package:appointments/utils/formats.dart';
import 'package:appointments/widget/unavailability_card.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_input_field.dart';
import 'package:common_widgets/custom_input_field_button.dart';
import 'package:common_widgets/custom_modal.dart';
import 'package:common_widgets/picker_date_time_modal.dart';
import 'package:common_widgets/utils/date.dart';
import 'package:common_widgets/utils/flash_manager.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Unavailability extends StatefulWidget {
  const Unavailability({Key? key}) : super(key: key);

  @override
  State<Unavailability> createState() => _UnavailabilityState();
}

class _UnavailabilityState extends State<Unavailability> {
  final TextEditingController _descriptionController = TextEditingController();

  DayViewController dayViewController = DayViewController();
  DateTime? startDateTime = nearestFive(DateTime.now());
  DateTime startDateTimeTemp = nearestFive(DateTime.now());

  DateTime? endTime = nearestFive(DateTime.now());
  DateTime endTimeTemp = nearestFive(DateTime.now());
  DateTime? endTimeMin;

  DateTime? _selectedDay = kToday;
  late SettingsMgr settingsMgr;

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
    settingsMgr = Provider.of<SettingsMgr>(context, listen: false);

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
                    minuteInterval: 5,
                    minimumDate: nearestFive(DateTime.now()),
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
    bool validateUnavailabilityData() {
      if (startDateTime == null) {
        showErrorFlash(
          context: context,
          errorTitle: 'Error',
          errorBody: 'Please select Start Date & Time.',
        );
        return false;
      }
      if (endTime == null) {
        showErrorFlash(
          context: context,
          errorTitle: 'Error',
          errorBody: 'Please select End Time',
        );
        return false;
      }
      return true;
    }

    saveUnavailability() {
      if (validateUnavailabilityData()) {
        final settingsMgr = Provider.of<SettingsMgr>(context, listen: false);
        UnavailabilityComp unavailabilityComp = UnavailabilityComp(
            startTime: startDateTime,
            endTime: endTime,
            notes: _descriptionController.text);
        settingsMgr.scheduleManagement.unavailabilityList!
            .add(unavailabilityComp);
        settingsMgr.submitNewScheduleManagement();
        Navigator.pop(context);
      }
    }

    removeUnavailability() {
      showBottomModal(
        bottomModalProps: BottomModalProps(
          context: context,
          centerTitle: true,
          primaryButtonText: 'Delete',
          secondaryButtonText: 'Back',
          deleteCancelModal: true,
          footerButton: ModalFooter.both,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomIcon(
                customIconProps: CustomIconProps(
                  icon: null,
                  path: 'assets/icons/trash.png',
                  withPadding: true,
                  backgroundColor: Theme.of(context).colorScheme.error,
                  iconColor: Colors.white,
                  containerSize: rSize(80),
                  contentPadding: rSize(20),
                ),
              ),
              SizedBox(
                height: rSize(30),
              ),
              Text(
                'Delete Unavailability?',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                'Action can not be undone',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
      );
    }

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
            saveTap: () => saveUnavailability(),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: rSize(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              settingsMgr.scheduleManagement.unavailabilityList!.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: rSize(40),
                            bottom: rSize(15),
                          ),
                          child: Text(
                            'Unavailability List',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return UnavailabilityCard(
                      key: ValueKey(index),
                      unavailabilityCardProps: UnavailabilityCardProps(
                        title: '${getDateTimeFormat(
                          dateTime: settingsMgr.scheduleManagement
                              .unavailabilityList![index].startTime,
                          format: 'HH:mm',
                        )} → ${getDateTimeFormat(
                          dateTime: settingsMgr.scheduleManagement
                              .unavailabilityList![index].endTime,
                          format: 'HH:mm',
                        )}',
                        subTitle: settingsMgr.scheduleManagement
                            .unavailabilityList![index].notes,
                        unavailabilityDetails: settingsMgr
                            .scheduleManagement.unavailabilityList![index],
                        deleteAction: () => {removeUnavailability()},
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: rSize(10),
                    );
                  },
                  itemCount:
                      settingsMgr.scheduleManagement.unavailabilityList!.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
