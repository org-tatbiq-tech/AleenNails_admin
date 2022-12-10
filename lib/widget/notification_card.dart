import 'package:appointments/data_types/components.dart';
import 'package:appointments/data_types/macros.dart';
import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/appointments_mgr.dart';
import 'package:appointments/providers/clients_mgr.dart';
import 'package:appointments/providers/langs.dart';
import 'package:appointments/providers/theme_provider.dart';
import 'package:appointments/screens/home/appointments/appointment_details.dart';
import 'package:appointments/screens/home/notification/approval_request.dart';
import 'package:common_widgets/custom_avatar.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_list_tile.dart';
import 'package:common_widgets/custom_modal.dart';
import 'package:common_widgets/page_transition.dart';
import 'package:common_widgets/utils/date.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationCard extends StatelessWidget {
  final NotificationCardProps notificationCardProps;
  const NotificationCard({
    Key? key,
    required this.notificationCardProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    approveClient() async {}
    rejectClient() async {}

    getCurrentLocale(BuildContext context) {
      final localeMgr = Provider.of<LocaleData>(context, listen: false);
      return localeMgr.locale.languageCode;
    }

    showRejectClientModal() async {
      showBottomModal(
        bottomModalProps: BottomModalProps(
          context: context,
          centerTitle: true,
          primaryButtonText: Languages.of(context)!.rejectLabel.toCapitalized(),
          secondaryButtonText: Languages.of(context)!.backLabel.toCapitalized(),
          deleteCancelModal: true,
          primaryAction: () async => {
            rejectClient(),
          },
          footerButton: ModalFooter.both,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomIcon(
                customIconProps: CustomIconProps(
                  icon: null,
                  path: 'assets/icons/cancel.png',
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
                '${Languages.of(context)!.rejectClientLabel.toTitleCase()}?',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                Languages.of(context)!.actionUndoneLabel.toCapitalized(),
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
      );
    }

    onCardTap() async {
      if (notificationCardProps.notificationDetails.data['category'] ==
          NotificationCategory.user) {
        final clientsMgr = Provider.of<ClientsMgr>(context, listen: false);
        await clientsMgr.setSelectedClient(
            clientID:
                notificationCardProps.notificationDetails.data['client_id']);
        Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              isIos: isIos(),
              child: const ApprovalRequest()),
        );
      } else {
        final appointmentsMgr =
            Provider.of<AppointmentsMgr>(context, listen: false);
        await appointmentsMgr.setSelectedAppointment(
            appointmentID: notificationCardProps
                .notificationDetails.data['appointment_id']);
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            isIos: isIos(),
            child: const AppointmentDetails(),
          ),
        );
      }
    }

    return CustomListTile(
      customListTileProps: CustomListTileProps(
        marginBottom: 15,
        enabled: notificationCardProps.enabled,
        onTap: () => onCardTap(),
        title: Text(
          notificationCardProps.notificationDetails.notification['title'],
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        subTitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(top: rSize(5)),
              child: Text(
                getDateTimeFormat(
                  isDayOfWeek: true,
                  dateTime:
                      notificationCardProps.notificationDetails.creationDate,
                  format: 'dd MMM yyyy • HH:mm',
                  locale: getCurrentLocale(context),
                ),
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ],
        ),
        trailing: notificationCardProps.withNavigation
            ? IconTheme(
                data: Theme.of(context).primaryIconTheme,
                child: Icon(
                  Icons.chevron_right,
                  size: rSize(25),
                ),
              )
            : const SizedBox(),
        leading: Row(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: !notificationCardProps.notificationDetails.isOpened
                  ? Row(
                      children: [
                        CustomIcon(
                          customIconProps: CustomIconProps(
                            backgroundColor: Colors.transparent,
                            containerSize: rSize(15),
                            icon: Icon(
                              Icons.circle,
                              size: rSize(10),
                              color: secondaryDark,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: rSize(10),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
            CustomAvatar(
              customAvatarProps: CustomAvatarProps(
                enable: false,
                circleShape: true,
                defaultImage: const AssetImage(
                  'assets/images/avatar_female.png',
                ),
              ),
            )
          ],
        ),
        secondMain: notificationCardProps
                    .notificationDetails.data['category'] ==
                NotificationCategory.user
            ? Padding(
                padding: EdgeInsets.only(top: rSize(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                      customButtonProps: CustomButtonProps(
                        onTap: () => approveClient(),
                        text: Languages.of(context)!.approveLabel,
                        isPrimary: true,
                        verticalPadding: rSize(8),
                      ),
                    ),
                    CustomButton(
                      customButtonProps: CustomButtonProps(
                        onTap: () => showRejectClientModal(),
                        text: Languages.of(context)!.rejectLabel,
                        backgroundColor: Theme.of(context).colorScheme.error,
                        textColor: Theme.of(context).colorScheme.onError,
                        verticalPadding: rSize(8),
                      ),
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }
}

class NotificationCardProps {
  final NotificationData notificationDetails;
  final bool withNavigation;
  final bool enabled;

  NotificationCardProps({
    required this.notificationDetails,
    this.withNavigation = true,
    this.enabled = true,
  });
}
