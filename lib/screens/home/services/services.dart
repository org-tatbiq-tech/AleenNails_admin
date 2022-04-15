import 'package:appointments/utils/data_types.dart';
import 'package:appointments/widget/contact_card.dart';
import 'package:appointments/widget/service_card.dart';
import 'package:flutter/material.dart';
import '../../../utils/layout.dart';

//class needs to extend StatefulWidget since we need to make changes to the bottom app bar according to the user clicks
class Services extends StatefulWidget {
  const Services({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ServicesState();
  }
}

class ServicesState extends State<Services> {
  @override
  Widget build(BuildContext context) {
    Service service = Service(
      name: 'Saeed',
      duration: '0543103540',
      price: 45,
    );
    List<Service> services = [
      service,
      service,
      service,
      service,
      service,
      service
    ];
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                vertical: rSize(20),
                horizontal: rSize(20),
              ),
              itemCount: services.length,
              itemBuilder: (context, index) {
                return ServiceCard(
                  contactCardProps: ServiceCardProps(
                    serviceDetails: services[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
