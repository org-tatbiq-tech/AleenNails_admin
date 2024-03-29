import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/settings_mgr.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_container.dart';
import 'package:common_widgets/custom_icon_button.dart';
import 'package:common_widgets/fade_animation.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BusinessDetails extends StatefulWidget {
  const BusinessDetails({Key? key}) : super(key: key);

  @override
  State<BusinessDetails> createState() => _BusinessDetailsState();
}

class _BusinessDetailsState extends State<BusinessDetails> {
  late SettingsMgr settingsMgr;

  @override
  void initState() {
    settingsMgr = Provider.of<SettingsMgr>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    settingsMgr.pauseScheduleManagement();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      imagePath: 'assets/images/background4.png',
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          customAppBarProps: CustomAppBarProps(
            titleText:
                Languages.of(context)!.businessDetailsLabel.toTitleCase(),
            withBack: true,
            isTransparent: true,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: rSize(50),
            vertical: rSize(50),
          ),
          child: Consumer<SettingsMgr>(
            builder: (context, settingsMgr, _) => Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomIconButton(
                  customIconButtonProps: CustomIconButtonProps(
                    onTap: () =>
                        {Navigator.pushNamed(context, '/businessInfo')},
                    animationDelay: 0.1,
                    iconPath: 'assets/icons/home_outline.png',
                    positionType: PositionType.bottom,
                    title: Languages.of(context)!
                        .businessNameInfoLabel
                        .toTitleCase(),
                  ),
                ),
                SizedBox(
                  height: rSize(20),
                ),
                CustomIconButton(
                  customIconButtonProps: CustomIconButtonProps(
                    onTap: () =>
                        {Navigator.pushNamed(context, '/profileImages')},
                    animationDelay: 0.3,
                    iconPath: 'assets/icons/images.png',
                    positionType: PositionType.bottom,
                    title:
                        Languages.of(context)!.profileImagesLabel.toTitleCase(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
