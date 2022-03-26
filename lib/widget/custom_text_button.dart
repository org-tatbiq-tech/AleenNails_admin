import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final CustomTextButtonProps customTextButtonProps;
  const CustomTextButton({Key? key, required this.customTextButtonProps}) : super(key: key);

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
              : const SizedBox(),
          Text(
            customTextButtonProps.text,
            style: customTextButtonProps.textStyle ??
                Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: customTextButtonProps.textColor, fontSize: customTextButtonProps.fontSize),
          ),
        ],
      ),
    );
  }
}
