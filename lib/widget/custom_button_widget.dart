import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final CustomButtonProps customButtonProps;

  const CustomButton({
    Key? key,
    required this.customButtonProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getButtonColor() {
      if (customButtonProps.isPrimary) {
        return customButtonProps.backgroundColor ??
            Theme.of(context).colorScheme.primary;
      }
      return Theme.of(context).colorScheme.background;
    }

    Color getBorderColor() {
      if (customButtonProps.isPrimary) {
        return customButtonProps.backgroundColor ??
            Theme.of(context).colorScheme.background;
      }
      return Theme.of(context).colorScheme.primary;
    }

    Color getTextColor() {
      if (customButtonProps.isPrimary) {
        return customButtonProps.textColor ??
            Theme.of(context).colorScheme.background;
      }
      return customButtonProps.textColor ??
          customButtonProps.backgroundColor ??
          Theme.of(context).colorScheme.primary;
    }

    return EaseInAnimation(
      beginAnimation: customButtonProps.beginAnimation,
      onTap: customButtonProps.onTap,
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(
          minWidth: rSize(100),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(rSize(10)),
          color: getButtonColor(),
          border: Border.all(
            width: rSize(1),
            color: getBorderColor(),
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Theme.of(context).shadowColor,
          //     offset: const Offset(0, 2),
          //     blurRadius: 3.0,
          //   )
          // ],
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: rSize(16), vertical: rSize(10)),
            child: Text(
              customButtonProps.capitalizeText
                  ? customButtonProps.text.toUpperCase()
                  : customButtonProps.text,
              style: Theme.of(context).textTheme.button?.copyWith(
                    color: getTextColor(),
                  ),
            )),
      ),
    );
  }
}
