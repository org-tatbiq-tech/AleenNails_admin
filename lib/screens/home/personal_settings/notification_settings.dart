import 'package:app_settings/app_settings.dart';
import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/widget/custom/custom_container.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_list_tile.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool _isEnabled = false;

  @override
  Widget build(BuildContext context) {
    Widget renderMyNotification() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            Languages.of(context)!.notificationsTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                Languages.of(context)!.notificationsMsg,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                width: rSize(70),
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Switch(
                    activeColor: Theme.of(context).colorScheme.primary,
                    splashRadius: 0,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    inactiveTrackColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    inactiveThumbColor:
                        Theme.of(context).colorScheme.background,
                    value: _isEnabled,
                    onChanged: (bool state) {
                      setState(() {
                        _isEnabled = state;
                      });
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      );
    }

    Widget renderNotifyBy() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            Languages.of(context)!.labelNotifyBy,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(
            height: rSize(10),
          ),
          CustomListTile(
            customListTileProps: CustomListTileProps(
              enabled: true,
              onTap: () => AppSettings.openNotificationSettings(),
              title: Text(
                Languages.of(context)!.labelSettings,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              trailing: IconTheme(
                data: Theme.of(context).primaryIconTheme,
                child: Icon(
                  Icons.chevron_right,
                  size: rSize(25),
                ),
              ),
            ),
          )
        ],
      );
    }

    return CustomContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          customAppBarProps: CustomAppBarProps(
              titleText: Languages.of(context)!.labelNotification,
              withBack: true,
              isTransparent: true),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: rSize(30),
            vertical: rSize(40),
          ),
          child: Column(
            children: [
              renderMyNotification(),
              SizedBox(
                height: rSize(20),
              ),
              renderNotifyBy(),
            ],
          ),
        ),
      ),
    );
  }
}
