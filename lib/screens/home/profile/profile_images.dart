import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/widget/custom/custom_container.dart';
import 'package:common_widgets/fade_animation.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:common_widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

class ProfileImages extends StatelessWidget {
  const ProfileImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          customAppBarProps: CustomAppBarProps(
            titleText:
                Languages.of(context)!.profileImagesLabel.toCapitalized(),
            withBack: true,
            isTransparent: true,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: rSize(30),
            vertical: rSize(30),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                Languages.of(context)!.profileImageDescription.toCapitalized(),
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
                  title: Languages.of(context)!.logoLabel.toTitleCase(),
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
                  title: Languages.of(context)!.coverPhotoLabel.toTitleCase(),
                ),
              ),
              SizedBox(
                height: rSize(20),
              ),
              CustomIconButton(
                customIconButtonProps: CustomIconButtonProps(
                  onTap: () => {
                    Navigator.pushNamed(context, '/businessWorkplacePhotos')
                  },
                  animationDelay: 0.5,
                  iconPath: 'assets/icons/images.png',
                  positionType: PositionType.bottom,
                  title:
                      Languages.of(context)!.workplacePhotoLabel.toTitleCase(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
