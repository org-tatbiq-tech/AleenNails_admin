import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final CustomListTileProps customListTileProps;
  const CustomListTile({
    Key? key,
    required this.customListTileProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget renderTrailing() {
      return (customListTileProps.trailing ?? const SizedBox());
    }

    Widget renderLeading() {
      return (customListTileProps.leading ?? const SizedBox());
    }

    Widget renderMain() {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: customListTileProps.leading != null ? rSize(15) : 0,
        ),
        child: (Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customListTileProps.title ?? const SizedBox(),
            customListTileProps.subTitle ?? const SizedBox(),
          ],
        )),
      );
    }

    return EaseInAnimation(
      beginAnimation: 0.99,
      onTap: customListTileProps.onTap ?? () => {},
      isDisabled: !customListTileProps.enabled,
      child: Card(
        elevation: 2,
        margin:
            EdgeInsets.only(bottom: rSize(customListTileProps.marginBottom)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            rSize(10),
          ),
        ),
        child: Container(
          height: customListTileProps.height,
          padding: customListTileProps.contentPadding ??
              EdgeInsets.symmetric(
                horizontal: rSize(16),
                vertical: rSize(10),
              ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              renderLeading(),
              Expanded(child: renderMain()),
              renderTrailing(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListTileProps {
  final Widget? trailing;
  final Widget? leading;
  final Widget? title;
  final Widget? subTitle;
  final EdgeInsets? contentPadding;
  final bool enabled;
  final Function? onTap;
  final double? minLeadingWidth;
  final double? height;
  final double marginBottom;
  CustomListTileProps({
    this.trailing,
    this.leading,
    this.title,
    this.subTitle,
    this.contentPadding,
    this.enabled = true,
    this.onTap,
    this.minLeadingWidth,
    this.height,
    this.marginBottom = 0,
  });
}
