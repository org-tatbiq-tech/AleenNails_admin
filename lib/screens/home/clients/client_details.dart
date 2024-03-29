import 'dart:math';

import 'package:appointments/data_types/components.dart';
import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/clients_mgr.dart';
import 'package:appointments/screens/home/appointments/appointment.dart';
import 'package:appointments/screens/home/clients/client.dart';
import 'package:appointments/screens/home/clients/client_appointments.dart';
import 'package:appointments/widget/appointment/client_appointment_card.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_avatar.dart';
import 'package:common_widgets/custom_container.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_loading-indicator.dart';
import 'package:common_widgets/custom_text_button.dart';
import 'package:common_widgets/fade_animation.dart';
import 'package:common_widgets/read_more_text.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:common_widgets/utils/url_launch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClientDetails extends StatefulWidget {
  const ClientDetails({Key? key}) : super(key: key);

  @override
  State<ClientDetails> createState() => _ClientDetailsState();
}

class _ClientDetailsState extends State<ClientDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final clientsMgr = Provider.of<ClientsMgr>(context, listen: false);

    renderAppointments() {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeAnimation(
            positionType: PositionType.right,
            delay: 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${Languages.of(context)!.appointmentsLabel.toUpperCase()} (${clientsMgr.selectedClientAppointments.length.toString()})',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                CustomTextButton(
                  customTextButtonProps: CustomTextButtonProps(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ClientAppointments(),
                        ),
                      ),
                    },
                    text: Languages.of(context)!.showAllLabel.toTitleCase(),
                    textColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: rSize(10),
              );
            },
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.only(
              top: rSize(20),
            ),
            itemCount: min(clientsMgr.selectedClientAppointments.length, 1),
            itemBuilder: (context, index) {
              return FadeAnimation(
                positionType: PositionType.top,
                delay: 1 + index.toDouble() * 0.3,
                child: ClientAppointmentCard(
                  clientAppointmentCardProps: ClientAppointmentCardProps(
                    enabled: true,
                    withNavigation: true,
                    clientAppointmentDetails:
                        clientsMgr.selectedClientAppointments.toList()[index],
                  ),
                ),
              );
            },
          ),
        ],
      );
    }

    renderBirthday(Client client) {
      return Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
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
                    style: Theme.of(context).textTheme.bodyLarge,
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
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: rSize(5),
                  ),
                  child: Text(
                    Languages.of(context)!.blockedClientLabel.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Theme.of(context).colorScheme.error),
                  ),
                ),
                Text(
                  !(client.isApprovedByAdmin == true)
                      ? Languages.of(context)!.yesLabel.toTitleCase()
                      : Languages.of(context)!.noLabel.toTitleCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.error),
                ),
              ],
            ),
          ),
        ],
      );
    }

    renderLastVisit(Client client) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: rSize(5),
                  ),
                  child: Text(
                    Languages.of(context)!.lastVisitLabel.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
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
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: rSize(5),
                  ),
                  child: Text(
                    Languages.of(context)!.discountLabel.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Text(
                  '${client.discount}%',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ],
      );
    }

    renderTotalRevenue(Client client) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: rSize(5),
                  ),
                  child: Text(
                    Languages.of(context)!.totalRevenueLabel.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Text(
                  client.totalRevenue.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: rSize(5),
                  ),
                  child: Text(
                    Languages.of(context)!.trustedClientLabel.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Text(
                  client.isTrusted
                      ? Languages.of(context)!.yesLabel.toTitleCase()
                      : Languages.of(context)!.noLabel.toTitleCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
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
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            ReadMoreText(
              client.generalNotes!.isNotEmpty
                  ? client.generalNotes!
                  : Languages.of(context)!.notSetLabel.toTitleCase(),
              customTextStyle: Theme.of(context).textTheme.titleMedium,
              trimLines: 2,
            ),
          ],
        ),
      ]);
    }

    renderStatics(Client client) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground,
          border: Border.all(
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          borderRadius: BorderRadius.circular(
            rSize(10),
          ),
        ),
        height: rSize(65),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: rSize(4),
              direction: Axis.vertical,
              children: [
                Text(
                  Languages.of(context)!.appointmentsLabel.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  clientsMgr.selectedClientAppointments.length.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            VerticalDivider(
              endIndent: rSize(10),
              indent: rSize(10),
              thickness: rSize(1),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: rSize(4),
              direction: Axis.vertical,
              children: [
                Text(
                  Languages.of(context)!.cancellationLabel.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  clientsMgr.selectedClientCancelledAppointments.length
                      .toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            VerticalDivider(
              endIndent: rSize(10),
              indent: rSize(10),
              thickness: rSize(1),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: rSize(4),
              direction: Axis.vertical,
              children: [
                Text(
                  Languages.of(context)!.finishedLabel.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  clientsMgr.selectedClientFinishedAppointments.length
                      .toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            VerticalDivider(
              endIndent: rSize(10),
              indent: rSize(10),
              thickness: rSize(1),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: rSize(4),
              direction: Axis.vertical,
              children: [
                Text(
                  Languages.of(context)!.noShowLabel.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
                Text(
                  clientsMgr.selectedClientNoShowAppointments.length.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
              ],
            ),
          ],
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
          SizedBox(
            width: rSize(10),
          ),
          CustomIcon(
            customIconProps: CustomIconProps(
              isDisabled: false,
              onTap: () => sendMail(client.email),
              icon: Icon(
                Icons.email,
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
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppointmentScreen(client: client),
                  ),
                ),
              },
              iconColor: Theme.of(context).colorScheme.primary,
              withPadding: true,
              path: 'assets/icons/calendar_plus_full.png',
              icon: null,
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
          FadeAnimation(
            delay: 0.1,
            child: CustomAvatar(
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
          ),
          SizedBox(
            width: rSize(20),
          ),
          FadeAnimation(
            delay: 0.1,
            positionType: PositionType.left,
            child: Column(
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
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  client.phone,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  client.email,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  height: rSize(20),
                ),
                FadeAnimation(
                  positionType: PositionType.bottom,
                  delay: 0.4,
                  child: renderActions(client),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget renderDetailsBody() {
      final clientsMgr = Provider.of<ClientsMgr>(context, listen: false);
      return SafeArea(
        left: false,
        right: false,
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: rSize(20),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: rSize(30),
              ),
              child: Column(
                children: [
                  renderHeader(clientsMgr.selectedClient!),
                  SizedBox(
                    height: rSize(24),
                  ),
                  FadeAnimation(
                    positionType: PositionType.top,
                    delay: 0.5,
                    child: renderStatics(clientsMgr.selectedClient!),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: rSize(50),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: rSize(30),
                    ),
                    FadeAnimation(
                      positionType: PositionType.right,
                      delay: 0.6,
                      child: renderBirthday(clientsMgr.selectedClient!),
                    ),
                    SizedBox(
                      height: rSize(15),
                    ),
                    FadeAnimation(
                      positionType: PositionType.right,
                      delay: 0.7,
                      child: renderLastVisit(clientsMgr.selectedClient!),
                    ),
                    SizedBox(
                      height: rSize(15),
                    ),
                    FadeAnimation(
                      positionType: PositionType.right,
                      delay: 0.7,
                      child: renderTotalRevenue(clientsMgr.selectedClient!),
                    ),
                    SizedBox(
                      height: rSize(15),
                    ),
                    FadeAnimation(
                      positionType: PositionType.right,
                      delay: 0.8,
                      child: renderNotes(clientsMgr.selectedClient!),
                    ),
                    SizedBox(
                      height: rSize(20),
                    ),
                    renderAppointments(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Consumer<ClientsMgr>(
      builder: (context, clientsMgr, _) {
        return CustomContainer(
          imagePath: 'assets/images/background4.png',
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(
              customAppBarProps: CustomAppBarProps(
                titleText: Languages.of(context)!.clientDetailsLabel,
                withBack: true,
                isTransparent: true,
                customIcon: Icon(
                  Icons.edit,
                  size: rSize(24),
                ),
                customIconTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ClientWidget(client: clientsMgr.selectedClient),
                    ),
                  )
                },
              ),
            ),
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: !clientsMgr.isSelectedClientLoaded
                  ? Center(
                      child: CustomLoadingIndicator(
                        customLoadingIndicatorProps:
                            CustomLoadingIndicatorProps(),
                      ),
                    )
                  : renderDetailsBody(),
            ),
          ),
        );
      },
    );
  }
}
