import 'package:appointments/screens/home/schedule_management/day_details.dart';
import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/date.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_input_field.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:flutter/material.dart';

class WorkingDays extends StatefulWidget {
  const WorkingDays({Key? key}) : super(key: key);

  @override
  State<WorkingDays> createState() => _WorkingDaysState();
}

class _WorkingDaysState extends State<WorkingDays> {
  final TextEditingController _descriptionController = TextEditingController();

  List<WorkingDay> workingDayList = [
    WorkingDay(
        title: 'Sunday', startTime: kToday, endTime: kToday, isDayOff: true),
    WorkingDay(
        title: 'Monday', startTime: kToday, endTime: kToday, isDayOff: true),
    WorkingDay(
      title: 'Tuesday',
      startTime: kToday,
      endTime: kToday,
      breaks: [
        WorkingDayBreak(startTime: kToday, endTime: kToday),
        WorkingDayBreak(startTime: kToday, endTime: kToday),
      ],
    ),
    WorkingDay(
      title: 'Wednesday',
      startTime: kToday,
      endTime: kToday,
      breaks: [
        WorkingDayBreak(startTime: kToday, endTime: kToday),
      ],
    ),
    WorkingDay(
      title: 'Thursday',
      startTime: kToday,
      endTime: kToday,
      breaks: [
        WorkingDayBreak(startTime: kToday, endTime: kToday),
        WorkingDayBreak(startTime: kToday, endTime: kToday),
      ],
    ),
    WorkingDay(title: 'Friday', startTime: kToday, endTime: kToday),
    WorkingDay(title: 'Saturday', startTime: kToday, endTime: kToday),
  ];

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

  @override
  Widget build(BuildContext context) {
    List<Widget> getBreakForWorkingDay(WorkingDay workingDay) {
      List<Widget> widgetList = workingDay.breaks != null
          ? workingDay.breaks!.map((workingDay) {
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
                      getDateTimeFormat(dateTime: workingDay.startTime),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      ' - ',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      getDateTimeFormat(dateTime: workingDay.endTime),
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
      );
    }

    renderDay({required WorkingDay workingDay}) {
      return EaseInAnimation(
        beginAnimation: 1,
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DayDetails(
                dayTile: workingDay.title,
              ),
            ),
          )
        },
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
                  workingDay.title,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              Expanded(
                child: !workingDay.isDayOff
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                getDateTimeFormat(
                                    dateTime: workingDay.startTime),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                ' - ',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                getDateTimeFormat(
                                    dateTime: workingDay.startTime),
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
              saveTap: () => {
                    Navigator.pop(context),
                  }),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          top: false,
          right: false,
          left: false,
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  // physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) {
                    return index == workingDayList.length
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
                  itemCount: workingDayList.length + 2,
                  itemBuilder: (context, index) {
                    if (index == 0 || index == workingDayList.length + 1) {
                      return Container(); // zero height: not visible
                    }
                    return renderDay(
                      workingDay: workingDayList[index - 1],
                    );
                  },
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //     // vertical: rSize(20),
              //     horizontal: rSize(30),
              //   ),
              //   child: _renderDescription(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
