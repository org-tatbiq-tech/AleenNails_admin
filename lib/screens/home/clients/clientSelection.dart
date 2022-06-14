import 'package:appointments/providers/app_data.dart';
import 'package:appointments/widget/client_card.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../utils/layout.dart';

class ClientSelection extends StatefulWidget {
  Function? onTap;
  ClientSelection({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ClientSelectionState();
  }
}

class ClientSelectionState extends State<ClientSelection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(
      builder: (context, appData, _) {
        return Scaffold(
          appBar: CustomAppBar(
            customAppBarProps: CustomAppBarProps(
              titleText: 'Select a Client',
              withBack: true,
              withSearch: true,
              withClipPath: false,
              customIcon: Icon(
                FontAwesomeIcons.plus,
                size: rSize(24),
              ),
              customIconTap: () => {
                Navigator.pushNamed(context, '/newClient'),
              },
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: rSize(15),
                    );
                  },
                  padding: EdgeInsets.symmetric(
                    vertical: rSize(20),
                    horizontal: rSize(20),
                  ),
                  itemCount: appData.filteredContacts.length,
                  itemBuilder: (context, index) {
                    return ClientCard(
                      clientCardProps: ClientCardProps(
                        onTap: () => widget.onTap!(
                          appData.filteredContacts[index],
                        ),
                        withNavigation: false,
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
