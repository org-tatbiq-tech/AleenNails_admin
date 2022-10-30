import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/clients_mgr.dart';
import 'package:appointments/screens/home/appointments/appointment.dart';
import 'package:appointments/widget/appointment/client_appointment_card.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_text_button.dart';
import 'package:common_widgets/empty_list_image.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ClientAppointments extends StatefulWidget {
  const ClientAppointments({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ClientAppointmentsState();
  }
}

class ClientAppointmentsState extends State<ClientAppointments> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ClientsMgr>(
      builder: (context, clientsMgr, _) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: CustomAppBar(
            customAppBarProps: CustomAppBarProps(
              titleText:
                  Languages.of(context)!.clientAppointmentsLabel.toTitleCase(),
              withBack: true,
              customIcon: Icon(
                FontAwesomeIcons.plus,
                size: rSize(20),
              ),
              customIconTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AppointmentScreen(client: clientsMgr.selectedClient),
                  ),
                ),
              },
            ),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              clientsMgr.selectedClient.appointments.isEmpty
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: rSize(250),
                      ),
                      child: EmptyListImage(
                        emptyListImageProps: EmptyListImageProps(
                          title: Languages.of(context)!
                              .emptyAppointmentListLabel
                              .toCapitalized(),
                          iconPath: 'assets/icons/menu.png',
                          bottomWidgetPosition: 10,
                          bottomWidget: CustomTextButton(
                            customTextButtonProps: CustomTextButtonProps(
                              onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AppointmentScreen(
                                        client: clientsMgr.selectedClient),
                                  ),
                                ),
                              },
                              text: Languages.of(context)!
                                  .addNewAppointmentLabel
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
                      ),
                    )
                  : Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(
                          vertical: rSize(40),
                          horizontal: rSize(30),
                        ),
                        itemCount: clientsMgr
                            .selectedClient.appointments.values.length,
                        itemBuilder: (context, index) {
                          return ClientAppointmentCard(
                            clientAppointmentCardProps:
                                ClientAppointmentCardProps(
                              clientAppointmentDetails: clientsMgr
                                  .selectedClient.appointments.values
                                  .toList()[index],
                              withNavigation: true,
                              enabled: true,
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: rSize(15),
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
