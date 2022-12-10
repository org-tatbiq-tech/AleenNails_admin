import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/auth_mgr.dart';
import 'package:appointments/providers/notifications_mgr.dart';
import 'package:common_widgets/custom_container.dart';
import 'package:appointments/widget/notification_card.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/empty_list_image.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  late AuthenticationMgr authMgr;

  @override
  void initState() {
    super.initState();
    authMgr = Provider.of<AuthenticationMgr>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationsMgr>(
      builder: (consumerContext, notificationsMgr, _) {
        return CustomContainer(
          imagePath: 'assets/images/background4.png',
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(
              customAppBarProps: CustomAppBarProps(
                titleText:
                    Languages.of(context)!.labelNotification.toTitleCase(),
                withClipPath: false,
                isTransparent: true,
                centerTitle: WrapAlignment.start,
                customIcon: Icon(
                  Icons.refresh,
                  size: rSize(24),
                ),
                customIconTap: () => {},
              ),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                notificationsMgr
                        .getNotifications(authMgr.getLoggedInAdminEmail())
                        .isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                        padding: EdgeInsets.symmetric(
                          vertical: rSize(40),
                          horizontal: rSize(30),
                        ),
                        itemCount: notificationsMgr
                            .getNotifications(authMgr.getLoggedInAdminEmail())
                            .length,
                        itemBuilder: (context, index) {
                          return NotificationCard(
                            key: ValueKey(notificationsMgr
                                .getNotifications(
                                    authMgr.getLoggedInAdminEmail())[index]
                                .id),
                            notificationCardProps: NotificationCardProps(
                              withNavigation: true,
                              onTap: () => {},
                              notificationDetails:
                                  notificationsMgr.getNotifications(
                                      authMgr.getLoggedInAdminEmail())[index],
                              title: notificationsMgr
                                  .getNotifications(
                                      authMgr.getLoggedInAdminEmail())[index]
                                  .notification['title'],
                              subTitle: notificationsMgr
                                  .getNotifications(
                                      authMgr.getLoggedInAdminEmail())[index]
                                  .creationDate
                                  .toString(),
                            ),
                          );
                        },
                      ))
                    : Expanded(
                        child: EmptyListImage(
                          emptyListImageProps: EmptyListImageProps(
                            title: 'No Notifications',
                            iconPath: 'assets/icons/menu.png',
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
