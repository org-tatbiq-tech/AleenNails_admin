import 'package:app_settings/app_settings.dart';
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
