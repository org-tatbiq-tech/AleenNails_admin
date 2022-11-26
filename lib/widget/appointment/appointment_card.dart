import 'package:appointments/data_types/components.dart';
import 'package:appointments/providers/appointments_mgr.dart';
import 'package:appointments/screens/home/appointments/appointment_details.dart';
import 'package:appointments/utils/general.dart';
import 'package:appointments/widget/appointment/appointment_status.dart';
import 'package:appointments/widget/custom/custom_avatar.dart';
import 'package:common_widgets/custom_list_tile.dart';
import 'package:common_widgets/utils/date.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              Expanded(
                child: Text(
                  service.name,
                  style: Theme.of(context).textTheme.subtitle2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      }).toList();

      return widgetList;
    }

    Future<ImageProvider<Object>?> getClientImage(String path) async {
      String imageUrl = '';
      // if (imageUrl.isNotEmpty) {
      //   return CachedNetworkImageProvider(imageUrl);
      // }
      return null;
    }

    navigateToAppointmentDetails(Appointment appointment) {
      final appointmentsMgr =
          Provider.of<AppointmentsMgr>(context, listen: false);
      appointmentsMgr.setSelectedAppointment(appointment: appointment);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AppointmentDetails(),
        ),
      );
    }

    return CustomListTile(
      customListTileProps: CustomListTileProps(
        enabled: appointmentCardProps.enabled,
        onTap: appointmentCardProps.onTap ??
            () => navigateToAppointmentDetails(
                appointmentCardProps.appointmentDetails),
        title: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: appointmentServices(),
        ),
        subTitle: appointmentCardProps.appointmentDetails.notes.isEmpty
            ? null
            : Text(
                appointmentCardProps.appointmentDetails.notes,
                style: Theme.of(context).textTheme.subtitle1,
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
                    AppointmentStatusComp(
                      customStatusProps: CustomStatusProps(
                        appointmentStatus:
                            appointmentCardProps.appointmentDetails.status,
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(
                      height: rSize(5),
                    ),
                    Text(
                      getStringPrice(
                        appointmentCardProps.appointmentDetails.totalCost,
                      ),
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontSize: rSize(14),
                          ),
                    ),
                    Text(
                      '${getDateTimeFormat(
                        dateTime: appointmentCardProps.appointmentDetails.date,
                        locale: getCurrentLocale(context),
                      )} - ${getDateTimeFormat(
                        dateTime:
                            appointmentCardProps.appointmentDetails.endTime,
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
                  visible: appointmentCardProps.withNavigation,
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
        leading: FutureBuilder<ImageProvider<Object>?>(
          future: getClientImage(
              appointmentCardProps.appointmentDetails.clientImagePath),
          builder: (context, snapshot) {
            return Column(
              children: [
                CustomAvatar(
                  customAvatarProps: CustomAvatarProps(
                    radius: rSize(50),
                    rectangleShape: false,
                    circleShape: true,
                    backgroundImage: snapshot.data,
                    defaultImage: const AssetImage(
                      'assets/images/avatar_female.png',
                    ),
                    enable: false,
                  ),
                ),
                SizedBox(
                  height: rSize(5),
                ),
                Text(
                  appointmentCardProps.appointmentDetails.clientName,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(fontSize: rSize(12)),
                ),
              ],
            );
          },
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
