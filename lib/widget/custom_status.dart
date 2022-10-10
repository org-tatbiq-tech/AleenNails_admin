import 'package:appointments/data_types/macros.dart';
import 'package:appointments/utils/layout.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';

class CustomStatus extends StatelessWidget {
  final CustomStatusProps customStatusProps;
  const CustomStatus({
    Key? key,
    required this.customStatusProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAppointmentStatusColor(AppointmentStatus status) {
      switch (status) {
        case AppointmentStatus.confirmed:
          return successPrimaryColor;
        case AppointmentStatus.cancelled:
          return errorPrimaryColor;
        case AppointmentStatus.declined:
          return errorPrimaryColor;
        case AppointmentStatus.waiting:
          return warningPrimaryColor;
        default:
          return informationPrimaryColor;
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
              ? customStatusProps.appointmentStatus!.name.toUpperCase()
              : customStatusProps.paymentStatus!.name.toUpperCase(),
          style: Theme.of(context).textTheme.headline1?.copyWith(
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
