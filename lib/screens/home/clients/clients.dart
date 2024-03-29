import 'package:appointments/data_types/components.dart';
import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/clients_mgr.dart';
import 'package:appointments/screens/home/clients/client.dart';
import 'package:appointments/screens/home/clients/client_details.dart';
import 'package:appointments/widget/client/client_card.dart';
import 'package:appointments/widget/client/clients_search.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_container.dart';
import 'package:common_widgets/custom_text_button.dart';
import 'package:common_widgets/empty_list_image.dart';
import 'package:common_widgets/utils/general.dart';
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
    navigateToClientDetails(Client client) async {
      final clientsMgr = Provider.of<ClientsMgr>(context, listen: false);
      await clientsMgr.setSelectedClient(clientID: client.id);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ClientDetails(),
        ),
      );
    }

    return Consumer<ClientsMgr>(builder: (context, clientsMgr, _) {
      return CustomContainer(
        imagePath: 'assets/images/background4.png',
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CustomAppBar(
            customAppBarProps: CustomAppBarProps(
              withSearch: clientsMgr.clients.isNotEmpty,
              centerTitle: WrapAlignment.start,
              isTransparent: true,
              searchFunction: () => showSearch(
                context: context,
                delegate: ClientsSearchDelegate(clients: clientsMgr.clients),
              ),
              titleText:
                  '${Languages.of(context)!.clientsLabel.toTitleCase()} (${clientsMgr.clients.length})',
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
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: clientsMgr.clients.isEmpty
                ? EmptyListImage(
                    emptyListImageProps: EmptyListImageProps(
                      title: Languages.of(context)!
                          .noClientsAddedLabel
                          .toTitleCase(),
                      iconPath: 'assets/icons/menu.png',
                      bottomWidget: CustomTextButton(
                        customTextButtonProps: CustomTextButtonProps(
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ClientWidget(),
                              ),
                            ),
                          },
                          text: Languages.of(context)!
                              .addNewClientLabel
                              .toTitleCase(),
                          textColor: Theme.of(context).colorScheme.primary,
                          withIcon: true,
                          icon: Icon(
                            FontAwesomeIcons.plus,
                            size: rSize(16),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  )
                : ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: rSize(15),
                      );
                    },
                    padding: EdgeInsets.symmetric(
                      vertical: rSize(40),
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
        ),
      );
    });
  }
}
