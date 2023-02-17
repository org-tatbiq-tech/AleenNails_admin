import 'package:appointments/data_types/macros.dart';
import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/settings_mgr.dart';
import 'package:appointments/utils/general.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_container.dart';
import 'package:common_widgets/custom_expandable_calendar.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/ease_in_animation.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'day_details.dart';

class IndividualDay extends StatefulWidget {
  const IndividualDay({Key? key}) : super(key: key);

  @override
  State<IndividualDay> createState() => _IndividualDayState();
}

class _IndividualDayState extends State<IndividualDay> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  List<String> workingDaysList = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> getBreakForWorkingDay(WorkingDay workingDay) {
      List<Widget> widgetList = workingDay.breaks != null
          ? workingDay.breaks!.map((dayBreak) {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      '${Languages.of(context)!.breakLabel.toCapitalized()}: ',
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
        // setState(() {
        //   isSaveDisabled = false;
        // });
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
                  getDayName(context, workingDay.day),
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
                            Languages.of(context)!.closedLabel.toTitleCase(),
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

    return CustomContainer(
      imagePath: 'assets/images/background4.png',
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          customAppBarProps: CustomAppBarProps(
            withBorder: true,
            isTransparent: false,
            withBack: true,
            withSave: true,
            // centerTitle: WrapAlignment.center,
            titleText: Languages.of(context)!.individualDay,
          ),
        ),
        body: Consumer<SettingsMgr>(
          builder: (context, settingsMgr, _) => Stack(
            children: [
              Column(
                children: [
                  CustomExpandableCalendar(
                    customExpandableCalendarProps:
                        CustomExpandableCalendarProps(
                      focusedDay: _focusedDay,
                      selectedDay: _selectedDay,
                      locale: getCurrentLocale(context),
                      calendarFormat: _calendarFormat,
                      availableCalendarFormats: {
                        CalendarFormat.month: Languages.of(context)!.monthLabel,
                      },
                      onDaySelected: _onDaySelected,
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                      onFormatChanged: (format) {
                        if (_calendarFormat != format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: rSize(20),
                      vertical: rSize(20),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CustomIcon(
                              customIconProps: CustomIconProps(
                                icon: null,
                                path: 'assets/icons/tab_hand.png',
                                iconColor:
                                    Theme.of(context).colorScheme.primary,
                                backgroundColor: Colors.transparent,
                                containerSize: rSize(30),
                                withPadding: false,
                              ),
                            ),
                            SizedBox(
                              width: rSize(10),
                            ),
                            Text(Languages.of(context)!.individualDayMessage),
                          ],
                        ),
                        SizedBox(
                          height: rSize(20),
                        ),
                        renderDay(
                          workingDay: settingsMgr.scheduleManagement
                              .workingDays!.schedule![workingDaysList[0]]!,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
