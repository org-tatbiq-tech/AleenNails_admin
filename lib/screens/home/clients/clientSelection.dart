import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/clients_mgr.dart';
import 'package:appointments/screens/home/clients/client.dart';
import 'package:appointments/widget/client_card.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ClientSelection extends StatefulWidget {
  final Function onTap;
  const ClientSelection({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ClientSelectionState();
  }
}

class ClientSelectionState extends State<ClientSelection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ClientsMgr>(
      builder: (context, clientsMgr, _) {
        return Scaffold(
          appBar: CustomAppBar(
            customAppBarProps: CustomAppBarProps(
              titleText: Languages.of(context)!.selectClientLabel.toTitleCase(),
              withBack: true,
              withSearch: true,
              withClipPath: false,
              customIcon: Icon(
                FontAwesomeIcons.plus,
                size: rSize(24),
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
                  itemCount: clientsMgr.clients.length,
                  itemBuilder: (context, index) {
                    return ClientCard(
                      clientCardProps: ClientCardProps(
                        onTap: () => widget.onTap(
                          clientsMgr.clients[index],
                        ),
                        withNavigation: false,
                        contactDetails: clientsMgr.clients[index],
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
