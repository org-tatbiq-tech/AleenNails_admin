import 'package:appointments/data_types/components.dart';
import 'package:appointments/screens/home/services/service.dart';
import 'package:appointments/widget/service/service_card.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/utils/date.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';

// Services search delegate - copies original service and search according to:
//  - name

class ServicesSearchDelegate extends SearchDelegate {
  List<Service> searchServices = [];
  ServicesSearchDelegate({required List<Service> services}) {
    searchServices.addAll(services); // Creating a copy
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {
          query = '';
        },
        icon: CustomIcon(
          customIconProps: CustomIconProps(
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
      onPressed: () {
        close(context, null);
      },
      icon: CustomIcon(
        customIconProps: CustomIconProps(
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
    navigateToService(Service service) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ServiceWidget(service: service),
        ),
      );
    }

    List<Service> servicesMatchQuery = [];
    for (var p in searchServices) {
      if (p.name.contains(query.toLowerCase())) {
        servicesMatchQuery.add(p);
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
        itemCount: servicesMatchQuery.length,
        itemBuilder: (context, index) {
          var result = servicesMatchQuery[index];
          return ServiceCard(
            serviceCardProps: ServiceCardProps(
              serviceDetails: result,
              onTap: () => {
                close(context, null),
                navigateToService(result),
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
    navigateToService(Service service) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ServiceWidget(service: service),
        ),
      );
    }

    List<Service> servicesMatchQuery = [];
    for (var p in searchServices) {
      if (p.name.contains(query.toLowerCase())) {
        servicesMatchQuery.add(p);
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
        itemCount: servicesMatchQuery.length,
        itemBuilder: (context, index) {
          var result = servicesMatchQuery[index];
          return ServiceCard(
            serviceCardProps: ServiceCardProps(
              serviceDetails: result,
              title: result.name,
              subTitle: durationToFormat(
                duration: result.duration,
              ),
              onTap: () => {
                close(context, null),
                navigateToService(result),
              },
            ),
          );
        },
      ),
    );
  }
}
