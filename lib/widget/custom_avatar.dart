import 'package:appointments/utils/data_types.dart';
import 'package:appointments/widget/custom_icon.dart';
import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final CustomAvatarProps customAvatarProps;
  const CustomAvatar({
    Key? key,
    required this.customAvatarProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: customAvatarProps.radius,
      width: customAvatarProps.radius,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          CircleAvatar(
            backgroundImage: customAvatarProps.backgroundImage,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CustomIcon(
              customIconProps: CustomIconProps(
                color: Theme.of(context).colorScheme.primary,
                containerSize: customAvatarProps.radius / 3,
                icon: IconTheme(
                  data: Theme.of(context).iconTheme,
                  child: Icon(
                    Icons.edit,
                    size: customAvatarProps.radius / 5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
