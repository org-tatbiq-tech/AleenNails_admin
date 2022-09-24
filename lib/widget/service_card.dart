import 'package:appointments/data_types/components.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_list_tile.dart';
import 'package:common_widgets/ease_in_animation.dart';
import 'package:common_widgets/utils/input_validation.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final ServiceCardProps serviceCardProps;
  const ServiceCard({
    Key? key,
    required this.serviceCardProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      customListTileProps: CustomListTileProps(
        // minLeadingWidth: 10,
        marginBottom: 15,
        enabled: serviceCardProps.enabled,
        onTap: serviceCardProps.onTap,
        title: Text(
          serviceCardProps.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline1?.copyWith(
                fontSize: rSize(16),
              ),
        ),
        subTitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              serviceCardProps.subTitle,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  getStringPrice(serviceCardProps.serviceDetails.cost),
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        fontSize: rSize(16),
                      ),
                ),
                SizedBox(
                  width: rSize(5),
                ),
                serviceCardProps.withNavigation
                    ? IconTheme(
                        data: Theme.of(context).primaryIconTheme,
                        child: Icon(
                          Icons.chevron_right,
                          size: rSize(25),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
        leading: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: rSize(40),
              child: VerticalDivider(
                color: Color(serviceCardProps.serviceDetails.colorID),
                width: rSize(4),
                endIndent: rSize(2),
                thickness: rSize(2),
                indent: rSize(2),
              ),
            ),
            serviceCardProps.dragIndex != null
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: rSize(10)),
                    child: ReorderableDelayedDragStartListener(
                      index: serviceCardProps.dragIndex!,
                      child: EaseInAnimation(
                        onTap: () => {},
                        child: CustomIcon(
                          customIconProps: CustomIconProps(
                            icon: null,
                            backgroundColor: Colors.transparent,
                            path: 'assets/icons/drag_hand.png',
                            withPadding: false,
                            containerSize: 30,
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class ServiceCardProps {
  final Service serviceDetails;
  final bool withNavigation;
  final bool enabled;
  final String subTitle;
  final String title;
  final Function? onTap;
  final int? dragIndex;

  ServiceCardProps({
    required this.serviceDetails,
    this.withNavigation = true,
    this.enabled = true,
    this.subTitle = '',
    this.title = '',
    this.onTap,
    this.dragIndex,
  });
}
