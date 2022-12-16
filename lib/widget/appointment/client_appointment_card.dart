import 'package:appointments/data_types/components.dart';
import 'package:appointments/providers/appointments_mgr.dart';
import 'package:appointments/screens/home/appointments/appointment_details.dart';
import 'package:appointments/utils/general.dart';
import 'package:appointments/widget/appointment/appointment_status.dart';
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

    appointmentServices(List<String> services) {
      List<Widget> widgetList = services.map((String service) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: rSize(5),
          ),
          child: Expanded(
            child: Text(
              service,
              style: Theme.of(context).textTheme.subtitle2,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }).toList();

      return widgetList;
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
                  clientAppointmentCardProps
                      .clientAppointmentDetails.appointmentIdRef,
                ),
        title: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: appointmentServices(
              clientAppointmentCardProps.clientAppointmentDetails.services),
        ),
        // title: Text(
        //   getAppointmentName(
        //       clientAppointmentCardProps.clientAppointmentDetails.services),
        //   style: Theme.of(context).textTheme.subtitle2,
        //   maxLines: 2,
        //   overflow: TextOverflow.ellipsis,
        // ),
        // subTitle: Text(
        //   '${getDateTimeFormat(
        //     dateTime:
        //         clientAppointmentCardProps.clientAppointmentDetails.startTime,
        //     format: 'HH:mm',
        //     locale: getCurrentLocale(context),
        //   )} - ${getDateTimeFormat(
        //     dateTime:
        //         clientAppointmentCardProps.clientAppointmentDetails.endTime,
        //     format: 'HH:mm',
        //     locale: getCurrentLocale(context),
        //   )}',
        //   style: Theme.of(context).textTheme.subtitle1,
        // ),
        subTitle: null,
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
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppointmentStatusComp(
                      customStatusProps: CustomStatusProps(
                        appointmentStatus: clientAppointmentCardProps
                            .clientAppointmentDetails.status,
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(
                      height: rSize(5),
                    ),
                    Text(
                      getStringPrice(
                        clientAppointmentCardProps
                            .clientAppointmentDetails.totalCost,
                      ),
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontSize: rSize(14),
                          ),
                    ),
                    Text(
                      '${getDateTimeFormat(
                        dateTime: clientAppointmentCardProps
                            .clientAppointmentDetails.startTime,
                        locale: getCurrentLocale(context),
                      )} - ${getDateTimeFormat(
                        dateTime: clientAppointmentCardProps
                            .clientAppointmentDetails.endTime,
                        locale: getCurrentLocale(context),
                      )}',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                SizedBox(
                  width: rSize(5),
                ),
                Visibility(
                  visible: clientAppointmentCardProps.withNavigation,
                  child: IconTheme(
                    data: Theme.of(context).primaryIconTheme,
                    child: Icon(
                      Icons.chevron_right,
                      size: rSize(25),
                    ),
                  ),
                ),
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
