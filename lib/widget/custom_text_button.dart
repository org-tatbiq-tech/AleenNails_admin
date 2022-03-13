import 'package:appointments/widget/ease_in_animation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Icon icon;
  final bool withIcon;
  final Function() onTap;
  const CustomTextButton({
    Key? key,
    this.text = '',
    this.textColor = const Color(0xFF77454e),
    this.withIcon = false,
    this.icon = const Icon(
      FontAwesomeIcons.plus,
      color: Colors.green,
      size: 3,
    ),
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EaseInAnimation(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            withIcon
                ? Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 1.w, 0),
                    child: icon,
                  )
                : const SizedBox(
                    width: 0,
                    height: 0,
                  ),
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: textColor, fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }
}
