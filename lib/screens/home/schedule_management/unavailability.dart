import 'package:appointments/data_types/settings_components.dart';
import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/settings_mgr.dart';
import 'package:appointments/utils/general.dart';
import 'package:appointments/providers/theme_provider.dart';
import 'package:common_widgets/custom_container.dart';

import 'package:appointments/widget/unavailability_card.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_input_field.dart';
import 'package:common_widgets/custom_input_field_button.dart';
import 'package:common_widgets/custom_loading_dialog.dart';
import 'package:common_widgets/custom_modal.dart';
import 'package:common_widgets/picker_date_time_modal.dart';
import 'package:common_widgets/utils/date.dart';
import 'package:common_widgets/utils/flash_manager.dart';
import 'package:common_widgets/utils/general.dart';
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
  DateTime startDateTime = nearestRange(DateTime.now());
  DateTime startDateTimeTemp = nearestRange(DateTime.now());

  DateTime endTime = nearestRange(DateTime.now());
  DateTime endTimeTemp = nearestRange(DateTime.now());
  DateTime endTimeMin = nearestRange(DateTime.now());

  DateTime _selectedDay = DateTime.now();
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
            Languages.of(context)!.reasonLabel.toCapitalized(),
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
              hintText: Languages.of(context)!.reasonHint.toCapitalized(),
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
                  Languages.of(context)!.startDateTimeLabel.toTitleCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              CustomInputFieldButton(
                text: getDateTimeFormat(
                  dateTime: startDateTime,
                  format: 'dd MMM yyyy • HH:mm',
                  locale: getCurrentLocale(context),
                ),
                onTap: () => showPickerDateTimeModal(
                  pickerDateTimeModalProps: PickerDateTimeModalProps(
                    context: context,
                    minuteInterval: 5,
                    minimumDate: nearestRange(DateTime.now()),
                    initialDateTime: startDateTime,
                    primaryButtonText:
                        Languages.of(context)!.saveLabel.toTitleCase(),
                    secondaryButtonText:
                        Languages.of(context)!.cancelLabel.toTitleCase(),
                    title:
                        Languages.of(context)!.startDateTimeLabel.toTitleCase(),
                    onDateTimeChanged: (DateTime value) => {
                      setState(() {
                        startDateTimeTemp = value;
                      }),
                    },
                    primaryAction: () => {
                      setState(() {
                        startDateTime = startDateTimeTemp;
                        endTimeMin = startDateTimeTemp;
                        if (startDateTime.isAfter(endTime)) {
                          endTime = startDateTimeTemp;
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
                  locale: getCurrentLocale(context),
                ),
                onTap: () => showPickerDateTimeModal(
                  pickerDateTimeModalProps: PickerDateTimeModalProps(
                    mode: CupertinoDatePickerMode.time,
                    context: context,
                    minuteInterval: 5,
                    initialDateTime: endTime,
                    minimumDate: endTimeMin,
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

  @override
  Widget build(BuildContext context) {
    saveUnavailability() async {
      showLoaderDialog(context);
      final settingsMgr = Provider.of<SettingsMgr>(context, listen: false);
      UnavailabilityComp unavailabilityComp = UnavailabilityComp(
          startTime: startDateTime,
          endTime: endTime,
          notes: _descriptionController.text);
      settingsMgr.scheduleManagement.unavailabilityList!
          .add(unavailabilityComp);
      await settingsMgr.submitNewScheduleManagement();
      showSuccessFlash(
        context: context,
        successColor: successPrimaryColor,
        successBody:
            Languages.of(context)!.flashMessageSuccessTitle.toTitleCase(),
        successTitle: Languages.of(context)!
            .unavailabilityUpdatedSuccessfullyBody
            .toCapitalized(),
      );
      Navigator.pop(context);
    }

    deleteUnavailability(int index) {
      deleteUnavailabilityFromList(int index) {
        showLoaderDialog(context);
        settingsMgr.scheduleManagement.unavailabilityList!.removeAt(index);
        settingsMgr.submitNewScheduleManagement().then((value) => {
              showSuccessFlash(
                context: context,
                successColor: successPrimaryColor,
                successBody: Languages.of(context)!
                    .flashMessageSuccessTitle
                    .toTitleCase(),
                successTitle: Languages.of(context)!
                    .unavailabilityDeletedSuccessfullyBody
                    .toCapitalized(),
              ),
              Navigator.pop(context),
              setState(() {}),
            });
      }

      showBottomModal(
        bottomModalProps: BottomModalProps(
          context: context,
          centerTitle: true,
          primaryButtonText: Languages.of(context)!.deleteLabel.toTitleCase(),
          secondaryButtonText: Languages.of(context)!.backLabel.toTitleCase(),
          deleteCancelModal: true,
          primaryAction: () => deleteUnavailabilityFromList(index),
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
                  containerSize: 80,
                  contentPadding: 20,
                ),
              ),
              SizedBox(
                height: rSize(30),
              ),
              Text(
                '${Languages.of(context)!.unavailabilityDeleteLabel.toCapitalized()}?',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                Languages.of(context)!.actionUndoneLabel.toCapitalized(),
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
      child: CustomContainer(
        imagePath: 'assets/images/background4.png',
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CustomAppBar(
            customAppBarProps: CustomAppBarProps(
              titleText:
                  Languages.of(context)!.unavailabilityLabel.toTitleCase(),
              withBack: true,
              withBorder: false,
              isTransparent: true,
              withSave: true,
              saveText: Languages.of(context)!.saveLabel,
              saveTap: () => saveUnavailability(),
            ),
          ),
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
                  height: rSize(40),
                ),
                renderTimePicker(),
                SizedBox(
                  height: rSize(30),
                ),
                _renderReason(),
                Visibility(
                  visible: settingsMgr
                      .scheduleManagement.unavailabilityList!.isNotEmpty,
                  child: Column(
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
                          '${Languages.of(context)!.unavailabilityListLabel.toTitleCase()} (${settingsMgr.scheduleManagement.unavailabilityList!.length})',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
                ),
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
                            locale: getCurrentLocale(context),
                          )} ${Languages.of(context)!.arrowLabel} ${getDateTimeFormat(
                            dateTime: settingsMgr.scheduleManagement
                                .unavailabilityList![index].endTime,
                            format: 'HH:mm',
                            locale: getCurrentLocale(context),
                          )}',
                          subTitle: settingsMgr.scheduleManagement
                              .unavailabilityList![index].notes,
                          unavailabilityDetails: settingsMgr
                              .scheduleManagement.unavailabilityList![index],
                          deleteAction: () => {deleteUnavailability(index)},
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: rSize(15),
                      );
                    },
                    itemCount: settingsMgr
                        .scheduleManagement.unavailabilityList!.length,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
