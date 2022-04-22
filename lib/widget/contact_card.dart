import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_list_tile.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  ContactCardProps contactCardProps;
  ContactCard({
    Key? key,
    required this.contactCardProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      customListTileProps: CustomListTileProps(
        onTap: () => Navigator.pushNamed(context, '/contactDetails'),
        title: Text(
          contactCardProps.contactDetails.name!,
          style: Theme.of(context).textTheme.headline1?.copyWith(
                fontSize: rSize(18),
              ),
        ),
        subTitle: Text(
          contactCardProps.contactDetails.phone!,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                fontSize: rSize(16),
              ),
        ),
        trailing: IconTheme(
          data: Theme.of(context).primaryIconTheme,
          child: Icon(
            Icons.chevron_right,
            size: rSize(25),
          ),
        ),
        leading: CircleAvatar(
          radius: rSize(25),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Text(
            contactCardProps.contactDetails.name![0].toUpperCase() +
                contactCardProps.contactDetails.name![1].toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(fontSize: rSize(20)),
          ),
        ),
      ),
    );
  }
}
