import 'package:appointments/data_types/macros.dart';
import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/settings_mgr.dart';
import 'package:appointments/providers/theme_provider.dart';
import 'package:appointments/screens/home/schedule_management/add_leave.dart';
import 'package:appointments/utils/general.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_container.dart';
import 'package:common_widgets/custom_expandable_calendar.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_modal.dart';
import 'package:common_widgets/ease_in_animation.dart';
import 'package:common_widgets/utils/flash_manager.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'day_details.dart';

class OpeningCalendar extends StatefulWidget {
  const OpeningCalendar({Key? key}) : super(key: key);

  @override
  State<OpeningCalendar> createState() => _OpeningCalendarState();
}

class _OpeningCalendarState extends State<OpeningCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  bool _isDayEditable = true;
  bool _isDayResettable = false;
  late SettingsMgr settingsMgr;

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
    final settingsMgr = Provider.of<SettingsMgr>(context, listen: false);
    var now = DateTime.now();
    var yesterday = DateTime(now.year, now.month, now.day)
        .subtract(const Duration(days: 1));
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay =
            DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
        if (_selectedDay.isAfter(yesterday)) {
          _isDayEditable = true;
        } else {
          _isDayEditable = false;
        }
        _isDayResettable = settingsMgr.isDayResettable(_selectedDay);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    settingsMgr = Provider.of<SettingsMgr>(context, listen: false);
    DateTime now = DateTime.now();
    _focusedDay = DateTime(now.year, now.month, now.day);
    _selectedDay = DateTime(now.year, now.month, now.day);
  }

  @override
  Widget build(BuildContext context) {
    resetScheduleDay() {
      settingsMgr
          .deleteScheduleOverride(settingsMgr.getWorkingDay(_selectedDay));
      setState(() {
        _isDayResettable = false;
      });
    }

    resetDate() {
      showBottomModal(
        bottomModalProps: BottomModalProps(
          context: context,
          centerTitle: true,
          primaryButtonText: Languages.of(context)!.confirmLabel.toUpperCase(),
          primaryAction: () => {resetScheduleDay()},
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
                Languages.of(context)!.resetDateMessage.toCapitalized(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      );
    }

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
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      getTimeOfDayFormat(dayBreak.startTime),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      ' - ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      getTimeOfDayFormat(dayBreak.endTime),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ]);
            }).toList()
          : [];
      return widgetList;
    }

    renderDay({required WorkingDay workingDay}) {
      openDayDetails() async {
        var res = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DayDetails(
              workingDay: workingDay,
              isIndividualWorkingDay: true,
            ),
          ),
        );
        if (res != null && res['changed'] == true) {
          setState(() {
            _isDayResettable = true;
          });
        }
      }

      return EaseInAnimation(
        beginAnimation: 1,
        onTap: _isDayEditable ? () => openDayDetails() : () => {},
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: rSize(10),
            vertical: rSize(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                  getDayName(context, workingDay.day),
                  style: Theme.of(context).textTheme.titleMedium,
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
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                ' - ',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                getTimeOfDayFormat(workingDay.endTime),
                                style: Theme.of(context).textTheme.bodyLarge,
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
                            style: Theme.of(context).textTheme.bodyLarge,
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

    navigateToVacation() async {
      var res = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddLeave(),
        ),
      );
      if (res != null && res['added']) {
        showSuccessFlash(
          successColor: successPrimaryColor,
          context: context,
          successTitle: Languages.of(context)!.vacationTitle,
          successBody: Languages.of(context)!.vacationBody,
        );
      }
    }

    return CustomContainer(
      imagePath: 'assets/images/background4.png',
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          elevation: 4.0,
          splashColor: Colors.transparent,
          onPressed: () => {navigateToVacation()},
          child: CustomIcon(
            customIconProps: CustomIconProps(
              icon: null,
              path: 'assets/icons/vacation.png',
              backgroundColor: Colors.transparent,
              containerSize: 30,
              iconColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          customAppBarProps: CustomAppBarProps(
            withBorder: true,
            isTransparent: true,
            withBack: true,
            withSave: false,
            barHeight: 75,
            // centerTitle: WrapAlignment.center,
            titleText: Languages.of(context)!.openingCalendarLabel,
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
                      vertical: rSize(30),
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
                            Text(Languages.of(context)!.openingCalendarMessage),
                          ],
                        ),
                        SizedBox(
                          height: rSize(20),
                        ),
                        Divider(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        renderDay(
                          workingDay: settingsMgr.getWorkingDay(_selectedDay),
                        ),
                        Divider(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        SizedBox(
                          height: rSize(20),
                        ),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: _isDayResettable
                              ? CustomButton(
                                  customButtonProps: CustomButtonProps(
                                    onTap: () => {resetDate()},
                                    text: Languages.of(context)!.resetLabel,
                                  ),
                                )
                              : const SizedBox(),
                        )
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
