import 'dart:ui';

import 'package:appointments/data_types/components.dart';
import 'package:common_widgets/custom_app_bar.dart';

import 'package:appointments/widget/custom_text_button.dart';
import 'package:common_widgets/empty_list_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_data.dart';
import '../../../utils/layout.dart';

class Services extends StatefulWidget {
  final bool selectionMode;
  final Function? onTap;
  const Services({
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
    final appData = Provider.of<AppData>(context, listen: false);

    List<Service> services = [
      appData.selectedService,
      appData.selectedService,
      appData.selectedService,
      appData.selectedService,
    ];

    Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double elevation = lerpDouble(0, 6, animValue)!;
          return Material(
            borderRadius: BorderRadius.circular(rSize(10)),
            elevation: elevation,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            shadowColor: Theme.of(context).shadowColor,
            child: child,
          );
        },
        child: child,
      );
    }

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
          // services.isNotEmpty
          // ? Expanded(
          //     child: ReorderableListView.builder(
          //     buildDefaultDragHandles: false,
          //     onReorder: (oldIndex, newIndex) {
          //       if (newIndex > oldIndex) newIndex--;
          //       final Service service = services.removeAt(oldIndex);
          //       services.insert(newIndex, service);
          //     },
          //     proxyDecorator: proxyDecorator,
          //     padding: EdgeInsets.symmetric(
          //       vertical: rSize(40),
          //       horizontal: rSize(30),
          //     ),
          //     itemCount: services.length,
          //     itemBuilder: (context, index) {
          //       return ServiceCard(
          //         key: ValueKey(services[index].id),
          //         serviceCardProps: ServiceCardProps(
          //           withNavigation: !widget.selectionMode,
          //           dragIndex: index,
          //           onTap: widget.onTap != null
          //               ? () => widget.onTap!(services[index])
          //               : null,
          //           serviceDetails: services[index],
          //           title: services[index].name ?? '',
          //           subTitle: services[index].duration.toString() ?? '',
          //         ),
          //       );
          //     },
          //   ))
          Padding(
            padding: EdgeInsets.only(
              top: rSize(250),
            ),
            child: EmptyListImage(
              emptyListImageProps: EmptyListImageProps(
                title: 'No services added yet',
                iconPath: 'assets/icons/menu.png',
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
