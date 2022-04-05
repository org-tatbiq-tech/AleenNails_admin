import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final CustomIconProps customIconProps;
  const CustomIcon({
    Key? key,
    required this.customIconProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor =
        customIconProps.color ?? Theme.of(context).colorScheme.primaryContainer;
    return Container(
        width: rSize(customIconProps.containerSize),
        height: rSize(customIconProps.containerSize),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(
              rSize(customIconProps.containerSize / 4),
            )),
        child: IconTheme(
          data: Theme.of(context).primaryIconTheme,
          child: customIconProps.icon ?? const SizedBox(),
        ));
  }
}
