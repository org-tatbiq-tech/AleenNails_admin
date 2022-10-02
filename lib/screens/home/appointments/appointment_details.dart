import 'package:appointments/data_types/components.dart';
import 'package:appointments/data_types/macros.dart';
import 'package:appointments/providers/appointments_mgr.dart';
import 'package:appointments/utils/formats.dart';
import 'package:appointments/widget/appointment_service_card.dart';
import 'package:appointments/widget/custom_avatar.dart';
import 'package:appointments/widget/custom_status.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_loading-indicator.dart';
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
  final Appointment? appointment;
  final String? appointmentId;
  const AppointmentDetails({this.appointment, this.appointmentId, Key? key})
      : super(key: key);

  @override
  AppointmentDetailsState createState() => AppointmentDetailsState();
}

class AppointmentDetailsState extends State<AppointmentDetails> {
  @override
  void initState() {
    super.initState();
    final appointmentsMgr =
        Provider.of<AppointmentsMgr>(context, listen: false);
    if (widget.appointment != null) {
      appointmentsMgr.setSelectedAppointment(appointment: widget.appointment);
    } else {
      // download appointment via ID
      if (widget.appointmentId == null) {
        showErrorFlash(
            context: context,
            errorTitle: 'Could not load appointment details',
            errorBody: 'contact support');
        return;
      } else {
        appointmentsMgr.setSelectedAppointment(
            appointmentID: widget.appointmentId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    cancelAppointment() {
      showBottomModal(
        bottomModalProps: BottomModalProps(
          context: context,
          centerTitle: true,
          primaryButtonText: 'Cancel',
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

    renderAmount(Appointment appointment) {
      return FadeAnimation(
        positionType: PositionType.top,
        delay: 1.3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Total'.toUpperCase(),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  getStringPrice(10.6),
                  style: Theme.of(context).textTheme.headline1,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Due To'.toUpperCase(),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  getStringPrice(10.6),
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              EaseInAnimation(
                onTap: () => cancelAppointment(),
                child: CustomIcon(
                  customIconProps: CustomIconProps(
                    icon: null,
                    containerSize: rSize(50),
                    contentPadding: rSize(12),
                    withPadding: true,
                    borderColor: Theme.of(context).colorScheme.primary,
                    backgroundColor: Colors.transparent,
                    iconColor: Theme.of(context).colorScheme.error,
                    // backgroundColor: Colors.transparent,
                    path: 'assets/icons/cancel.png',
                  ),
                ),
              ),
              SizedBox(
                width: rSize(10),
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
              SizedBox(
                width: rSize(10),
              ),
              Expanded(
                child: CustomButton(
                  customButtonProps: CustomButtonProps(
                    onTap: () => {
                      Navigator.pushNamed(context, '/checkoutDetails'),
                    },
                    text: 'Checkout',
                    isPrimary: true,
                    isSecondary: false,
                  ),
                ),
              ),
            ],
          ));
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
                  height: rSize(10),
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
              appointment.notes ?? '',
              trimLines: 2,
            ),
          ],
        ),
      ]);
    }

    renderHeader(Appointment appointment) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FadeAnimation(
            delay: 0.1,
            child: CustomAvatar(
              customAvatarProps: CustomAvatarProps(
                radius: rSize(130),
                rectangleShape: false,
                enable: true,
                onTap: () => {
                  Navigator.pushNamed(context, '/clientDetails'),
                },
                circleShape: true,
                isMale: false,
              ),
            ),
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
          titleText: 'Appointment Details',
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
          builder: (context, appointmentsMgr, _) => !appointmentsMgr
                  .isSelectedAppointmentLoaded
              ? CustomLoadingIndicator(
                  customLoadingIndicatorProps: CustomLoadingIndicatorProps())
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FadeAnimation(
                      positionType: PositionType.bottom,
                      delay: 0.3,
                      child: CustomStatus(
                        customStatusProps: CustomStatusProps(
                            status: AppointmentStatus.waiting),
                      ),
                    ),
                    SizedBox(
                      height: rSize(10),
                    ),
                    FadeAnimation(
                      positionType: PositionType.bottom,
                      delay: 0.3,
                      child: renderAppointmentID(
                          appointmentsMgr.selectedAppointment),
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
                                  appointmentsMgr.selectedAppointment),
                            ),
                            SizedBox(
                              height: rSize(40),
                            ),
                            Expanded(
                              child: renderServices(
                                  appointmentsMgr.selectedAppointment),
                            ),
                            SizedBox(
                              height: rSize(20),
                            ),
                            renderAmount(appointmentsMgr.selectedAppointment),
                            SizedBox(
                              height: rSize(10),
                            ),
                            renderFooter(appointmentsMgr.selectedAppointment),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
