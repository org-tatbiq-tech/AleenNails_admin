import 'package:appointments/data_types.dart';
import 'package:appointments/utils/layout_util.dart';
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
        return Theme.of(context).colorScheme.primary;
      }
      if (customButtonProps.isSecondary) {
        return Theme.of(context).colorScheme.background;
      }
      return customButtonProps.backgroundColor;
    }

    Color getTextColor() {
      if (customButtonProps.isPrimary) {
        return Theme.of(context).colorScheme.background;
      }
      if (customButtonProps.isSecondary) {
        return Theme.of(context).colorScheme.primary;
      }
      return customButtonProps.textColor;
    }

    return EaseInAnimation(
      onTap: customButtonProps.onTap,
      child: Material(
        borderRadius: BorderRadius.circular(rSize(10)),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(rSize(10)),
              color: getButtonColor(),
              border: Border.all(
                  width: rSize(1),
                  color: Theme.of(context).colorScheme.primary),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  offset: const Offset(0, 2),
                  blurRadius: 6.0,
                )
              ]),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: rSize(16), vertical: rSize(6)),
            child: customButtonProps.text.isNotEmpty
                ? Text(
                    customButtonProps.capitalizeText
                        ? customButtonProps.text.toUpperCase()
                        : customButtonProps.text,
                    style: Theme.of(context).textTheme.button?.copyWith(
                          color: getTextColor(),
                        ),
                  )
                : Icon(
                    Icons.favorite,
                    size: rSize(20),
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
          ),
        ),
      ),
    );
  }
}
