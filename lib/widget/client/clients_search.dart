import 'package:appointments/data_types/components.dart';
import 'package:appointments/providers/clients_mgr.dart';
import 'package:appointments/providers/theme_provider.dart';
import 'package:appointments/screens/home/clients/client_details.dart';
import 'package:appointments/widget/client/client_card.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Clients search delegate - copies original clients and search according to:
//  - phone
//  - client name
//  - email

class ClientsSearchDelegate extends SearchDelegate {
  List<Client> searchClients = [];
  Function? onTap;
  ClientsSearchDelegate({required List<Client> clients, this.onTap}) {
    searchClients.addAll(clients); // Creating a copy
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme;
  }

  @override
  TextStyle? get searchFieldStyle => TextStyle(
        color: primaryFont,
        fontWeight: FontWeight.w300,
        fontSize: rSize(16),
      );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {},
        icon: CustomIcon(
          customIconProps: CustomIconProps(
            isDisabled: false,
            onTap: () {
              query = '';
            },
            icon: Icon(
              Icons.clear,
              size: rSize(25),
            ),
          ),
        ),
      ),
    ];
  }

  // Pop out of search menu - back to original screen
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () {},
      icon: CustomIcon(
        customIconProps: CustomIconProps(
          isDisabled: false,
          onTap: () {
            close(context, null);
          },
          icon: Icon(
            Icons.arrow_back,
            size: rSize(25),
          ),
        ),
      ),
    );
  }

  // Show query result
  @override
  Widget buildResults(BuildContext context) {
    navigateToClientDetails(Client client) {
      final clientsMgr = Provider.of<ClientsMgr>(context, listen: false);
      clientsMgr.setSelectedClient(clientID: client.id);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ClientDetails(),
        ),
      );
    }

    List<Client> clientsMatchQuery = [];
    for (var p in searchClients) {
      if (p.phone.contains(query.toLowerCase()) ||
          p.fullName.toLowerCase().contains(query.toLowerCase()) ||
          p.email.toLowerCase().contains(query.toLowerCase())) {
        clientsMatchQuery.add(p);
      }
    }
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: rSize(20),
          vertical: rSize(20),
        ),
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: rSize(15),
          );
        },
        itemCount: clientsMatchQuery.length,
        itemBuilder: (context, index) {
          var result = clientsMatchQuery[index];
          return ClientCard(
            clientCardProps: ClientCardProps(
              contactDetails: result,
              onTap: () => {
                close(context, null),
                onTap != null
                    ? {onTap!(result)}
                    : navigateToClientDetails(result),
              },
            ),
          );
        },
      ),
    );
  }

  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    navigateToClientDetails(Client client) {
      final clientsMgr = Provider.of<ClientsMgr>(context, listen: false);
      clientsMgr.setSelectedClient(clientID: client.id);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ClientDetails(),
        ),
      );
    }

    List<Client> clientsMatchQuery = [];
    for (var p in searchClients) {
      if (p.phone.contains(query.toLowerCase()) ||
          p.fullName.toLowerCase().contains(query.toLowerCase()) ||
          p.email.toLowerCase().contains(query.toLowerCase())) {
        clientsMatchQuery.add(p);
      }
    }
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: rSize(20),
          vertical: rSize(20),
        ),
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: rSize(15),
          );
        },
        itemCount: clientsMatchQuery.length,
        itemBuilder: (context, index) {
          var result = clientsMatchQuery[index];
          return ClientCard(
            clientCardProps: ClientCardProps(
              contactDetails: result,
              onTap: () => {
                close(context, null),
                onTap != null
                    ? {onTap!(result)}
                    : navigateToClientDetails(result),
              },
            ),
          );
        },
      ),
    );
  }
}
