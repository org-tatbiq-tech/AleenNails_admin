import 'package:appointments/data_types/components.dart';
import 'package:appointments/providers/appointments_mgr.dart';
import 'package:appointments/screens/home/appointments/appointment_details.dart';
import 'package:appointments/utils/general.dart';
import 'package:common_widgets/custom_list_tile.dart';
import 'package:common_widgets/utils/date.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClientAppointmentCard extends StatelessWidget {
  final ClientAppointmentCardProps clientAppointmentCardProps;
  const ClientAppointmentCard({
    Key? key,
    required this.clientAppointmentCardProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getAppointmentName(List<String> services) {
      String appointmentName = services[0];
      if (services.isNotEmpty && services.length > 1) {
        appointmentName += ' + More';
      }
      return appointmentName;
    }

    navigateToAppointmentDetails(String appointmentId) {
      final appointmentsMgr =
          Provider.of<AppointmentsMgr>(context, listen: false);
      appointmentsMgr.setSelectedAppointment(appointmentID: appointmentId);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AppointmentDetails(),
        ),
      );
    }

    return CustomListTile(
      customListTileProps: CustomListTileProps(
        enabled: clientAppointmentCardProps.enabled,
        onTap: clientAppointmentCardProps.onTap ??
            () => navigateToAppointmentDetails(
                  clientAppointmentCardProps.clientAppointmentDetails.id,
                ),
        title: Text(
          getAppointmentName(
              clientAppointmentCardProps.clientAppointmentDetails.services),
          style: Theme.of(context).textTheme.subtitle2,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subTitle: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: rSize(10), vertical: rSize(5)),
          child: Text(
            '${getDateTimeFormat(
              dateTime:
                  clientAppointmentCardProps.clientAppointmentDetails.startTime,
              format: 'HH:mm',
              locale: getCurrentLocale(context),
            )} - ${getDateTimeFormat(
              dateTime:
                  clientAppointmentCardProps.clientAppointmentDetails.endTime,
              format: 'HH:mm',
              locale: getCurrentLocale(context),
            )}',
            style: Theme.of(context).textTheme.subtitle2,
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
                  isDayOfWeek: true,
                  locale: getCurrentLocale(context),
                ),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(fontSize: rSize(12)),
              ),
              Text(
                getDateTimeFormat(
                  dateTime: clientAppointmentCardProps
                      .clientAppointmentDetails.startTime,
                  format: 'dd',
                  locale: getCurrentLocale(context),
                ),
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontSize: rSize(22),
                    ),
              ),
              Text(
                getDateTimeFormat(
                  dateTime: clientAppointmentCardProps
                      .clientAppointmentDetails.startTime,
                  format: 'yyyy',
                  locale: getCurrentLocale(context),
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
