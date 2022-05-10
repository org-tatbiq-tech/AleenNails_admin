import 'package:appointments/animations/fade_animation.dart';
import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_icon_button.dart';
import 'package:flutter/material.dart';

class ProfileImages extends StatelessWidget {
  const ProfileImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText: 'Profile Images',
          withBack: true,
          barHeight: 110,
          withClipPath: true,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: rSize(30),
          vertical: rSize(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'What is the first thing you want clients to see about your business? Remember, new clients want to see what they could look like with your services.',
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: rSize(16),
                  ),
            ),
            SizedBox(
              height: rSize(50),
            ),
            CustomIconButton(
              customIconButtonProps: CustomIconButtonProps(
                onTap: () => {Navigator.pushNamed(context, '/businessLogo')},
                animationDelay: 0.1,
                iconPath: 'assets/icons/logo-design.png',
                positionType: PositionType.bottom,
                title: 'Logo',
              ),
            ),
            SizedBox(
              height: rSize(20),
            ),
            CustomIconButton(
              customIconButtonProps: CustomIconButtonProps(
                onTap: () =>
                    {Navigator.pushNamed(context, '/businessCoverPhoto')},
                animationDelay: 0.3,
                iconPath: 'assets/icons/image.png',
                positionType: PositionType.bottom,
                title: 'Cover Photo',
              ),
            ),
            SizedBox(
              height: rSize(20),
            ),
            CustomIconButton(
              customIconButtonProps: CustomIconButtonProps(
                onTap: () =>
                    {Navigator.pushNamed(context, '/businessWorkplacePhotos')},
                animationDelay: 0.5,
                iconPath: 'assets/icons/images.png',
                positionType: PositionType.bottom,
                title: 'Workplace Photos',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
