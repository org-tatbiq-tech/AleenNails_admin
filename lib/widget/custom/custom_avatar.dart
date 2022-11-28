import 'package:appointments/widget/custom/placeholders.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_widgets/custom_loading-indicator.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:common_widgets/custom_icon.dart';

import 'package:common_widgets/ease_in_animation.dart';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SizedBox(
                    width: customAvatarProps.radius - rSize(4),
                    height: customAvatarProps.imageUrl!.isEmpty
                        ? customAvatarProps.radius * 0.1
                        : null,
                  ),
                  customAvatarProps.imageUrl!.isEmpty
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
                            image: customAvatarProps.defaultImage,
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: customAvatarProps.imageUrl!,
                          imageBuilder: (context, imageProvider) => Container(
                            width: customAvatarProps.radius - rSize(4),
                            height: customAvatarProps.rectangleShape
                                ? customAvatarProps.radius * 1.2 - rSize(4)
                                : customAvatarProps.radius - rSize(4),
                            decoration: BoxDecoration(
                              borderRadius: customAvatarProps.circleShape
                                  ? BorderRadius.circular(
                                      customAvatarProps.radius / 2)
                                  : BorderRadius.circular(
                                      (customAvatarProps.radius - 8) / 4),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Theme.of(context).colorScheme.background,
                            highlightColor:
                                Theme.of(context).colorScheme.onBackground,
                            child: ImagePlaceHolder(
                              width: customAvatarProps.radius - rSize(4),
                              height: customAvatarProps.rectangleShape
                                  ? customAvatarProps.radius * 1.2 - rSize(4)
                                  : customAvatarProps.radius - rSize(4),
                              borderRadius: customAvatarProps.circleShape
                                  ? customAvatarProps.radius / 2
                                  : (customAvatarProps.radius - 8) / 4,
                            ),
                          ),
                          // errorWidget: (context, url, error) => errorWidget,
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
  final bool editable;
  final String? imageUrl;
  final ImageProvider defaultImage;
  final Function? onTap;

  CustomAvatarProps({
    this.radius = 50,
    this.enable = false,
    this.editable = false,
    this.circleShape = false,
    required this.defaultImage,
    this.onTap,
    this.rectangleShape = false,
    this.imageUrl,
  });
}
