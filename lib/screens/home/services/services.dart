import 'package:appointments/utils/data_types.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_text_button.dart';
import 'package:appointments/widget/empty_list_image.dart';
import 'package:appointments/widget/service_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../utils/layout.dart';

//class needs to extend StatefulWidget since we need to make changes to the bottom app bar according to the user clicks
class Services extends StatefulWidget {
  bool selectionMode;
  Function? onTap;
  Services({
    Key? key,
    this.selectionMode = false,
    this.onTap,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ServicesState();
  }
}

class ServicesState extends State<Services> {
  @override
  Widget build(BuildContext context) {
    Service service = Service(
      name: 'Service Name',
      duration: '1h 25m',
      price: 45,
    );
    List<Service> services = [
      // service,
      // service,
      // service,
      // service,
      // service,
      // service
    ];
    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText: 'Services',
          withBack: true,
          withSearch: true,
          withClipPath: false,
          customIcon: Icon(
            FontAwesomeIcons.plus,
            size: rSize(24),
          ),
          customIconTap: () => {Navigator.pushNamed(context, '/newService')},
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          services.isNotEmpty
              ? Expanded(
                  child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: rSize(10),
                    );
                  },
                  padding: EdgeInsets.symmetric(
                    vertical: rSize(30),
                    horizontal: rSize(20),
                  ),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    return ServiceCard(
                      serviceCardProps: ServiceCardProps(
                        withNavigation: !widget.selectionMode,
                        onTap: widget.onTap,
                        serviceDetails: services[index],
                        title: service.name ?? '',
                        subTitle: services[index].duration ?? '',
                      ),
                    );
                  },
                ))
              : Padding(
                  padding: EdgeInsets.only(
                    top: rSize(250),
                  ),
                  child: EmptyListImage(
                    emptyListImageProps: EmptyListImageProps(
                      title: 'No services added yet',
                      iconPath: 'assets/icons/services.png',
                      bottomWidgetPosition: 10,
                      bottomWidget: CustomTextButton(
                        customTextButtonProps: CustomTextButtonProps(
                          onTap: () => {
                            Navigator.pushNamed(context, '/newService'),
                          },
                          text: 'Add New Service',
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
                ),
        ],
      ),
    );
  }
}
