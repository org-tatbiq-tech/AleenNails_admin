import 'package:appointments/utils/data_types.dart';
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
          horizontal: customListTileProps.leading != null ? rSize(20) : 0,
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
        // margin: EdgeInsets.fromLTRB(0, 0, 0, rSize(20)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            rSize(10),
          ),
        ),
        child: Container(
          height: customListTileProps.height,
          padding: customListTileProps.contentPadding ??
              EdgeInsets.symmetric(
                horizontal: rSize(20),
                vertical: rSize(10),
              ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
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
