import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/clients_mgr.dart';
import 'package:appointments/screens/home/appointments/appointment.dart';
import 'package:appointments/widget/appointment/client_appointment_card.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_container.dart';
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
        return CustomContainer(
          imagePath: 'assets/images/background4.png',
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(
              customAppBarProps: CustomAppBarProps(
                titleText: Languages.of(context)!
                    .clientAppointmentsLabel
                    .toTitleCase(),
                withBack: true,
                isTransparent: true,
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
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: clientsMgr.selectedClientAppointments.isEmpty
                  ? EmptyListImage(
                      emptyListImageProps: EmptyListImageProps(
                        title: Languages.of(context)!
                            .emptyAppointmentListLabel
                            .toCapitalized(),
                        iconPath: 'assets/icons/menu.png',
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
                    )
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(
                        vertical: rSize(40),
                        horizontal: rSize(30),
                      ),
                      itemCount: clientsMgr.selectedClientAppointments.length,
                      itemBuilder: (context, index) {
                        return ClientAppointmentCard(
                          clientAppointmentCardProps:
                              ClientAppointmentCardProps(
                            clientAppointmentDetails:
                                clientsMgr.selectedClientAppointments[index],
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
          ),
        );
      },
    );
  }
}
