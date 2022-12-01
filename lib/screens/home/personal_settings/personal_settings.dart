import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/auth_mgr.dart';
import 'package:appointments/providers/settings_mgr.dart';
import 'package:appointments/widget/custom/custom_container.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_icon_button.dart';
import 'package:common_widgets/custom_modal.dart';
import 'package:common_widgets/fade_animation.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PersonalSettings extends StatefulWidget {
  const PersonalSettings({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PersonalSettingsState();
  }
}

class PersonalSettingsState extends State<PersonalSettings> {
  //FCM instance
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  late SettingsMgr settingsMgr;
  late AuthenticationMgr authenticationMgr;

  @override
  void initState() {
    super.initState();
    settingsMgr = Provider.of<SettingsMgr>(context, listen: false);
    authenticationMgr = Provider.of<AuthenticationMgr>(context, listen: false);
  }

  signOut() async {
    String? token = await _messaging.getToken();
    if (token != null) {
      await _messaging.deleteToken();
      await settingsMgr.deleteToken(token);
    }
    authenticationMgr.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, '/loginScreen', (Route<dynamic> route) => false);
  }

  logout() {
    showBottomModal(
      bottomModalProps: BottomModalProps(
        context: context,
        centerTitle: true,
        primaryButtonText: Languages.of(context)!.labelLogout,
        secondaryButtonText: Languages.of(context)!.labelLater,
        primaryAction: () => signOut(),
        deleteCancelModal: true,
        footerButton: ModalFooter.both,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomIcon(
              customIconProps: CustomIconProps(
                icon: null,
                path: 'assets/icons/logout.png',
                withPadding: true,
                backgroundColor: Theme.of(context).colorScheme.error,
                iconColor: Colors.white,
                containerSize: rSize(80),
                contentPadding: rSize(20),
              ),
            ),
            SizedBox(
              height: rSize(30),
            ),
            Text(
              Languages.of(context)!.logoutMsg,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          customAppBarProps: CustomAppBarProps(
            titleText: Languages.of(context)!.labelPersonalSettings,
            withBack: true,
            isTransparent: true,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: rSize(30),
            vertical: rSize(80),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomIconButton(
                customIconButtonProps: CustomIconButtonProps(
                  onTap: () =>
                      {Navigator.pushNamed(context, '/notificationSettings')},
                  animationDelay: 0.1,
                  iconPath: 'assets/icons/bell.png',
                  positionType: PositionType.bottom,
                  title: Languages.of(context)!.labelNotification,
                ),
              ),
              SizedBox(
                height: rSize(20),
              ),
              CustomIconButton(
                customIconButtonProps: CustomIconButtonProps(
                  onTap: () =>
                      {Navigator.pushNamed(context, '/languageSettings')},
                  animationDelay: 0.3,
                  iconPath: 'assets/icons/language.png',
                  positionType: PositionType.bottom,
                  title: Languages.of(context)!.labelLanguage,
                ),
              ),
              SizedBox(
                height: rSize(20),
              ),
              CustomIconButton(
                customIconButtonProps: CustomIconButtonProps(
                  onTap: () => {logout()},
                  animationDelay: 0.5,
                  iconPath: 'assets/icons/logout.png',
                  positionType: PositionType.bottom,
                  title: Languages.of(context)!.labelLogout,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
