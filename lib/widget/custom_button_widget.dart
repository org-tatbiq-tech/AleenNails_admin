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
        if (customButtonProps.isDisabled) {
          return customButtonProps.backgroundColor?.withOpacity(0.5) ??
              Theme.of(context).colorScheme.primary.withOpacity(0.5);
        }
        return customButtonProps.backgroundColor ??
            Theme.of(context).colorScheme.primary;
      }
      return Colors.transparent;
    }

    Color getBorderColor() {
      if (customButtonProps.isPrimary) {
        return customButtonProps.borderColor ??
            customButtonProps.backgroundColor ??
            Theme.of(context).colorScheme.background;
      }
      return customButtonProps.borderColor ??
          Theme.of(context).colorScheme.primary;
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
      isDisabled: customButtonProps.isDisabled,
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
            color: customButtonProps.isDisabled
                ? getBorderColor().withOpacity(0.5)
                : getBorderColor(),
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
                    color: customButtonProps.isDisabled
                        ? getTextColor().withOpacity(0.5)
                        : getTextColor(),
                  ),
            )),
      ),
    );
  }
}

class CustomButtonProps {
  final String text;
  final VoidCallback onTap;
  final bool isPrimary;
  final bool isDisabled;
  final bool capitalizeText;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final bool isSecondary;
  final double beginAnimation;
  CustomButtonProps({
    this.text = '',
    this.isPrimary = true,
    this.isSecondary = false,
    this.capitalizeText = true,
    this.isDisabled = false,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.beginAnimation = 0.99,
    required this.onTap,
  });
}
