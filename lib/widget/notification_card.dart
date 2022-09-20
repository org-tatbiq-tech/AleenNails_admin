import 'package:appointments/data_types/components.dart';
import 'package:common_widgets/utils/input_validation.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_list_tile.dart';
import 'package:common_widgets/ease_in_animation.dart';
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
        height: rSize(70),
        marginBottom: 15,
        enabled: notificationCardProps.enabled,
        onTap: notificationCardProps.onTap ??
            () => Navigator.pushNamed(context, '/serviceDetails'),
        title: Text(
          notificationCardProps.title,
          maxLines: 1,
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
                // Text(
                //   getStringPrice(notificationCardProps.notificationDetails.name),
                //   style: Theme.of(context).textTheme.headline1?.copyWith(
                //         fontSize: rSize(16),
                //       ),
                // ),
                // SizedBox(
                //   width: rSize(5),
                // ),
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
            notificationCardProps.dragIndex != null
                ? ReorderableDelayedDragStartListener(
                    index: notificationCardProps.dragIndex!,
                    child: EaseInAnimation(
                      onTap: () => {},
                      child: Row(
                        children: [
                          CustomIcon(
                            customIconProps: CustomIconProps(
                              icon: null,
                              backgroundColor: Colors.transparent,
                              path: 'assets/icons/drag_hand.png',
                              withPadding: false,
                              containerSize: 30,
                            ),
                          ),
                          SizedBox(
                            width: rSize(15),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
            VerticalDivider(
              color: Theme.of(context).colorScheme.primary,
              width: rSize(3),
              thickness: rSize(3),
            ),
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
  final int? dragIndex;

  NotificationCardProps({
    required this.notificationDetails,
    this.withNavigation = true,
    this.enabled = true,
    this.subTitle = '',
    this.title = '',
    this.onTap,
    this.dragIndex,
  });
}
