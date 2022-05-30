import 'package:appointments/animations/fade_animation.dart';
import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_icon.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButtonProps customIconButtonProps;
  CustomIconButton({Key? key, required this.customIconButtonProps})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EaseInAnimation(
      beginAnimation: 0.99,
      onTap: customIconButtonProps.onTap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              offset: const Offset(0, 1),
              blurRadius: 4.0,
            ),
          ],
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(
            rSize(5),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: rSize(10),
              ),
              child: FadeAnimation(
                delay: customIconButtonProps.animationDelay,
                positionType: customIconButtonProps.positionType,
                child: CustomIcon(
                  customIconProps: CustomIconProps(
                    iconColor: Theme.of(context).colorScheme.background,
                    icon: null,
                    backgroundColor: Colors.transparent,
                    path: customIconButtonProps.iconPath,
                    containerSize: 25,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  horizontal: rSize(20),
                  vertical: rSize(10),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(
                    rSize(5),
                  ),
                ),
                child: Text(
                  customIconButtonProps.title,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomIconButtonProps {
  final String title;
  final String iconPath;
  final double animationDelay;
  final PositionType positionType;
  final VoidCallback onTap;
  CustomIconButtonProps({
    this.title = '',
    this.iconPath = 'assets/icons/calendar_plus.png',
    this.animationDelay = 0,
    this.positionType = PositionType.right,
    required this.onTap,
  });
}
