import 'package:appointments/data_types/components.dart';
import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/clients_mgr.dart';
import 'package:appointments/providers/theme_provider.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_avatar.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_container.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_loading-indicator.dart';
import 'package:common_widgets/custom_loading_dialog.dart';
import 'package:common_widgets/custom_modal.dart';
import 'package:common_widgets/read_more_text.dart';
import 'package:common_widgets/utils/flash_manager.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:common_widgets/utils/url_launch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_mgr.dart';
import '../../../providers/notifications_mgr.dart';

class ApprovalRequest extends StatefulWidget {
  const ApprovalRequest({Key? key}) : super(key: key);

  @override
  State<ApprovalRequest> createState() => _ApprovalRequestState();
}

class _ApprovalRequestState extends State<ApprovalRequest> {
  @override
  Widget build(BuildContext context) {
    clientUpdatedSuccessfullyMessage() {
      Navigator.pop(context);
      showSuccessFlash(
        successColor: successPrimaryColor,
        context: context,
        successTitle: Languages.of(context)!.flashMessageSuccessTitle,
        successBody: Languages.of(context)!.clientUpdatedSuccessfullyBody,
      );
      Navigator.pop(context);
    }

    approveClient(Client client) async {
      showLoaderDialog(context);
      final clientsMgr = Provider.of<ClientsMgr>(context, listen: false);
      final notificationsMgr =
          Provider.of<NotificationsMgr>(context, listen: false);
      final authMgr = Provider.of<AuthenticationMgr>(context, listen: false);
      await clientsMgr.updateClientApproval(client.id, true);
      clientUpdatedSuccessfullyMessage();
      // delete notification
      await notificationsMgr.deleteNotification(
          notificationsMgr.selectedNotificationId,
          authMgr.getLoggedInAdminEmail());
    }

    rejectClient(Client client) async {
      showLoaderDialog(context);
      final clientsMgr = Provider.of<ClientsMgr>(context, listen: false);
      final notificationsMgr =
          Provider.of<NotificationsMgr>(context, listen: false);
      final authMgr = Provider.of<AuthenticationMgr>(context, listen: false);
      await clientsMgr.updateClientApproval(client.id, false);
      clientUpdatedSuccessfullyMessage();
      // delete notification
      await notificationsMgr.deleteNotification(
          notificationsMgr.selectedNotificationId,
          authMgr.getLoggedInAdminEmail());
    }

    showRejectClientModal(Client client) {
      showBottomModal(
        bottomModalProps: BottomModalProps(
          context: context,
          centerTitle: true,
          primaryButtonText: Languages.of(context)!.rejectLabel.toCapitalized(),
          secondaryButtonText: Languages.of(context)!.backLabel.toCapitalized(),
          deleteCancelModal: true,
          primaryAction: () => {
            rejectClient(client),
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

    renderActions(Client client) {
      return Row(
        children: [
          CustomIcon(
            customIconProps: CustomIconProps(
              isDisabled: false,
              onTap: () => makePhoneCall(client.phone),
              icon: Icon(
                Icons.phone,
                size: rSize(24),
              ),
            ),
          ),
          SizedBox(
            width: rSize(10),
          ),
          CustomIcon(
            customIconProps: CustomIconProps(
              isDisabled: false,
              onTap: () => sendSms(client.phone),
              icon: Icon(
                Icons.message,
                size: rSize(24),
              ),
            ),
          ),
        ],
      );
    }

    renderHeader(Client client) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAvatar(
            customAvatarProps: CustomAvatarProps(
              radius: rSize(90),
              editable: false,
              circleShape: false,
              rectangleShape: true,
              enable: false,
              defaultImage: const AssetImage(
                'assets/images/avatar_female.png',
              ),
              imageUrl: client.imageURL,
            ),
          ),
          SizedBox(
            width: rSize(20),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: rSize(5),
              ),
              Text(
                client.fullName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                client.phone,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                client.email,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: rSize(10),
              ),
              renderActions(client),
            ],
          ),
        ],
      );
    }

    renderNotes(Client client) {
      return Column(children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: rSize(5),
              ),
              child: Text(
                Languages.of(context)!.notesLabel.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            ReadMoreText(
              client.generalNotes != null && client.generalNotes!.isNotEmpty
                  ? client.generalNotes!
                  : Languages.of(context)!.notSetLabel.toTitleCase(),
              customTextStyle: Theme.of(context).textTheme.bodyText2,
              trimLines: 2,
            ),
          ],
        ),
      ]);
    }

    renderBirthday(Client client) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: rSize(5),
            ),
            child: Text(
              Languages.of(context)!.birthdayLabel.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Text(
            client.birthday != null
                ? Localizations.of<MaterialLocalizations>(
                        context, MaterialLocalizations)!
                    .formatCompactDate(client.birthday!)
                : Languages.of(context)!.notSetLabel.toTitleCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      );
    }

    renderFooter(Client client) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: CustomButton(
              customButtonProps: CustomButtonProps(
                onTap: () => approveClient(client),
                text: Languages.of(context)!.approveLabel,
                isPrimary: true,
                verticalPadding: rSize(8),
              ),
            ),
          ),
          SizedBox(
            width: rSize(40),
          ),
          Expanded(
            child: CustomButton(
              customButtonProps: CustomButtonProps(
                onTap: () => showRejectClientModal(client),
                text: Languages.of(context)!.rejectLabel,
                backgroundColor: Theme.of(context).colorScheme.error,
                textColor: Theme.of(context).colorScheme.onError,
                verticalPadding: rSize(8),
              ),
            ),
          ),
        ],
      );
    }

    return Consumer<ClientsMgr>(builder: (consumerContext, clientsMgr, _) {
      return CustomContainer(
        imagePath: 'assets/images/background4.png',
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CustomAppBar(
            customAppBarProps: CustomAppBarProps(
              titleText:
                  Languages.of(context)!.approvalRequestLabel.toTitleCase(),
              withClipPath: false,
              isTransparent: true,
              withBack: true,
              centerTitle: WrapAlignment.start,
            ),
          ),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: clientsMgr.isSelectedClientLoaded
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: rSize(30),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: rSize(40),
                        ),
                        renderHeader(clientsMgr.selectedClient),
                        SizedBox(
                          height: rSize(20),
                        ),
                        renderBirthday(clientsMgr.selectedClient),
                        SizedBox(
                          height: rSize(20),
                        ),
                        renderNotes(clientsMgr.selectedClient),
                        const Expanded(
                          child: SizedBox(),
                        ),
                        renderFooter(clientsMgr.selectedClient),
                      ],
                    ),
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
    });
  }
}
