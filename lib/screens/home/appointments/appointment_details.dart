import 'package:appointments/data_types/components.dart';
import 'package:appointments/data_types/macros.dart';
import 'package:appointments/providers/appointments_mgr.dart';
import 'package:appointments/providers/clients_mgr.dart';
import 'package:appointments/screens/home/clients/client_details.dart';
import 'package:appointments/screens/home/services/services.dart';
import 'package:appointments/utils/formats.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/appointment_service_card.dart';
import 'package:appointments/widget/custom_avatar.dart';
import 'package:appointments/widget/custom_status.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_loading-indicator.dart';
import 'package:common_widgets/custom_loading_dialog.dart';
import 'package:common_widgets/custom_modal.dart';
import 'package:common_widgets/ease_in_animation.dart';
import 'package:common_widgets/fade_animation.dart';
import 'package:common_widgets/read_more_text.dart';
import 'package:common_widgets/utils/date.dart';
import 'package:common_widgets/utils/flash_manager.dart';
import 'package:common_widgets/utils/input_validation.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AppointmentDetails extends StatefulWidget {
  const AppointmentDetails({Key? key}) : super(key: key);

  @override
  AppointmentDetailsState createState() => AppointmentDetailsState();
}

class AppointmentDetailsState extends State<AppointmentDetails> {
  bool isCheckoutScreen = false;
  @override
  Widget build(BuildContext context) {
    cancelAppointmentVisibility(Appointment appointment) {
      if (appointment.status == AppointmentStatus.cancelled) {
        return false;
      }
      if (appointment.paymentStatus == PaymentStatus.paid) {
        return false;
      }
      return true;
    }

    Future<ImageProvider<Object>?> getClientImage(String path) async {
      String imageUrl = '';
      if (path.isNotEmpty) {
        final clientsMgr = Provider.of<ClientsMgr>(context, listen: false);
        imageUrl = await clientsMgr.getClientImage(path);
      }
      if (imageUrl.isNotEmpty) {
        return CachedNetworkImageProvider(imageUrl);
      }
      return null;
    }

    cancelAppointmentClicked(Appointment appointment) {
      showLoaderDialog(context);
      final appointmentsMgr =
          Provider.of<AppointmentsMgr>(context, listen: false);
      appointment.status = AppointmentStatus.cancelled;
      appointmentsMgr.updateAppointment(appointment).then((value) => {
            Navigator.pop(context),
            showSuccessFlash(
              context: context,
              successColor: successPrimaryColor,
              successTitle: 'Success',
              successBody: 'Appointment Cancelled Successfully.',
            ),
          });
    }

    confirmCheckout(Appointment appointment) {
      showLoaderDialog(context);
      final appointmentsMgr =
          Provider.of<AppointmentsMgr>(context, listen: false);
      appointment.status = AppointmentStatus.confirmed;
      appointment.paymentStatus = PaymentStatus.paid;
      appointmentsMgr.updateAppointment(appointment).then((value) => {
            Navigator.pop(context),
            showSuccessFlash(
              context: context,
              successColor: successPrimaryColor,
              successTitle: 'Success',
              successBody: 'Checkout Successfully Confirmed.',
            ),
          });
    }

    cancelAppointment(Appointment appointment) {
      showBottomModal(
        bottomModalProps: BottomModalProps(
          context: context,
          centerTitle: true,
          primaryButtonText: 'Cancel',
          primaryAction: () => {cancelAppointmentClicked(appointment)},
          secondaryButtonText: 'Back',
          deleteCancelModal: true,
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
                'Cancel this appointment?',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                'Action can not be undone',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
      );
    }

    addAnotherService() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Services(
            selectionMode: true,
            onTap: () => {Navigator.pop(context)},
          ),
        ),
      );
    }

    renderAmount(Appointment appointment) {
      return FadeAnimation(
        positionType: PositionType.top,
        delay: 1.3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Visibility(
              visible: isCheckoutScreen,
              child: Row(
                children: [
                  EaseInAnimation(
                    onTap: () => {
                      addAnotherService(),
                    },
                    child: CustomIcon(
                      customIconProps: CustomIconProps(
                        iconColor: Theme.of(context).colorScheme.primary,
                        icon: null,
                        contentPadding: rSize(10),
                        withPadding: true,
                        path: 'assets/icons/plus.png',
                        containerSize: 35,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: rSize(10),
                  ),
                  Text(
                    'Add Service',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    width: rSize(20),
                  ),
                  EaseInAnimation(
                    onTap: () => {
                      Navigator.pushNamed(context, '/discountSelection'),
                    },
                    child: CustomIcon(
                      customIconProps: CustomIconProps(
                        iconColor: Theme.of(context).colorScheme.primary,
                        icon: null,
                        withPadding: true,
                        path: 'assets/icons/percent.png',
                        containerSize: 35,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: rSize(10),
                  ),
                  Text(
                    'Discount',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Total'.toUpperCase(),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  getStringPrice(appointment.totalCost),
                  style: Theme.of(context).textTheme.headline1,
                ),
              ],
            ),
          ],
        ),
      );
    }

    renderFooter(Appointment appointment) {
      return FadeAnimation(
        positionType: PositionType.top,
        delay: 1,
        child: AnimatedSwitcher(
          reverseDuration: const Duration(milliseconds: 400),
          duration: const Duration(milliseconds: 400),
          child: isCheckoutScreen
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: CustomButton(
                        customButtonProps: CustomButtonProps(
                          onTap: () => setState(() {
                            isCheckoutScreen = false;
                          }),
                          text: 'Back',
                          isPrimary: false,
                          isSecondary: true,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(
                            width: rSize(10),
                          ),
                          Expanded(
                            child: CustomButton(
                              customButtonProps: CustomButtonProps(
                                onTap: () => {
                                  confirmCheckout(appointment),
                                },
                                text: 'Confirm',
                                isPrimary: true,
                                isSecondary: false,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Visibility(
                      visible: cancelAppointmentVisibility(appointment),
                      child: Row(
                        children: [
                          EaseInAnimation(
                            onTap: () => cancelAppointment(appointment),
                            child: CustomIcon(
                              customIconProps: CustomIconProps(
                                icon: null,
                                containerSize: rSize(50),
                                contentPadding: rSize(12),
                                withPadding: true,
                                borderColor:
                                    Theme.of(context).colorScheme.primary,
                                backgroundColor: Colors.transparent,
                                iconColor: Theme.of(context).colorScheme.error,
                                path: 'assets/icons/cancel.png',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: rSize(10),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        customButtonProps: CustomButtonProps(
                          onTap: () => {},
                          text: 'Book Again',
                          isPrimary: false,
                          isSecondary: true,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: cancelAppointmentVisibility(appointment),
                      child: Expanded(
                        child: Row(
                          children: [
                            SizedBox(
                              width: rSize(10),
                            ),
                            Expanded(
                              child: CustomButton(
                                customButtonProps: CustomButtonProps(
                                  onTap: () => setState(() {
                                    isCheckoutScreen = true;
                                  }),
                                  text: 'Checkout',
                                  isPrimary: true,
                                  isSecondary: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      );
    }

    Widget renderAppointmentID(Appointment appointment) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'ID: ${appointment.id}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: rSize(4),
            ),
            child: Icon(
              Icons.circle,
              size: rSize(6),
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
          Text(
            appointment.creator,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      );
    }

    renderServices(Appointment appointment) {
      String servicesLength = appointment.services.length.toString();
      List<AppointmentService> services = appointment.services;
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeAnimation(
            positionType: PositionType.right,
            delay: 0.6,
            child: Text(
              'Services ($servicesLength)',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(
                top: rSize(20),
                left: rSize(20),
                right: rSize(20),
              ),
              itemCount: services.length,
              itemBuilder: (context, index) {
                return FadeAnimation(
                  positionType: PositionType.top,
                  delay: 0.8 + index.toDouble() * 0.3,
                  child: AppointmentServiceCard(
                    appointmentServiceCardProps: AppointmentServiceCardProps(
                      serviceDetails: services[index],
                      title: services[index].name,
                      subTitle:
                          '${getDateTimeFormat(dateTime: services[index].startTime, format: 'HH:mm')} - ${getDateTimeFormat(dateTime: services[index].endTime, format: 'HH:mm')} - ${durationToFormat(duration: services[index].duration)}',
                      withNavigation: false,
                      enabled: false,
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: rSize(15),
                );
              },
            ),
          ),
        ],
      );
    }

    String getAppointmentDate(Appointment appointment) {
      // Formatting appointment date
      return DateFormat('EE dd-MM-yyyy').format(appointment.date);
    }

    String getAppointmentTime(Appointment appointment) {
      // Formatting appointment - start time and end time
      return '${DateFormat('kk:mm').format(appointment.date)} - ${DateFormat('kk:mm').format(appointment.endTime)}';
    }

    renderDate(Appointment appointment) {
      return Column(children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeAnimation(
              delay: 0.3,
              positionType: PositionType.right,
              child: IconTheme(
                data: Theme.of(context).primaryIconTheme,
                child: CustomIcon(
                  customIconProps: CustomIconProps(
                    backgroundColor: Colors.transparent,
                    path: 'assets/icons/calendar_time.png',
                    icon: null,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: rSize(10),
            ),
            FadeAnimation(
              delay: 0.3,
              positionType: PositionType.left,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    // 'Wed 13/02/2022',
                    getAppointmentDate(appointment),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Text(
                    getAppointmentTime(appointment),
                    // '13:00 - 14:30',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ]);
    }

    renderNotes(Appointment appointment) {
      return Column(children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notes',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: rSize(5),
            ),
            ReadMoreText(
              appointment.notes.isEmpty
                  ? 'There is no notes.'
                  : appointment.notes,
              trimLines: 2,
            ),
          ],
        ),
      ]);
    }

    navigateToClientDetails(String clientID) {
      final clientsMgr = Provider.of<ClientsMgr>(context, listen: false);
      clientsMgr.setSelectedClient(clientID: clientID).then(
            (value) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ClientDetails(),
              ),
            ),
          );
    }

    renderHeader(Appointment appointment) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FadeAnimation(
            delay: 0.1,
            child: FutureBuilder<ImageProvider<Object>?>(
                future: getClientImage(appointment.clientImagePath),
                builder: (context, snapshot) {
                  return CustomAvatar(
                    customAvatarProps: CustomAvatarProps(
                      radius: rSize(110),
                      rectangleShape: true,
                      backgroundImage: snapshot.data,
                      isLoading:
                          snapshot.connectionState == ConnectionState.waiting,
                      enable: true,
                      onTap: () => {
                        navigateToClientDetails(appointment.clientDocID),
                      },
                      circleShape: false,
                      defaultImage: const AssetImage(
                        'assets/images/avatar_female.png',
                      ),
                    ),
                  );
                }),
          ),
          SizedBox(
            width: rSize(20),
          ),
          Wrap(
            direction: Axis.vertical,
            alignment: WrapAlignment.center,
            spacing: rSize(2),
            runSpacing: rSize(2),
            children: [
              FadeAnimation(
                delay: 0.1,
                positionType: PositionType.left,
                child: Text(
                  appointment.clientName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              FadeAnimation(
                delay: 0.1,
                positionType: PositionType.left,
                child: Text(
                  appointment.clientPhone,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              SizedBox(
                height: rSize(15),
              ),
              renderDate(appointment),
            ],
          ),
        ],
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText: isCheckoutScreen ? 'Checkout' : 'Appointment Details',
          withBack: true,
          barHeight: 110,
          withClipPath: true,
          customIcon: Icon(
            Icons.edit,
            size: rSize(24),
          ),
          customIconTap: () => {},
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        top: false,
        left: false,
        right: false,
        child: Consumer<AppointmentsMgr>(
          builder: (context, appointmentsMgr, _) => Visibility(
            visible: appointmentsMgr.isSelectedAppointmentLoaded,
            replacement: Center(
              child: CustomLoadingIndicator(
                customLoadingIndicatorProps: CustomLoadingIndicatorProps(),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeAnimation(
                  positionType: PositionType.bottom,
                  delay: 0.3,
                  child: CustomStatus(
                    customStatusProps: CustomStatusProps(
                      status: appointmentsMgr.selectedAppointment.status,
                    ),
                  ),
                ),
                SizedBox(
                  height: rSize(10),
                ),
                FadeAnimation(
                  positionType: PositionType.bottom,
                  delay: 0.3,
                  child:
                      renderAppointmentID(appointmentsMgr.selectedAppointment),
                ),
                SizedBox(
                  height: rSize(20),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: rSize(20),
                  ),
                  child: renderHeader(appointmentsMgr.selectedAppointment),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: rSize(30),
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
                          delay: 0.5,
                          child: renderNotes(
                            appointmentsMgr.selectedAppointment,
                          ),
                        ),
                        SizedBox(
                          height: rSize(40),
                        ),
                        Expanded(
                          child: renderServices(
                            appointmentsMgr.selectedAppointment,
                          ),
                        ),
                        SizedBox(
                          height: rSize(20),
                        ),
                        Visibility(
                          child: renderAmount(
                            appointmentsMgr.selectedAppointment,
                          ),
                        ),
                        SizedBox(
                          height: rSize(15),
                        ),
                        renderFooter(
                          appointmentsMgr.selectedAppointment,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
