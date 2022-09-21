import 'package:appointments/data_types/components.dart';
import 'package:common_widgets/utils/input_validation.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:common_widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';

class AppointmentServiceCard extends StatelessWidget {
  final AppointmentServiceCardProps appointmentServiceCardProps;
  const AppointmentServiceCard({
    Key? key,
    required this.appointmentServiceCardProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      customListTileProps: CustomListTileProps(
        height: rSize(70),
        marginBottom: 15,
        enabled: appointmentServiceCardProps.enabled,
        onTap: appointmentServiceCardProps.onTap ??
            () => Navigator.pushNamed(context, '/serviceDetails'),
        title: Text(
          appointmentServiceCardProps.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline1?.copyWith(
                fontSize: rSize(16),
              ),
        ),
        subTitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              appointmentServiceCardProps.subTitle,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  getStringPrice(
                      appointmentServiceCardProps.serviceDetails.cost),
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        fontSize: rSize(16),
                      ),
                ),
                SizedBox(
                  width: rSize(5),
                ),
                appointmentServiceCardProps.withNavigation
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
        leading: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VerticalDivider(
              // color: Color(serviceCardProps.serviceDetails.colorID),
              color: Colors.red,
              width: rSize(4),
              endIndent: rSize(8),
              thickness: rSize(3),
              indent: rSize(8),
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentServiceCardProps {
  final AppointmentService serviceDetails;
  final bool withNavigation;
  final bool enabled;
  final String subTitle;
  final String title;
  final Function? onTap;

  AppointmentServiceCardProps({
    required this.serviceDetails,
    this.withNavigation = true,
    this.enabled = true,
    this.subTitle = '',
    this.title = '',
    this.onTap,
  });
}
