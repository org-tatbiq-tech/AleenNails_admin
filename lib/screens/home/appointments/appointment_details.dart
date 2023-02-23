import 'package:appointments/data_types/components.dart';
import 'package:appointments/data_types/macros.dart';
import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/appointments_mgr.dart';
import 'package:appointments/providers/clients_mgr.dart';
import 'package:appointments/providers/theme_provider.dart';
import 'package:appointments/screens/home/appointments/appointment.dart';
import 'package:appointments/screens/home/appointments/discount_selection.dart';
import 'package:appointments/screens/home/clients/client_details.dart';
import 'package:appointments/utils/general.dart';
import 'package:appointments/widget/appointment/appointment_service_card.dart';
import 'package:appointments/widget/appointment/appointment_status.dart';
import 'package:appointments/widget/appointment/checkout_completed.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_avatar.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_container.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_loading-indicator.dart';
import 'package:common_widgets/custom_loading_dialog.dart';
import 'package:common_widgets/custom_modal.dart';
import 'package:common_widgets/fade_animation.dart';
import 'package:common_widgets/page_transition.dart';
import 'package:common_widgets/read_more_text.dart';
import 'package:common_widgets/utils/date.dart';
import 'package:common_widgets/utils/flash_manager.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentDetails extends StatefulWidget {
  const AppointmentDetails({Key? key}) : super(key: key);

  @override
  AppointmentDetailsState createState() => AppointmentDetailsState();
}

class AppointmentDetailsState extends State<AppointmentDetails> {
  bool isCheckoutScreen = false;
  late AppointmentsMgr appointmentsMgr;
  late DiscountType discountType;
  late int discount;
  late double priceAfterDiscount;
  bool isLoading = true;

  @override
  void initState() {
    appointmentsMgr = Provider.of<AppointmentsMgr>(context, listen: false);
    prepareData();
    super.initState();
  }

  prepareData() async {
    await waitWhile(() => appointmentsMgr.isSelectedAppointmentLoaded == false);
    discountType = appointmentsMgr.selectedAppointment.discountType;
    discount = appointmentsMgr.selectedAppointment.discount;
    priceAfterDiscount = getPriceAfterDiscount();
    setState(() {
      isLoading = false;
    });
  }

  getPriceAfterDiscount() {
    if (discountType == DiscountType.percent) {
      return appointmentsMgr.selectedAppointment.servicesCost *
          (100 - discount) /
          100;
    } else {
      return appointmentsMgr.selectedAppointment.servicesCost - discount;
    }
  }

  @override
  void dispose() {
    appointmentsMgr.pauseSelectedAppointment();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isEditAppointment(AppointmentsMgr appointmentsMgr) {
      if (!appointmentsMgr.isSelectedAppointmentLoaded) {
        return true;
      }
      Appointment appointment = appointmentsMgr.selectedAppointment;
      if (appointment.status == AppointmentStatus.confirmed) {
        return true;
      }
      if (appointment.status == AppointmentStatus.waiting) {
        return true;
      }
      return false;
    }

    isCancelAppointmentVisible(Appointment appointment) {
      if (appointment.status == AppointmentStatus.confirmed) {
        return true;
      }
      return false;
    }

    bool isNoShowVisible(Appointment appointment) {
      if (appointment.date.isBefore(DateTime.now()) &&
          appointment.status == AppointmentStatus.confirmed) {
        return true;
      }
      return false;
    }

    bool isCheckoutVisible(Appointment appointment) {
      if (appointment.status == AppointmentStatus.confirmed) {
        return true;
      }
      return false;
    }

    bool isDeclineVisible(Appointment appointment) {
      if (appointment.date.isBefore(DateTime.now()) &&
          appointment.status == AppointmentStatus.waiting) {
        return true;
      }
      return false;
    }

    editAppointmentAction() {
      final appointmentsMgr =
          Provider.of<AppointmentsMgr>(context, listen: false);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AppointmentScreen(
            appointment: appointmentsMgr.selectedAppointment,
          ),
        ),
      );
    }

    bookAgainAction() {
      final appointmentsMgr =
          Provider.of<AppointmentsMgr>(context, listen: false);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AppointmentScreen(
            bookAgainAppointment: appointmentsMgr.selectedAppointment,
          ),
        ),
      );
    }

    cancelAppointmentMessage() {
      Navigator.pop(context);
      showSuccessFlash(
        context: context,
        successColor: successPrimaryColor,
        successTitle:
            Languages.of(context)!.flashMessageSuccessTitle.toTitleCase(),
        successBody: Languages.of(context)!
            .appointmentCancelledSuccessfullyBody
            .toCapitalized(),
      );
    }

    cancelAppointmentClicked(Appointment appointment) async {
      showLoaderDialog(context);
      final appointmentsMgr =
          Provider.of<AppointmentsMgr>(context, listen: false);
      appointment.status = AppointmentStatus.cancelled;
      await appointmentsMgr.updateAppointment(appointment);
      cancelAppointmentMessage();
    }

    navigateToCompleteCheckout() {
      Navigator.pop(context);
      Navigator.push(
        context,
        PageTransition(
          child: const CheckoutCompleted(),
          type: PageTransitionType.fade,
          isIos: false,
        ),
      );
    }

    confirmCheckout(Appointment appointment) async {
      showLoaderDialog(context);
      final appointmentsMgr =
          Provider.of<AppointmentsMgr>(context, listen: false);
      appointment.status = AppointmentStatus.finished;
      appointment.paymentStatus = PaymentStatus.paid;
      appointment.discount = discount;
      appointment.discountType = discountType;
      await appointmentsMgr.updateAppointment(appointment);
      setState(() {
        isCheckoutScreen = false;
      });
      navigateToCompleteCheckout();
    }

    confirmNoShow(Appointment appointment) {
      showLoaderDialog(context);
      final appointmentsMgr =
          Provider.of<AppointmentsMgr>(context, listen: false);
      appointment.status = AppointmentStatus.noShow;
      appointmentsMgr.updateAppointment(appointment).then(
            (value) => {
              Navigator.pop(context),
              showSuccessFlash(
                context: context,
                successColor: successPrimaryColor,
                successTitle: Languages.of(context)!
                    .flashMessageSuccessTitle
                    .toTitleCase(),
                successBody: Languages.of(context)!
                    .appointmentUpdatedSuccessfullyBody
                    .toCapitalized(),
              ),
              Navigator.pop(context),
            },
          );
    }

    confirmDecline(Appointment appointment) {
      showLoaderDialog(context);
      final appointmentsMgr =
          Provider.of<AppointmentsMgr>(context, listen: false);
      appointment.status = AppointmentStatus.declined;
      appointmentsMgr.updateAppointment(appointment).then(
            (value) => {
              Navigator.pop(context),
              showSuccessFlash(
                context: context,
                successColor: successPrimaryColor,
                successTitle: Languages.of(context)!
                    .flashMessageSuccessTitle
                    .toTitleCase(),
                successBody: Languages.of(context)!
                    .appointmentUpdatedSuccessfullyBody
                    .toCapitalized(),
              ),
              Navigator.pop(context),
            },
          );
    }

    noShowAppointment(Appointment appointment) {
      showBottomModal(
        bottomModalProps: BottomModalProps(
          context: context,
          centerTitle: true,
          primaryButtonText: Languages.of(context)!.noShowLabel.toUpperCase(),
          primaryAction: () => {confirmNoShow(appointment)},
          secondaryButtonText: Languages.of(context)!.backLabel.toUpperCase(),
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
                  containerSize: 80,
                  contentPadding: 20,
                ),
              ),
              SizedBox(
                height: rSize(30),
              ),
              Text(
                Languages.of(context)!.noShowLabel.toCapitalized(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                Languages.of(context)!.actionUndoneLabel.toCapitalized(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      );
    }

    declineAppointment(Appointment appointment) {
      showBottomModal(
        bottomModalProps: BottomModalProps(
          context: context,
          centerTitle: true,
          primaryButtonText: Languages.of(context)!.cancelLabel,
          primaryAction: () => {confirmDecline(appointment)},
          secondaryButtonText: Languages.of(context)!.backLabel.toUpperCase(),
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
                  containerSize: 80,
                  contentPadding: 20,
                ),
              ),
              SizedBox(
                height: rSize(30),
              ),
              Text(
                Languages.of(context)!
                    .cancelThisAppointmentLabel
                    .toCapitalized(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                Languages.of(context)!.actionUndoneLabel.toCapitalized(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      );
    }

    cancelAppointment(Appointment appointment) {
      showBottomModal(
        bottomModalProps: BottomModalProps(
          context: context,
          centerTitle: true,
          primaryButtonText: Languages.of(context)!.cancelLabel.toUpperCase(),
          primaryAction: () => {cancelAppointmentClicked(appointment)},
          secondaryButtonText: Languages.of(context)!.backLabel.toUpperCase(),
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
                  containerSize: 80,
                  contentPadding: 20,
                ),
              ),
              SizedBox(
                height: rSize(30),
              ),
              Text(
                Languages.of(context)!
                    .cancelThisAppointmentLabel
                    .toCapitalized(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                Languages.of(context)!.actionUndoneLabel.toCapitalized(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      );
    }

    navigateToDiscount(Appointment appointment) async {
      var res = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DiscountSelection(
            discountValue: discount.round(),
            discountType: discountType,
          ),
        ),
      );

      if (res == null) {
        return;
      }
      setState(() {
        discountType = res['type'];
        discount = res['discount'];
        priceAfterDiscount = getPriceAfterDiscount();
      });
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
                  CustomIcon(
                    customIconProps: CustomIconProps(
                      isDisabled: false,
                      onTap: () => {navigateToDiscount(appointment)},
                      iconColor: Theme.of(context).colorScheme.primary,
                      icon: null,
                      withPadding: true,
                      path: 'assets/icons/add_discount.png',
                      containerSize: 35,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: discount != 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          Languages.of(context)!.priceLabel.toUpperCase(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Row(
                          children: [
                            Text(
                              getStringPrice(
                                appointmentsMgr
                                    .selectedAppointment.servicesCost,
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    decorationThickness: rSize(4),
                                    decorationColor:
                                        Theme.of(context).colorScheme.primary,
                                    decorationStyle: TextDecorationStyle.wavy,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: discount != 0.0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          Languages.of(context)!.discountLabel.toUpperCase(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Row(
                          children: [
                            Text(
                              discountType == DiscountType.fixed
                                  ? getStringPrice(discount.toDouble())
                                  : '${discount.toStringAsFixed(1)} %',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  Languages.of(context)!.totalLabel.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  getStringPrice(priceAfterDiscount),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ],
        ),
      );
    }

    renderNoShow(Appointment appointment) {
      return FadeAnimation(
        positionType: PositionType.top,
        delay: 1.2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: CustomButton(
                customButtonProps: CustomButtonProps(
                  onTap: () => noShowAppointment(appointment),
                  text: Languages.of(context)!.noShowLabel.toUpperCase(),
                  isPrimary: true,
                  isSecondary: false,
                  backgroundColor: Theme.of(context).colorScheme.error,
                  textColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    }

    renderDecline(Appointment appointment) {
      return FadeAnimation(
        positionType: PositionType.top,
        delay: 1.2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: CustomButton(
                customButtonProps: CustomButtonProps(
                  onTap: () => declineAppointment(appointment),
                  text: Languages.of(context)!.noShowLabel.toUpperCase(),
                  isPrimary: true,
                  isSecondary: false,
                  backgroundColor: Theme.of(context).colorScheme.error,
                  textColor: Colors.white,
                ),
              ),
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
                            discount = appointment.discount;
                            discountType = appointment.discountType;
                            priceAfterDiscount = appointment.totalCost;
                          }),
                          text: Languages.of(context)!.backLabel.toUpperCase(),
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
                                text: Languages.of(context)!
                                    .confirmLabel
                                    .toUpperCase(),
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
                      visible: isCancelAppointmentVisible(appointment),
                      child: Row(
                        children: [
                          CustomIcon(
                            customIconProps: CustomIconProps(
                              isDisabled: false,
                              onTap: () => cancelAppointment(appointment),
                              icon: null,
                              containerSize: 50,
                              contentPadding: 12,
                              withPadding: true,
                              borderColor:
                                  Theme.of(context).colorScheme.primary,
                              backgroundColor: Colors.transparent,
                              iconColor: Theme.of(context).colorScheme.error,
                              path: 'assets/icons/cancel.png',
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
                          onTap: () => {bookAgainAction()},
                          text: Languages.of(context)!
                              .bookAgainLabel
                              .toTitleCase(),
                          isPrimary: false,
                          isSecondary: true,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isCheckoutVisible(appointment),
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
                                  text: Languages.of(context)!
                                      .checkoutLabel
                                      .toTitleCase(),
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
            '${Languages.of(context)!.idLabel.toUpperCase()}: ${appointment.id}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: rSize(4),
            ),
            child: Icon(
              Icons.circle,
              size: rSize(6),
              color: Theme.of(context).textTheme.titleMedium!.color,
            ),
          ),
          Text(
            appointment.creator == AppointmentCreator.business
                ? Languages.of(context)!.businessLabel.toTitleCase()
                : Languages.of(context)!.clientLabel.toTitleCase(),
            style: Theme.of(context).textTheme.bodyLarge,
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
              '${Languages.of(context)!.servicesLabel.toTitleCase()} ($servicesLength)',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
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
                      subTitle: '${getDateTimeFormat(
                        dateTime: services[index].startTime,
                        format: 'HH:mm',
                        locale: getCurrentLocale(context),
                      )} - ${getDateTimeFormat(
                        dateTime: services[index].endTime,
                        format: 'HH:mm',
                        locale: getCurrentLocale(context),
                      )} - ${durationToFormat(duration: services[index].duration)}',
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
                    iconColor: Theme.of(context).colorScheme.primary,
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
                    getDateTimeFormat(
                      dateTime: appointment.date,
                      format: 'EE dd-MM-yyyy',
                      locale: getCurrentLocale(context),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    '${getDateTimeFormat(
                      dateTime: appointment.date,
                      format: 'HH:mm',
                      locale: getCurrentLocale(context),
                    )} - ${getDateTimeFormat(
                      dateTime: appointment.endTime,
                      format: 'HH:mm',
                      locale: getCurrentLocale(context),
                    )}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
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
              Languages.of(context)!.notesLabel.toTitleCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: rSize(5),
            ),
            ReadMoreText(
              appointment.notes.isEmpty
                  ? Languages.of(context)!.notSetLabel.toCapitalized()
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
            child: CustomAvatar(
              customAvatarProps: CustomAvatarProps(
                radius: rSize(90),
                rectangleShape: true,
                imageUrl: appointment.clientImageURL,
                enable: true,
                onTap: () => {
                  navigateToClientDetails(appointment.clientDocID),
                },
                circleShape: false,
                defaultImage: const AssetImage(
                  'assets/images/avatar_female.png',
                ),
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
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              FadeAnimation(
                delay: 0.1,
                positionType: PositionType.left,
                child: Text(
                  appointment.clientPhone,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              SizedBox(
                height: rSize(5),
              ),
              renderDate(appointment),
            ],
          ),
        ],
      );
    }

    return CustomContainer(
      imagePath: 'assets/images/background4.png',
      child: Consumer<AppointmentsMgr>(
        builder: (context, appointmentsMgr, _) => Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CustomAppBar(
            customAppBarProps: CustomAppBarProps(
              titleText: isCheckoutScreen
                  ? Languages.of(context)!.checkoutLabel.toTitleCase()
                  : Languages.of(context)!
                      .appointmentDetailsLabel
                      .toTitleCase(),
              withBack: true,
              isTransparent: true,
              customIcon: isEditAppointment(appointmentsMgr)
                  ? Icon(
                      Icons.edit,
                      size: rSize(24),
                    )
                  : null,
              customIconTap: () => editAppointmentAction(),
            ),
          ),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: isLoading
                ? Center(
                    child: CustomLoadingIndicator(
                      customLoadingIndicatorProps:
                          CustomLoadingIndicatorProps(),
                    ),
                  )
                : SafeArea(
                    top: false,
                    left: false,
                    right: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: rSize(20),
                        ),
                        FadeAnimation(
                          positionType: PositionType.bottom,
                          delay: 0.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppointmentStatusComp(
                                customStatusProps: CustomStatusProps(
                                  appointmentStatus: appointmentsMgr
                                      .selectedAppointment.status,
                                ),
                              ),
                              SizedBox(
                                width: rSize(10),
                              ),
                              AppointmentStatusComp(
                                customStatusProps: CustomStatusProps(
                                  paymentStatus: appointmentsMgr
                                      .selectedAppointment.paymentStatus,
                                ),
                              ),
                            ],
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
                          child:
                              renderHeader(appointmentsMgr.selectedAppointment),
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
                                  height: rSize(20),
                                ),
                                FadeAnimation(
                                  positionType: PositionType.right,
                                  delay: 0.5,
                                  child: renderNotes(
                                    appointmentsMgr.selectedAppointment,
                                  ),
                                ),
                                SizedBox(
                                  height: rSize(15),
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
                                Visibility(
                                  visible: isNoShowVisible(appointmentsMgr
                                          .selectedAppointment) ||
                                      isDeclineVisible(
                                          appointmentsMgr.selectedAppointment),
                                  child: SizedBox(
                                    height: rSize(15),
                                  ),
                                ),
                                Visibility(
                                  visible: isNoShowVisible(
                                    appointmentsMgr.selectedAppointment,
                                  ),
                                  child: renderNoShow(
                                    appointmentsMgr.selectedAppointment,
                                  ),
                                ),
                                Visibility(
                                  visible: isDeclineVisible(
                                    appointmentsMgr.selectedAppointment,
                                  ),
                                  child: renderDecline(
                                    appointmentsMgr.selectedAppointment,
                                  ),
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
      ),
    );
  }
}
