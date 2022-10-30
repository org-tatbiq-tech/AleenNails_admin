import 'package:appointments/data_types/components.dart';
import 'package:appointments/widget/custom/custom_avatar.dart';
import 'package:common_widgets/custom_list_tile.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final NotificationCardProps notificationCardProps;
  const NotificationCard({
    Key? key,
    required this.notificationCardProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      customListTileProps: CustomListTileProps(
        marginBottom: 15,
        enabled: notificationCardProps.enabled,
        onTap: notificationCardProps.onTap ??
            () => Navigator.pushNamed(context, '/notificationDetails'),
        title: Text(
          notificationCardProps.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline1?.copyWith(
                fontSize: rSize(16),
              ),
        ),
        subTitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              notificationCardProps.subTitle,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                notificationCardProps.withNavigation
                    ? IconTheme(
                        data: Theme.of(context).primaryIconTheme,
                        child: Icon(
                          Icons.chevron_right,
                          size: rSize(25),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
        leading: Row(
          children: [
            CustomAvatar(
              customAvatarProps: CustomAvatarProps(
                enable: true,
                onTap: () => Navigator.pushNamed(context, '/clientDetails'),
                circleShape: true,
                defaultImage: const AssetImage(
                  'assets/images/avatar_female.png',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NotificationCardProps {
  final NotificationData notificationDetails;
  final bool withNavigation;
  final bool enabled;
  final String subTitle;
  final String title;
  final Function? onTap;

  NotificationCardProps({
    required this.notificationDetails,
    this.withNavigation = true,
    this.enabled = true,
    this.subTitle = '',
    this.title = '',
    this.onTap,
  });
}
