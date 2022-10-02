import 'package:appointments/data_types/components.dart';
import 'package:common_widgets/custom_list_tile.dart';
import 'package:common_widgets/utils/date.dart';
import 'package:common_widgets/utils/input_validation.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';

class ClientAppointmentCard extends StatelessWidget {
  final ClientAppointmentCardProps clientAppointmentCardProps;
  const ClientAppointmentCard({
    Key? key,
    required this.clientAppointmentCardProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getAppointmentName() {
      String appointmentName = '';
      for (String serviceName
          in clientAppointmentCardProps.clientAppointmentDetails.services) {
        appointmentName += '$serviceName |';
      }
      return appointmentName;
    }

    return CustomListTile(
      customListTileProps: CustomListTileProps(
        enabled: clientAppointmentCardProps.enabled,
        onTap: clientAppointmentCardProps.onTap ??
            () => Navigator.pushNamed(context, '/appointmentDetails'),
        title: Text(
          getAppointmentName(),
        ),
        subTitle: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: rSize(10), vertical: rSize(5)),
          child: Text(
            '${getDateTimeFormat(
              dateTime:
                  clientAppointmentCardProps.clientAppointmentDetails.startTime,
              format: 'HH:mm',
            )} → ${getDateTimeFormat(
              dateTime:
                  clientAppointmentCardProps.clientAppointmentDetails.endTime,
              format: 'HH:mm',
            )}',
          ),
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  getStringPrice(
                    clientAppointmentCardProps
                        .clientAppointmentDetails.totalCost,
                  ),
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontSize: rSize(14),
                      ),
                ),
                SizedBox(
                  width: rSize(5),
                ),
                clientAppointmentCardProps.withNavigation
                    ? IconTheme(
                        data: Theme.of(context).primaryIconTheme,
                        child: Icon(
                          Icons.chevron_right,
                          size: rSize(25),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
        leading: Container(
          padding:
              EdgeInsets.symmetric(horizontal: rSize(10), vertical: rSize(5)),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: rSize(1),
            ),
            borderRadius: BorderRadius.circular(
              rSize(10),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                getDateTimeFormat(
                    dateTime: clientAppointmentCardProps
                        .clientAppointmentDetails.startTime,
                    format: 'EEE',
                    isDayOfWeek: true),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(fontSize: rSize(12)),
              ),
              SizedBox(
                height: rSize(5),
              ),
              Text(
                getDateTimeFormat(
                  dateTime: clientAppointmentCardProps
                      .clientAppointmentDetails.startTime,
                  format: 'dd',
                ),
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontSize: rSize(22),
                    ),
              ),
              SizedBox(
                height: rSize(2),
              ),
              Text(
                getDateTimeFormat(
                  dateTime: clientAppointmentCardProps
                      .clientAppointmentDetails.startTime,
                  format: 'yyyy',
                ),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(fontSize: rSize(12)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ClientAppointmentCardProps {
  final ClientAppointment clientAppointmentDetails;
  final bool withNavigation;
  final bool enabled;
  final Function? onTap;

  ClientAppointmentCardProps({
    required this.clientAppointmentDetails,
    this.withNavigation = true,
    this.enabled = true,
    this.onTap,
  });
}
