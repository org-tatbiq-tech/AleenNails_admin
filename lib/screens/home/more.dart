import 'package:appointments/animations/fade_animation.dart';
import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_icon_button.dart';
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
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: rSize(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomIconButton(
              customIconButtonProps: CustomIconButtonProps(
                onTap: () => {},
                animationDelay: 0.1,
                iconPath: 'assets/icons/growth.png',
                positionType: PositionType.bottom,
                text: 'Marketing',
              ),
            ),
            SizedBox(
              height: rSize(20),
            ),
            CustomIconButton(
              customIconButtonProps: CustomIconButtonProps(
                onTap: () => {},
                animationDelay: 0.3,
                iconPath: 'assets/icons/rating.png',
                positionType: PositionType.bottom,
                text: 'Reviews & Ratings',
              ),
            ),
            SizedBox(
              height: rSize(20),
            ),
            CustomIconButton(
              customIconButtonProps: CustomIconButtonProps(
                onTap: () => {Navigator.pushNamed(context, '/services')},
                animationDelay: 0.5,
                iconPath: 'assets/icons/services.png',
                positionType: PositionType.bottom,
                text: 'Services Setup',
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
                iconPath: 'assets/icons/services.png',
                positionType: PositionType.bottom,
                text: 'Schedule Management',
              ),
            ),
            SizedBox(
              height: rSize(20),
            ),
            CustomIconButton(
              customIconButtonProps: CustomIconButtonProps(
                onTap: () => {Navigator.pushNamed(context, '/businessDetails')},
                animationDelay: 0.5,
                iconPath: 'assets/icons/profile.png',
                positionType: PositionType.bottom,
                text: 'Business Details',
              ),
            ),
            SizedBox(
              height: rSize(20),
            ),
            CustomIconButton(
              customIconButtonProps: CustomIconButtonProps(
                onTap: () => {Navigator.pushNamed(context, '/bookingSettings')},
                animationDelay: 0.5,
                iconPath: 'assets/icons/profile.png',
                positionType: PositionType.bottom,
                text: 'Booking Settings',
              ),
            ),
            SizedBox(
              height: rSize(20),
            ),
            CustomIconButton(
              customIconButtonProps: CustomIconButtonProps(
                onTap: () => {},
                animationDelay: 0.7,
                iconPath: 'assets/icons/settings.png',
                positionType: PositionType.bottom,
                text: 'Personal Settings',
              ),
            ),
            SizedBox(
              height: rSize(20),
            ),
            CustomIconButton(
              customIconButtonProps: CustomIconButtonProps(
                onTap: () => {},
                animationDelay: 0.9,
                iconPath: 'assets/icons/customer-support.png',
                positionType: PositionType.bottom,
                text: 'Customer Support Chat',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
