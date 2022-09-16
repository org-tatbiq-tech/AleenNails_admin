import 'package:common_widgets/utils/layout.dart';
import 'package:common_widgets/custom_icon.dart';

import 'package:common_widgets/ease_in_animation.dart';

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
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SizedBox(
                    width: customAvatarProps.radius - rSize(4),
                    height: customAvatarProps.backgroundImage == null
                        ? customAvatarProps.radius * 0.1
                        : null,
                  ),
                  customAvatarProps.backgroundImage == null
                      ? Opacity(
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
                                ? const AssetImage(
                                    'assets/images/avatar_male.png')
                                : const AssetImage(
                                    'assets/images/avatar_female.png'),
                          ))
                      : Image(
                          width: customAvatarProps.radius - rSize(4),
                          height: customAvatarProps.rectangleShape
                              ? customAvatarProps.radius * 1.2
                              : customAvatarProps.radius,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          image: customAvatarProps.backgroundImage!,
                        ),
                ],
              ),
            ),
            customAvatarProps.editable
                ? Positioned(
                    bottom: rSize(10),
                    right: 0,
                    child: CustomIcon(
                      customIconProps: CustomIconProps(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        containerSize: customAvatarProps.radius * 0.25,
                        icon: IconTheme(
                          data: Theme.of(context).iconTheme,
                          child: Icon(
                            Icons.edit,
                            size: customAvatarProps.radius * 0.15,
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

class CustomAvatarProps {
  final double radius;
  final bool enable;
  final bool circleShape;
  final bool rectangleShape;
  final bool isMale;
  final bool editable;
  final ImageProvider? backgroundImage;
  final Function? onTap;

  CustomAvatarProps({
    this.radius = 50,
    this.enable = false,
    this.isMale = false,
    this.editable = false,
    this.circleShape = false,
    this.onTap,
    this.rectangleShape = false,
    this.backgroundImage,
  });
}
