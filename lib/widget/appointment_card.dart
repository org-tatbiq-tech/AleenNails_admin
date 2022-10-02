import 'package:appointments/data_types/components.dart';
import 'package:appointments/screens/home/appointments/appointment_details.dart';
import 'package:appointments/widget/custom_status.dart';
import 'package:common_widgets/custom_list_tile.dart';
import 'package:common_widgets/utils/date.dart';
import 'package:common_widgets/utils/input_validation.dart';
import 'package:common_widgets/utils/layout.dart';
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
          margin: EdgeInsets.only(
            bottom: rSize(5),
          ),
          height: rSize(18),
          child: Row(
            children: [
              VerticalDivider(
                color: Color(service.colorID),
                width: rSize(2),
                thickness: rSize(2),
              ),
              SizedBox(
                width: rSize(10),
              ),
              Text(
                service.name,
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
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppointmentDetails(
                      appointment: appointmentCardProps.appointmentDetails,
                    ),
                  ),
                ),
        title: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: appointmentServices(),
        ),
        subTitle: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: rSize(10), vertical: rSize(5)),
          child: Text(
            appointmentCardProps.appointmentDetails.notes ?? '',
            style: Theme.of(context).textTheme.subtitle1,
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
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomStatus(
                      customStatusProps: CustomStatusProps(
                        status: appointmentCardProps.appointmentDetails.status,
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(
                      height: rSize(10),
                    ),
                    Text(
                      getStringPrice(
                        appointmentCardProps.appointmentDetails.totalCost,
                      ),
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontSize: rSize(14),
                          ),
                    ),
                  ],
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
                    dateTime: appointmentCardProps.appointmentDetails.date,
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
                  dateTime: appointmentCardProps.appointmentDetails.date,
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
                  dateTime: appointmentCardProps.appointmentDetails.date,
                  format: 'HH:mm',
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
