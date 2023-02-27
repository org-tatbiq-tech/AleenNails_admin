import 'package:appointments/data_types/macros.dart';
import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/theme_provider.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';

class AppointmentStatusComp extends StatelessWidget {
  final CustomStatusProps customStatusProps;
  const AppointmentStatusComp({
    Key? key,
    required this.customStatusProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: lighten(
          customStatusProps.paymentStatus != null
              ? getPaymentStatusColor(customStatusProps.paymentStatus!)
              : getAppointmentStatusColor(customStatusProps.appointmentStatus!),
          0.22,
        ),
        borderRadius: BorderRadius.circular(
          rSize(customStatusProps.fontSize / 1.5),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: rSize(customStatusProps.fontSize / 1.1),
          vertical: rSize(customStatusProps.fontSize / 2),
        ),
        child: Text(
          customStatusProps.appointmentStatus != null
              ? getAppointmentStatusText(
                      customStatusProps.appointmentStatus!, context)
                  .toUpperCase()
              : getPaymentStatusText(customStatusProps.paymentStatus!, context)
                  .toUpperCase(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: rSize(customStatusProps.fontSize),
                color: customStatusProps.appointmentStatus != null
                    ? getAppointmentStatusColor(
                        customStatusProps.appointmentStatus!,
                      )
                    : getPaymentStatusColor(customStatusProps.paymentStatus!),
              ),
        ),
      ),
    );
  }
}

getAppointmentStatusColor(AppointmentStatus status) {
  switch (status) {
    case AppointmentStatus.confirmed:
      return successPrimaryColor;
    case AppointmentStatus.finished:
      return successPrimaryColor;
    case AppointmentStatus.cancelled:
      return errorPrimaryColor;
    case AppointmentStatus.declined:
      return errorPrimaryColor;
    case AppointmentStatus.waiting:
      return warningPrimaryColor;
    case AppointmentStatus.noShow:
      return errorPrimaryColor;
    default:
      return informationPrimaryColor;
  }
}

String getAppointmentStatusText(
    AppointmentStatus status, BuildContext context) {
  switch (status) {
    case AppointmentStatus.confirmed:
      return Languages.of(context)!.confirmedLabel;
    case AppointmentStatus.finished:
      return Languages.of(context)!.finishedLabel;
    case AppointmentStatus.cancelled:
      return Languages.of(context)!.cancelledLabel;
    case AppointmentStatus.declined:
      return Languages.of(context)!.declinedLabel;
    case AppointmentStatus.waiting:
      return Languages.of(context)!.waitingLabel;
    case AppointmentStatus.noShow:
      return Languages.of(context)!.noShowLabel;
    default:
      return Languages.of(context)!.waitingLabel;
  }
}

getPaymentStatusColor(PaymentStatus status) {
  switch (status) {
    case PaymentStatus.paid:
      return successPrimaryColor;
    case PaymentStatus.unpaid:
      return warningPrimaryColor;
    default:
      return informationPrimaryColor;
  }
}

String getPaymentStatusText(PaymentStatus status, BuildContext context) {
  switch (status) {
    case PaymentStatus.paid:
      return Languages.of(context)!.paidLabel;
    case PaymentStatus.unpaid:
      return Languages.of(context)!.unpaidLabel;
    default:
      return Languages.of(context)!.unpaidLabel;
  }
}

class CustomStatusProps {
  AppointmentStatus? appointmentStatus;
  PaymentStatus? paymentStatus;
  double fontSize;
  CustomStatusProps({
    this.appointmentStatus,
    this.paymentStatus,
    this.fontSize = 16,
  });
}
