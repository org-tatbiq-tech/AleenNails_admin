import 'package:appointments/animations/fade_animation.dart';
import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_icon_button.dart';
import 'package:flutter/material.dart';

class ScheduleManagement extends StatefulWidget {
  const ScheduleManagement({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ScheduleManagementState();
  }
}

class ScheduleManagementState extends State<ScheduleManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText: 'Schedule Management',
          withBack: true,
          barHeight: 110,
          withClipPath: true,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: rSize(30),
          vertical: rSize(60),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomIconButton(
              customIconButtonProps: CustomIconButtonProps(
                onTap: () =>
                    {Navigator.pushNamed(context, '/individualSchedule')},
                animationDelay: 0.1,
                iconPath: 'assets/icons/calendar.png',
                positionType: PositionType.bottom,
                title: 'Open Calendar',
              ),
            ),
            SizedBox(
              height: rSize(20),
            ),
            CustomIconButton(
              customIconButtonProps: CustomIconButtonProps(
                onTap: () => {Navigator.pushNamed(context, '/workingDays')},
                animationDelay: 0.3,
                iconPath: 'assets/icons/calendar_time.png',
                positionType: PositionType.bottom,
                title: 'Working Days',
              ),
            ),
            SizedBox(
              height: rSize(20),
            ),
            CustomIconButton(
              customIconButtonProps: CustomIconButtonProps(
                onTap: () => {Navigator.pushNamed(context, '/unavailability')},
                animationDelay: 0.5,
                iconPath: 'assets/icons/calendar_x.png',
                positionType: PositionType.bottom,
                title: 'Unavailability',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
