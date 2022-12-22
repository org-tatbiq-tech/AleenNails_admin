import 'package:appointments/data_types/components.dart';
import 'package:appointments/data_types/macros.dart';
import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/appointments_mgr.dart';
import 'package:appointments/providers/auth_mgr.dart';
import 'package:appointments/providers/clients_mgr.dart';
import 'package:appointments/providers/langs.dart';
import 'package:appointments/providers/notifications_mgr.dart';
import 'package:appointments/providers/theme_provider.dart';
import 'package:appointments/screens/home/appointments/appointment_details.dart';
import 'package:appointments/screens/home/notification/approval_request.dart';
import 'package:common_widgets/custom_avatar.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_list_tile.dart';
import 'package:common_widgets/custom_loading_dialog.dart';
import 'package:common_widgets/custom_modal.dart';
import 'package:common_widgets/utils/date.dart';
import 'package:common_widgets/utils/flash_manager.dart';
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
    clientUpdatedSuccessfullyMessage() {
      showSuccessFlash(
        successColor: successPrimaryColor,
        context: context,
        successTitle: Languages.of(context)!.flashMessageSuccessTitle,
        successBody: Languages.of(context)!.clientUpdatedSuccessfullyBody,
      );
      Navigator.pop(context);
    }

    approveClient() async {
      showLoaderDialog(context);
      final notificationsMgr =
          Provider.of<NotificationsMgr>(context, listen: false);
      final authMgr = Provider.of<AuthenticationMgr>(context, listen: false);
      final clientsMgr = Provider.of<ClientsMgr>(context, listen: false);
      // approve client
      await clientsMgr.updateClientApproval(
          notificationCardProps.notificationDetails.data['client_id'], true);
      clientUpdatedSuccessfullyMessage();
      // delete notification
      await notificationsMgr.deleteNotification(
          notificationCardProps.notificationDetails.id,
          authMgr.getLoggedInAdminEmail());
    }

    rejectClient() async {
      showLoaderDialog(context);
      final notificationsMgr =
          Provider.of<NotificationsMgr>(context, listen: false);
      final authMgr = Provider.of<AuthenticationMgr>(context, listen: false);
      final clientsMgr = Provider.of<ClientsMgr>(context, listen: false);
      // deny client
      await clientsMgr.updateClientApproval(
          notificationCardProps.notificationDetails.data['client_id'], false);
      clientUpdatedSuccessfullyMessage();
      // delete notification
      await notificationsMgr.deleteNotification(
          notificationCardProps.notificationDetails.id,
          authMgr.getLoggedInAdminEmail());
    }

    getCurrentLocale(BuildContext context) {
      final localeMgr = Provider.of<LocaleData>(context, listen: false);
      return localeMgr.locale.languageCode;
    }

    showRejectClientModal() {
      showBottomModal(
        bottomModalProps: BottomModalProps(
          context: context,
          centerTitle: true,
          primaryButtonText: Languages.of(context)!.rejectLabel.toCapitalized(),
          secondaryButtonText: Languages.of(context)!.backLabel.toCapitalized(),
          deleteCancelModal: true,
          primaryAction: () => {
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
                  containerSize: 80,
                  contentPadding: 20,
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

    navigateTo(Widget screen) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => screen,
        ),
      );
    }

    onCardTap() async {
      final notificationsMgr =
          Provider.of<NotificationsMgr>(context, listen: false);
      final authMgr = Provider.of<AuthenticationMgr>(context, listen: false);
      final clientsMgr = Provider.of<ClientsMgr>(context, listen: false);
      final appointmentsMgr =
          Provider.of<AppointmentsMgr>(context, listen: false);
      await notificationsMgr.markNotificationOpened(
          notificationCardProps.notificationDetails.id,
          authMgr.getLoggedInAdminEmail());
      if (notificationCardProps.notificationDetails.data['category'] ==
          NotificationCategory.user) {
        await clientsMgr.setSelectedClient(
            clientID:
                notificationCardProps.notificationDetails.data['client_id']);
        navigateTo(const ApprovalRequest());
      } else {
        await appointmentsMgr.setSelectedAppointment(
            appointmentID: notificationCardProps
                .notificationDetails.data['appointment_id']);
        navigateTo(const AppointmentDetails());
      }
    }

    return Opacity(
      opacity: notificationCardProps.notificationDetails.isOpened ? 0.7 : 1,
      child: CustomListTile(
        customListTileProps: CustomListTileProps(
          marginBottom: 15,
          enabled: true,
          onTap: () => onCardTap(),
          title: Text(
            notificationCardProps.notificationDetails.notification['body'],
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
          leading: CustomAvatar(
            customAvatarProps: CustomAvatarProps(
              enable: false,
              circleShape: false,
              rectangleShape: true,
              imageUrl: notificationCardProps
                  .notificationDetails.data['client_image_url'],
              defaultImage: const AssetImage(
                'assets/images/avatar_female.png',
              ),
            ),
          ),
          secondPart: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: !notificationCardProps.notificationDetails.isOpened
                ? Container(
                    color: secondaryDark,
                    width: rSize(10),
                  )
                : null,
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
      ),
    );
  }
}

class NotificationCardProps {
  final NotificationData notificationDetails;

  NotificationCardProps({
    required this.notificationDetails,
  });
}
