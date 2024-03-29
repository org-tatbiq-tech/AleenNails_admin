import 'package:appointments/data_types/settings_components.dart';
import 'package:appointments/utils/general.dart';
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
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subTitle: unavailabilityCardProps.subTitle.isNotEmpty
            ? Text(
                unavailabilityCardProps.subTitle,
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 2,
              )
            : null,
        trailing: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomIcon(
              customIconProps: CustomIconProps(
                isDisabled: false,
                onTap: () => unavailabilityCardProps.deleteAction(),
                icon: null,
                path: 'assets/icons/trash.png',
                withPadding: true,
                backgroundColor: Theme.of(context).colorScheme.error,
                iconColor: Colors.white,
                containerSize: 35,
                contentPadding: 8,
              ),
            ),
          ],
        ),
        leading: Container(
          padding: EdgeInsets.symmetric(
            horizontal: rSize(15),
            vertical: rSize(5),
          ),
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
                  locale: getCurrentLocale(context),
                ),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                getDateTimeFormat(
                  dateTime:
                      unavailabilityCardProps.unavailabilityDetails.startTime,
                  format: 'MMM',
                  locale: getCurrentLocale(context),
                ),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              SizedBox(
                height: rSize(2),
              ),
              Text(
                getDateTimeFormat(
                  dateTime:
                      unavailabilityCardProps.unavailabilityDetails.startTime,
                  format: 'yyyy',
                  locale: getCurrentLocale(context),
                ),
                style: Theme.of(context).textTheme.labelLarge,
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
