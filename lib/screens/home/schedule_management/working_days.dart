import 'package:appointments/data_types/macros.dart';
import 'package:appointments/providers/settings_mgr.dart';
import 'package:appointments/screens/home/schedule_management/day_details.dart';
import 'package:appointments/utils/general.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_input_field.dart';
import 'package:common_widgets/ease_in_animation.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkingDays extends StatefulWidget {
  const WorkingDays({Key? key}) : super(key: key);

  @override
  State<WorkingDays> createState() => _WorkingDaysState();
}

class _WorkingDaysState extends State<WorkingDays> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final settingsMgr = Provider.of<SettingsMgr>(context, listen: false);
    _descriptionController.text =
        settingsMgr.scheduleManagement.workingDays!.notes;

    _descriptionController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> workingDaysList = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];

    List<Widget> getBreakForWorkingDay(WorkingDay workingDay) {
      List<Widget> widgetList = workingDay.breaks != null
          ? workingDay.breaks!.map((dayBreak) {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Break: ',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      getTimeOfDayFormat(dayBreak.startTime),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      ' - ',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      getTimeOfDayFormat(dayBreak.endTime),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ]);
            }).toList()
          : [];
      return widgetList;
    }

    Widget renderDescription() {
      return Padding(
        padding: EdgeInsets.only(
          top: rSize(40),
        ),
        child: Consumer<SettingsMgr>(
          builder: (context, settingsMgr, _) => Column(
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
                  'Business Hours Note',
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
                    hintText:
                        'Short description of your business working hours (recommended)',
                    isDescription: true,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    renderDay({required WorkingDay workingDay}) {
      getDayDetails() async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DayDetails(
              workingDay: workingDay,
            ),
          ),
        );
        setState(() {});
      }

      return EaseInAnimation(
        beginAnimation: 1,
        onTap: () => getDayDetails(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: rSize(10),
            vertical: rSize(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                  workingDay.day,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              Expanded(
                child: workingDay.isDayOn
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                getTimeOfDayFormat(workingDay.startTime),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                ' - ',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                getTimeOfDayFormat(workingDay.endTime),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: workingDay.breaks != null ? rSize(6) : 0,
                          ),
                          ...getBreakForWorkingDay(workingDay),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Closed',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
              ),
              IconTheme(
                data: Theme.of(context).primaryIconTheme,
                child: Icon(
                  Icons.chevron_right,
                  size: rSize(25),
                ),
              ),
            ],
          ),
        ),
      );
    }

    saveWorkingDays() {
      final settingsMgr = Provider.of<SettingsMgr>(context, listen: false);
      settingsMgr.scheduleManagement.workingDays!.notes =
          _descriptionController.text;
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
            titleText: 'Working Days',
            withBack: true,
            barHeight: 110,
            withClipPath: true,
            withSave: true,
            saveTap: () => saveWorkingDays(),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Consumer<SettingsMgr>(
          builder: (context, settingsMgr, _) => SafeArea(
            top: false,
            right: false,
            left: false,
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return index == workingDaysList.length
                          ? renderDescription()
                          : index == 0
                              ? const SizedBox()
                              : Divider(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                );
                    },
                    padding: EdgeInsets.symmetric(
                      vertical: rSize(20),
                      horizontal: rSize(30),
                    ),
                    itemCount: workingDaysList.length + 2,
                    itemBuilder: (context, index) {
                      if (index == 0 || index == workingDaysList.length + 1) {
                        return Container(); // zero height: not visible
                      }
                      return renderDay(
                        workingDay: settingsMgr.scheduleManagement.workingDays!
                            .schedule![workingDaysList[index - 1]]!,
                      );
                    },
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
