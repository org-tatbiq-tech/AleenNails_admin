import 'package:appointments/providers/app_data.dart';
import 'package:appointments/utils/data_types.dart';
import 'package:appointments/widget/contact_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/layout.dart';

class Clients extends StatefulWidget {
  const Clients({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ClientsState();
  }
}

class ClientsState extends State<Clients> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(
      builder: (context, appData, _) {
        return Container(
          color: Theme.of(context).colorScheme.background,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: rSize(10),
                    );
                  },
                  padding: EdgeInsets.symmetric(
                    vertical: rSize(20),
                    horizontal: rSize(20),
                  ),
                  itemCount: appData.filteredContacts.length,
                  itemBuilder: (context, index) {
                    return ContactCard(
                      contactCardProps: ContactCardProps(
                        contactDetails: appData.filteredContacts[index],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
