import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_icon.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final CustomAvatarProps customAvatarProps;
  const CustomAvatar({
    Key? key,
    required this.customAvatarProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EaseInAnimation(
      isDisabled: !customAvatarProps.enable,
      onTap: customAvatarProps.onTap ?? () => {},
      child: SizedBox(
        width: customAvatarProps.radius,
        height: customAvatarProps.rectangleShape
            ? customAvatarProps.radius * 1.2
            : customAvatarProps.radius,
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SizedBox(
                      width: customAvatarProps.radius - rSize(4),
                      height: customAvatarProps.radius * 0.1),
                  Opacity(
                    opacity: 0.6,
                    child: Image(
                      width: customAvatarProps.radius - rSize(4),
                      height: customAvatarProps.rectangleShape
                          ? customAvatarProps.radius * 1.2
                          : customAvatarProps.radius,
                      fit: BoxFit.contain,
                      color: Theme.of(context).colorScheme.primary,
                      alignment: Alignment.bottomCenter,
                      image: customAvatarProps.isMale
                          ? const AssetImage('assets/images/avatar_male.png')
                          : customAvatarProps.backgroundImage,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onBackground,
                border: Border.all(
                  width: rSize(2),
                  color: Theme.of(context).colorScheme.primary,
                ),
                shape: BoxShape.rectangle,
                borderRadius: customAvatarProps.circleShape
                    ? BorderRadius.circular(customAvatarProps.radius / 2)
                    : BorderRadius.circular(customAvatarProps.radius / 4),
              ),
            ),
            customAvatarProps.editable
                ? Positioned(
                    bottom: 0,
                    right: 0,
                    child: CustomIcon(
                      customIconProps: CustomIconProps(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        containerSize: customAvatarProps.radius * 0.3,
                        icon: IconTheme(
                          data: Theme.of(context).iconTheme,
                          child: Icon(
                            Icons.edit,
                            size: customAvatarProps.radius * 0.2,
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
