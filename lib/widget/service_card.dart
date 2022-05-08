import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/input_validation.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_list_tile.dart';
import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  ServiceCardProps serviceCardProps;
  ServiceCard({
    Key? key,
    required this.serviceCardProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      customListTileProps: CustomListTileProps(
        enabled: serviceCardProps.enabled,
        onTap: serviceCardProps.onTap ??
            () => Navigator.pushNamed(context, '/serviceDetails'),
        title: Text(
          serviceCardProps.title,
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
              serviceCardProps.subTitle,
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
                  getStringPrice(serviceCardProps.serviceDetails.price!),
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        fontSize: rSize(16),
                      ),
                ),
                SizedBox(
                  width: rSize(5),
                ),
                serviceCardProps.withNavigation
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
        leading: VerticalDivider(
          color: serviceCardProps.serviceDetails.color ??
              Theme.of(context).colorScheme.primary,
          width: rSize(4),
          thickness: rSize(4),
        ),
      ),
    );
  }
}
