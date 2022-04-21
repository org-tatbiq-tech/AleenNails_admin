import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/input_validation.dart';
import 'package:appointments/utils/layout.dart';
import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  ServiceCardProps serviceCardProps;
  ServiceCard({
    Key? key,
    required this.serviceCardProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.fromLTRB(0, 0, 0, rSize(20)),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
        rSize(15),
      )),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: rSize(20),
          vertical: 0,
        ),
        minVerticalPadding: 0,
        enabled: serviceCardProps.withNavigation,
        onTap: () => {
          Navigator.pushNamed(context, '/serviceDetails'),
        },
        subtitle: Text(
          serviceCardProps.serviceDetails.duration!,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(fontSize: rSize(16)),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              getStringPrice(serviceCardProps.serviceDetails.price!),
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    fontSize: rSize(18),
                  ),
            ),
            SizedBox(
              width: rSize(5),
            ),
            IconTheme(
              data: Theme.of(context).primaryIconTheme,
              child: Icon(
                Icons.chevron_right,
                size: rSize(25),
              ),
            ),
          ],
        ),
        minLeadingWidth: rSize(8),
        leading: Container(
          width: rSize(3),
          decoration: BoxDecoration(
              color: serviceCardProps.serviceDetails.color ??
                  Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(
                rSize(2),
              )),
        ),
        title: Text(
          serviceCardProps.serviceDetails.name!,
          style: Theme.of(context).textTheme.headline1?.copyWith(
                fontSize: rSize(18),
              ),
        ),
      ),
    );
  }
}
