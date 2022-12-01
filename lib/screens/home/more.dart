import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/widget/custom/custom_container.dart';
import 'package:common_widgets/custom_icon_button.dart';
import 'package:common_widgets/fade_animation.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';

class More extends StatefulWidget {
  const More({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MoreState();
  }
}

class MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.only(
            left: rSize(30),
            right: rSize(30),
            top: rSize(80),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: const AssetImage('assets/images/main_logo.png'),
                width: rSize(150),
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: rSize(80),
              ),
              CustomIconButton(
                customIconButtonProps: CustomIconButtonProps(
                  onTap: () => {Navigator.pushNamed(context, '/services')},
                  animationDelay: 0.5,
                  iconPath: 'assets/icons/menu.png',
                  positionType: PositionType.bottom,
                  title: Languages.of(context)!.serviceSetupLabel.toTitleCase(),
                ),
              ),
              SizedBox(
                height: rSize(20),
              ),
              CustomIconButton(
                customIconButtonProps: CustomIconButtonProps(
                  onTap: () =>
                      {Navigator.pushNamed(context, '/scheduleManagement')},
                  animationDelay: 0.5,
                  iconPath: 'assets/icons/calendar_time.png',
                  positionType: PositionType.bottom,
                  title: Languages.of(context)!
                      .scheduleManagementLabel
                      .toTitleCase(),
                ),
              ),
              SizedBox(
                height: rSize(20),
              ),
              CustomIconButton(
                customIconButtonProps: CustomIconButtonProps(
                  onTap: () =>
                      {Navigator.pushNamed(context, '/businessDetails')},
                  animationDelay: 0.5,
                  iconPath: 'assets/icons/profile.png',
                  positionType: PositionType.bottom,
                  title:
                      Languages.of(context)!.businessDetailsLabel.toTitleCase(),
                ),
              ),
              SizedBox(
                height: rSize(20),
              ),
              CustomIconButton(
                customIconButtonProps: CustomIconButtonProps(
                  onTap: () =>
                      {Navigator.pushNamed(context, '/bookingSettings')},
                  animationDelay: 0.5,
                  iconPath: 'assets/icons/settings.png',
                  positionType: PositionType.bottom,
                  title:
                      Languages.of(context)!.bookingSettingsLabel.toTitleCase(),
                ),
              ),
              SizedBox(
                height: rSize(20),
              ),
              CustomIconButton(
                customIconButtonProps: CustomIconButtonProps(
                  onTap: () =>
                      {Navigator.pushNamed(context, '/personalSettings')},
                  animationDelay: 0.7,
                  iconPath: 'assets/icons/setting_hand.png',
                  positionType: PositionType.bottom,
                  title: Languages.of(context)!
                      .personalSettingsLabel
                      .toTitleCase(),
                ),
              ),
              // SizedBox(
              //   height: rSize(20),
              // ),
              // CustomIconButton(
              //   customIconButtonProps: CustomIconButtonProps(
              //     onTap: () => {},
              //     animationDelay: 0.9,
              //     iconPath: 'assets/icons/customer-support.png',
              //     positionType: PositionType.bottom,
              //     title: 'Customer Support Chat',
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
