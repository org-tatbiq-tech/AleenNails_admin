import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/settings_mgr.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:appointments/utils/general.dart';
import 'package:common_widgets/custom_icon_button.dart';
import 'package:common_widgets/fade_animation.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          titleText:
              Languages.of(context)!.scheduleManagementLabel.toTitleCase(),
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
        child: Consumer<SettingsMgr>(
          builder: (context, settingsMgr, _) => Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomIconButton(
                customIconButtonProps: CustomIconButtonProps(
                  onTap: () => {Navigator.pushNamed(context, '/workingDays')},
                  animationDelay: 0.3,
                  iconPath: 'assets/icons/calendar_time.png',
                  positionType: PositionType.bottom,
                  title: Languages.of(context)!.workingDaysLabel.toTitleCase(),
                ),
              ),
              SizedBox(
                height: rSize(20),
              ),
              CustomIconButton(
                customIconButtonProps: CustomIconButtonProps(
                  onTap: () =>
                      {Navigator.pushNamed(context, '/unavailability')},
                  animationDelay: 0.5,
                  iconPath: 'assets/icons/calendar_x.png',
                  positionType: PositionType.bottom,
                  title:
                      Languages.of(context)!.unavailabilityLabel.toTitleCase(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
