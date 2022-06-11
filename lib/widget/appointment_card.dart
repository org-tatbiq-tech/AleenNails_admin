import 'package:appointments/data_types/components.dart';
import 'package:appointments/utils/date.dart';
import 'package:appointments/utils/input_validation.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_list_tile.dart';
import 'package:appointments/widget/custom_status.dart';
import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentCardProps appointmentCardProps;
  const AppointmentCard({
    Key? key,
    required this.appointmentCardProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    appointmentServices() {
      List<Widget> widgetList = appointmentCardProps.appointmentDetails.services
          .map((AppointmentService service) {
        return Container(
          margin: EdgeInsets.symmetric(
            vertical: rSize(5),
          ),
          height: rSize(18),
          child: Row(
            children: [
              VerticalDivider(
                color: Theme.of(context).colorScheme.primary,
                width: rSize(2),
                thickness: rSize(2),
              ),
              SizedBox(
                width: rSize(10),
              ),
              Text(
                service.name ?? 'Service Name',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
        );
      }).toList();

      return widgetList;
    }

    return CustomListTile(
      customListTileProps: CustomListTileProps(
        enabled: appointmentCardProps.enabled,
        onTap: appointmentCardProps.onTap ??
            () => Navigator.pushNamed(context, '/appointmentDetails'),
        title: Padding(
          padding: EdgeInsets.only(bottom: rSize(5)),
          child: CustomStatus(
            customStatusProps: CustomStatusProps(
              status: appointmentCardProps.appointmentDetails.status,
              fontSize: 8,
            ),
          ),
        ),
        subTitle: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: appointmentServices(),
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
                    appointmentCardProps.appointmentDetails.totalCost,
                  ),
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        fontSize: rSize(16),
                      ),
                ),
                SizedBox(
                  width: rSize(5),
                ),
                appointmentCardProps.withNavigation
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
        leading: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              getDateTimeFormat(
                  dateTime: appointmentCardProps.appointmentDetails.date,
                  format: 'EEEE',
                  isDayOfWeek: true),
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: rSize(5),
            ),
            Text(
              getDateTimeFormat(
                  dateTime: appointmentCardProps.appointmentDetails.date,
                  format: 'dd'),
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontSize: rSize(18),
                  ),
            ),
            SizedBox(
              height: rSize(2),
            ),
            Text(
              getDateTimeFormat(
                  dateTime: appointmentCardProps.appointmentDetails.date,
                  format: 'HH:mm'),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentCardProps {
  final Appointment appointmentDetails;
  final bool withNavigation;
  final bool enabled;
  final Function? onTap;
  double height;

  AppointmentCardProps({
    required this.appointmentDetails,
    this.withNavigation = true,
    this.enabled = true,
    this.onTap,
    this.height = 100,
  });
}
