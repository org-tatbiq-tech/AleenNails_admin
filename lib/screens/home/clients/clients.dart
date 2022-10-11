import 'package:appointments/data_types/components.dart';
import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/clients_mgr.dart';
import 'package:appointments/screens/home/clients/client.dart';
import 'package:appointments/screens/home/clients/client_details.dart';
import 'package:appointments/utils/general.dart';
import 'package:appointments/widget/client_card.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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
    navigateToClientDetails(Client client) {
      final clientsMgr = Provider.of<ClientsMgr>(context, listen: false);
      clientsMgr.setSelectedClient(client: client);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ClientDetails(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText: Languages.of(context)!.clientsLabel.toTitleCase(),
          customIcon: Icon(
            FontAwesomeIcons.plus,
            size: rSize(20),
          ),
          customIconTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ClientWidget(),
              ),
            ),
          },
        ),
      ),
      body: Consumer<ClientsMgr>(
        builder: (context, clientsMgr, _) {
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
                        height: rSize(15),
                      );
                    },
                    padding: EdgeInsets.symmetric(
                      vertical: rSize(20),
                      horizontal: rSize(20),
                    ),
                    itemCount: clientsMgr.clients.length,
                    itemBuilder: (context, index) {
                      return ClientCard(
                        clientCardProps: ClientCardProps(
                          contactDetails: clientsMgr.clients[index],
                          onTap: () => navigateToClientDetails(
                              clientsMgr.clients[index]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
