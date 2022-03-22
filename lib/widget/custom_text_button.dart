import 'package:appointments/data_types.dart';
import 'package:appointments/utils/layout_util.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextButton extends StatelessWidget {
  final CustomTextButtonProps customTextButtonProps;
  const CustomTextButton({Key? key, required this.customTextButtonProps})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EaseInAnimation(
      onTap: customTextButtonProps.onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          customTextButtonProps.withIcon
              ? Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, rSize(10), 0),
                  child: customTextButtonProps.icon,
                )
              : const SizedBox(
                  width: 0,
                  height: 0,
                ),
          Text(
            customTextButtonProps.text,
            style: customTextButtonProps.textStyle ??
                Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: customTextButtonProps.textColor),
          ),
        ],
      ),
    );
  }
}
