import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  ContactCardProps contactCardProps;
  ContactCard({
    Key? key,
    required this.contactCardProps,
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
        enabled: contactCardProps.withNavigation,
        onTap: () => Navigator.pushNamed(context, '/contactDetails'),
        subtitle: Text(
          contactCardProps.contactDetails.phone,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(fontSize: rSize(16)),
        ),
        trailing: IconTheme(
          data: Theme.of(context).primaryIconTheme,
          child: Icon(
            Icons.chevron_right,
            size: rSize(25),
          ),
        ),
        leading: CircleAvatar(
          radius: rSize(28),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Text(
            contactCardProps.contactDetails.name[0].toUpperCase() +
                contactCardProps.contactDetails.name[1].toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(fontSize: rSize(20)),
          ),
        ),
        title: Text(
          contactCardProps.contactDetails.name,
          style: Theme.of(context)
              .textTheme
              .headline1
              ?.copyWith(fontSize: rSize(20)),
        ),
      ),
    );
  }
}
