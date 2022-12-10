import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/notifications_mgr.dart';
import 'package:common_widgets/custom_container.dart';
import 'package:appointments/widget/notification_card.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_loading-indicator.dart';
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
  @override
  void initState() {
    final notificationsMgr =
        Provider.of<NotificationsMgr>(context, listen: false);
    notificationsMgr.getNotifications('saeed.isa90@gmail.com');
    super.initState();
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
              ),
            ),
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: notificationsMgr.initialized
                  ? Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            child: notificationsMgr
                                    .getNotifications('saeed.isa90@gmail.com')
                                    .isNotEmpty
                                ? ListView.builder(
                                    padding: EdgeInsets.symmetric(
                                      vertical: rSize(40),
                                      horizontal: rSize(30),
                                    ),
                                    itemCount: notificationsMgr
                                        .getNotifications(
                                            'saeed.isa90@gmail.com')
                                        .length,
                                    itemBuilder: (context, index) {
                                      return NotificationCard(
                                        key: ValueKey(notificationsMgr
                                            .getNotifications(
                                                'saeed.isa90@gmail.com')[index]
                                            .id),
                                        notificationCardProps:
                                            NotificationCardProps(
                                          withNavigation: true,
                                          notificationDetails:
                                              notificationsMgr.getNotifications(
                                                      'saeed.isa90@gmail.com')[
                                                  index],
                                        ),
                                      );
                                    },
                                  )
                                : EmptyListImage(
                                    emptyListImageProps: EmptyListImageProps(
                                      title: 'No Notifications',
                                      iconPath: 'assets/icons/menu.png',
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: CustomLoadingIndicator(
                        customLoadingIndicatorProps:
                            CustomLoadingIndicatorProps(),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
