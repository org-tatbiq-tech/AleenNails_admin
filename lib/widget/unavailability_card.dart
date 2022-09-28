import 'package:appointments/data_types/settings_components.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_list_tile.dart';
import 'package:common_widgets/ease_in_animation.dart';
import 'package:common_widgets/utils/date.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';

class UnavailabilityCard extends StatelessWidget {
  final UnavailabilityCardProps unavailabilityCardProps;
  const UnavailabilityCard({
    Key? key,
    required this.unavailabilityCardProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      customListTileProps: CustomListTileProps(
        enabled: unavailabilityCardProps.enabled,
        onTap: unavailabilityCardProps.onTap,
        title: Text(
          unavailabilityCardProps.title,
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
              unavailabilityCardProps.subTitle,
              style: Theme.of(context).textTheme.subtitle1,
              maxLines: 2,
            ),
          ],
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            EaseInAnimation(
              onTap: () => unavailabilityCardProps.deleteAction(),
              child: CustomIcon(
                customIconProps: CustomIconProps(
                  icon: null,
                  path: 'assets/icons/trash.png',
                  withPadding: true,
                  backgroundColor: Theme.of(context).colorScheme.error,
                  iconColor: Colors.white,
                  containerSize: rSize(35),
                  contentPadding: rSize(6),
                ),
              ),
            ),
          ],
        ),
        leading: Container(
          padding:
              EdgeInsets.symmetric(horizontal: rSize(10), vertical: rSize(5)),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: rSize(1),
            ),
            borderRadius: BorderRadius.circular(
              rSize(10),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                getDateTimeFormat(
                  dateTime:
                      unavailabilityCardProps.unavailabilityDetails.startTime,
                  format: 'dd',
                  isDayOfWeek: true,
                ),
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontSize: rSize(22),
                    ),
              ),
              Text(
                getDateTimeFormat(
                  dateTime:
                      unavailabilityCardProps.unavailabilityDetails.startTime,
                  format: 'MMM',
                ),
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      fontSize: rSize(12),
                    ),
              ),
              SizedBox(
                height: rSize(2),
              ),
              Text(
                getDateTimeFormat(
                  dateTime:
                      unavailabilityCardProps.unavailabilityDetails.startTime,
                  format: 'yyyy',
                ),
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      fontSize: rSize(12),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UnavailabilityCardProps {
  final UnavailabilityComp unavailabilityDetails;
  final bool enabled;
  final String subTitle;
  final String title;
  final Function? onTap;
  final Function deleteAction;

  UnavailabilityCardProps({
    required this.unavailabilityDetails,
    this.enabled = false,
    this.subTitle = '',
    this.title = '',
    this.onTap,
    required this.deleteAction,
  });
}
