import 'package:appointments/utils/layout.dart';
import 'package:common_widgets/ease_in_animation.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                  padding: EdgeInsets.fromLTRB(0, 0, rSize(5), 0),
                  child: customTextButtonProps.icon,
                )
              : const SizedBox(),
          Text(
            customTextButtonProps.text,
            style: customTextButtonProps.textStyle ??
                Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: customTextButtonProps.textColor,
                    fontSize: customTextButtonProps.fontSize),
          ),
        ],
      ),
    );
  }
}

class CustomTextButtonProps {
  final String text;
  final Color? textColor;
  final double? fontSize;
  final Icon icon;
  final bool withIcon;
  final VoidCallback onTap;
  final TextStyle? textStyle;
  CustomTextButtonProps({
    this.text = '',
    this.textColor,
    this.fontSize,
    this.withIcon = false,
    this.textStyle,
    this.icon = const Icon(
      FontAwesomeIcons.plus,
      color: Colors.green,
      size: 3,
    ),
    required this.onTap,
  });
}
