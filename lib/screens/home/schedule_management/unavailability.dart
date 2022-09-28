import 'package:appointments/data_types/settings_components.dart';
import 'package:appointments/providers/settings_mgr.dart';
import 'package:appointments/widget/unavailability_card.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_input_field.dart';
import 'package:common_widgets/custom_input_field_button.dart';
import 'package:common_widgets/picker_date_time_modal.dart';
import 'package:common_widgets/utils/date.dart';
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
  DateTime? startDateTime;
  DateTime? startDateTimeTemp;

  DateTime? endTime;
  DateTime? endTimeTemp;
  DateTime? endTimeMin;

  DateTime? _selectedDay = kToday;

  List<UnavailabilityData> unavailabilityList = [];

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
    final settingsMgr = Provider.of<SettingsMgr>(context, listen: false);
    _descriptionController.text =
        settingsMgr.scheduleManagement.unavailability!.notes;
    DateTime? st = settingsMgr.scheduleManagement.unavailability!.startTime;
    startDateTime = st != null
        ? DateTime(
            st.year,
            st.month,
            st.day,
            st.hour,
            st.minute,
          )
        : null;
    startDateTimeTemp = st != null
        ? DateTime(
            st.year,
            st.month,
            st.day,
            st.hour,
            st.minute,
          )
        : null;
    DateTime? et = settingsMgr.scheduleManagement.unavailability!.endTime;

    endTime = et != null
        ? DateTime(
            et.year,
            et.month,
            et.day,
            et.hour,
            et.minute,
          )
        : null;
    endTimeTemp = et != null
        ? DateTime(
            et.year,
            et.month,
            et.day,
            et.hour,
            et.minute,
          )
        : null;

    unavailabilityList.add(
      UnavailabilityData(
        startTime: startDateTime,
        endTime: endTime,
        notes: _descriptionController.text,
      ),
    );
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
    saveUnavailability() {
      final settingsMgr = Provider.of<SettingsMgr>(context, listen: false);
      settingsMgr.scheduleManagement.unavailability!.notes =
          _descriptionController.text;
      settingsMgr.scheduleManagement.unavailability!.startTime = startDateTime;
      settingsMgr.scheduleManagement.unavailability!.endTime = endTime;
      settingsMgr.submitNewScheduleManagement();
      Navigator.pop(context);
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
              unavailabilityList.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: rSize(30),
                            bottom: rSize(10),
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
                          dateTime: unavailabilityList[index].startTime,
                          format: 'HH:mm',
                        )} → ${getDateTimeFormat(
                          dateTime: unavailabilityList[index].endTime,
                          format: 'HH:mm',
                        )}',
                        subTitle: unavailabilityList[index].notes,
                        unavailabilityDetails: unavailabilityList[index],
                        deleteAction: () => {},
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: rSize(10),
                    );
                  },
                  itemCount: unavailabilityList.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
