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
    Color backgroundColor = customIconProps.backgroundColor ??
        Theme.of(context).colorScheme.primaryContainer;
    return Container(
      width: rSize(customIconProps.containerSize),
      height: rSize(customIconProps.containerSize),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(
            rSize(customIconProps.containerSize / 4),
          )),
      child: customIconProps.path.isEmpty
          ? IconTheme(
              data: Theme.of(context).primaryIconTheme.copyWith(
                    color: customIconProps.iconColor,
                  ),
              child: customIconProps.icon ?? const SizedBox(),
            )
          : Padding(
              padding: EdgeInsets.all(
                rSize(
                  customIconProps.withPadding
                      ? customIconProps.containerSize * 0.15
                      : 0,
                ),
              ),
              child: Image.asset(
                customIconProps.path,
                fit: BoxFit.cover,
                color: customIconProps.iconColor ??
                    Theme.of(context).colorScheme.primary,
              ),
            ),
    );
  }
}
