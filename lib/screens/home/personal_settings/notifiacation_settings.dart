import 'package:app_settings/app_settings.dart';
import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_list_tile.dart';
import 'package:flutter/material.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({Key? key}) : super(key: key);

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  @override
  Widget build(BuildContext context) {
    bool isEnabled = true;

    Widget renderMyNotification() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'My Notification',
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
                'Send me push notifications (this device)',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Transform.scale(
                scale: rSize(1.4),
                alignment: Alignment.center,
                child: Switch(
                  onChanged: (bool value) {
                    setState(() {
                      isEnabled = value;
                    });
                  },
                  splashRadius: 0,
                  activeColor: Theme.of(context).colorScheme.primary,
                  inactiveThumbColor:
                      Theme.of(context).colorScheme.onBackground,
                  inactiveTrackColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  value: isEnabled,
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
            'Notify By',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(
            height: rSize(10),
          ),
          CustomListTile(
            customListTileProps: CustomListTileProps(
              height: rSize(60),
              enabled: true,
              onTap: () => AppSettings.openNotificationSettings(),
              title: Text(
                'Settings',
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

    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText: 'Notifications',
          withBack: true,
          withBorder: false,
          barHeight: 110,
          withClipPath: true,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: rSize(30),
          vertical: rSize(20),
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
    );
  }
}
