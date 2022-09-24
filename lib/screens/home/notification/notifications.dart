import 'package:appointments/data_types/components.dart';
import 'package:appointments/widget/notification_card.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/empty_list_image.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<NotificationData> notifications = [
    NotificationData(
      'id',
      'Here will be the description of the notification',
      DateTime.now(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(
      //   customAppBarProps: CustomAppBarProps(
      //     titleText: 'Notifications',
      //     withBack: true,
      //     withClipPath: false,
      //     customIcon: Icon(
      //       Icons.refresh,
      //       size: rSize(24),
      //     ),
      //     customIconTap: () => {},
      //   ),
      // ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          notifications.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    vertical: rSize(40),
                    horizontal: rSize(30),
                  ),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return NotificationCard(
                      key: ValueKey(notifications[index].id),
                      notificationCardProps: NotificationCardProps(
                        withNavigation: true,
                        onTap: () => {},
                        notificationDetails: notifications[index],
                        title: notifications[index].description,
                        subTitle: notifications[index].creationDate.toString(),
                      ),
                    );
                  },
                ))
              : Padding(
                  padding: EdgeInsets.only(
                    top: rSize(250),
                  ),
                  child: EmptyListImage(
                    emptyListImageProps: EmptyListImageProps(
                      title: 'No Notifications',
                      iconPath: 'assets/icons/menu.png',
                      bottomWidgetPosition: 10,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}