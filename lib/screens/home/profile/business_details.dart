import 'package:common_widgets/fade_animation.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_icon_button.dart';
import 'package:flutter/material.dart';

class BusinessDetails extends StatelessWidget {
  const BusinessDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText: 'Business Profile',
          withBack: true,
          barHeight: 110,
          withClipPath: true,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: rSize(30),
          vertical: rSize(50),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomIconButton(
              customIconButtonProps: CustomIconButtonProps(
                onTap: () => {Navigator.pushNamed(context, '/businessInfo')},
                animationDelay: 0.1,
                iconPath: 'assets/icons/home_outline.png',
                positionType: PositionType.bottom,
                title: 'Business Name & Info',
              ),
            ),
            SizedBox(
              height: rSize(20),
            ),
            CustomIconButton(
              customIconButtonProps: CustomIconButtonProps(
                onTap: () => {Navigator.pushNamed(context, '/profileImages')},
                animationDelay: 0.3,
                iconPath: 'assets/icons/images.png',
                positionType: PositionType.bottom,
                title: 'Profile Images',
              ),
            ),
            SizedBox(
              height: rSize(20),
            ),
            CustomIconButton(
              customIconButtonProps: CustomIconButtonProps(
                onTap: () => {Navigator.pushNamed(context, '/businessAddress')},
                animationDelay: 0.5,
                iconPath: 'assets/icons/place_holder.png',
                positionType: PositionType.bottom,
                title: 'Business Location',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
