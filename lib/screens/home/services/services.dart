import 'dart:ui';

import 'package:appointments/data_types/components.dart';
import 'package:appointments/providers/services_mgr.dart';
import 'package:appointments/screens/home/services/service.dart';
import 'package:appointments/utils/formats.dart';
import 'package:appointments/widget/custom_reorderable_list_view.dart';
import 'package:appointments/widget/custom_text_button.dart';
import 'package:appointments/widget/service_card.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/empty_list_image.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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
    Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final animValue = Curves.easeInOut.transform(animation.value);
          final scale = lerpDouble(1, 1.05, animValue)!;
          final elevation = lerpDouble(0, 6, animValue)!;
          return Transform.scale(
            scale: scale,
            child: Material(
              elevation: elevation,
              borderRadius: BorderRadius.circular(rSize(10)),
              color: Colors.transparent,
              child: child,
            ),
          );
        },
        child: child,
      );
    }

    navigateToService(Service service) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ServiceWidget(service: service),
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText: 'Services',
          withBack: true,
          withSearch: false,
          withClipPath: false,
          customIcon: Icon(
            FontAwesomeIcons.plus,
            size: rSize(24),
          ),
          customIconTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ServiceWidget(),
              ),
            ),
          },
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Consumer<ServicesMgr>(
        builder: (context, servicesMgr, _) => Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            servicesMgr.services.isNotEmpty
                ? Expanded(
                    child: CustomReorderableListView.separated(
                      // scrollController: scrollController,
                      separatorBuilder: (context, index) => SizedBox(
                        height: rSize(15),
                      ),
                      buildDefaultDragHandles: false,
                      onReorder: (oldIndex, newIndex) {
                        if (newIndex > oldIndex) newIndex--;
                        final Service service =
                            servicesMgr.services.removeAt(oldIndex);
                        servicesMgr.services.insert(newIndex, service);
                      },
                      proxyDecorator: proxyDecorator,
                      padding: EdgeInsets.symmetric(
                        vertical: rSize(40),
                        horizontal: rSize(30),
                      ),
                      itemCount: servicesMgr.services.length,
                      itemBuilder: (context, index) {
                        return ServiceCard(
                          key: ValueKey(servicesMgr.services[index].id),
                          serviceCardProps: ServiceCardProps(
                            withNavigation: !widget.selectionMode,
                            dragIndex: index == 0 ? index : index + (1 * index),
                            onTap: widget.onTap != null
                                ? () =>
                                    widget.onTap!(servicesMgr.services[index])
                                : () => navigateToService(
                                    servicesMgr.services[index]),
                            serviceDetails: servicesMgr.services[index],
                            title: servicesMgr.services[index].name,
                            subTitle: durationToFormat(
                                duration: servicesMgr.services[index].duration),
                          ),
                        );
                      },
                    ),
                    // child: ReorderableListView.builder(
                    //   buildDefaultDragHandles: false,
                    //   onReorder: (oldIndex, newIndex) {
                    //     if (newIndex > oldIndex) newIndex--;
                    //     final Service service =
                    //         servicesMgr.services.removeAt(oldIndex);
                    //     servicesMgr.services.insert(newIndex, service);
                    //   },
                    //   proxyDecorator: proxyDecorator,
                    //   padding: EdgeInsets.symmetric(
                    //     vertical: rSize(40),
                    //     horizontal: rSize(30),
                    //   ),
                    //   itemCount: servicesMgr.services.length,
                    //   itemBuilder: (context, index) {
                    //     return ServiceCard(
                    //       key: ValueKey(servicesMgr.services[index].id),
                    //       serviceCardProps: ServiceCardProps(
                    //         withNavigation: !widget.selectionMode,
                    //         dragIndex: index,
                    //         onTap: widget.onTap != null
                    //             ? () =>
                    //                 widget.onTap!(servicesMgr.services[index])
                    //             : () => navigateToService(
                    //                 servicesMgr.services[index]),
                    //         serviceDetails: servicesMgr.services[index],
                    //         title: servicesMgr.services[index].name,
                    //         subTitle: durationToFormat(
                    //             duration: servicesMgr.services[index].duration),
                    //       ),
                    //     );
                    //   },
                    // ),
                  )
                : Padding(
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ServiceWidget(),
                                ),
                              ),
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
      ),
    );
  }
}
