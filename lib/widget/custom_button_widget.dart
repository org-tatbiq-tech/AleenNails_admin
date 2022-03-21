import 'package:appointments/utils/layout_util.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isPrimary;
  final Color backgroundColor;
  final bool isSecondary;
  const CustomButton({
    Key? key,
    this.text = '',
    this.isPrimary = false,
    this.isSecondary = false,
    this.backgroundColor = Colors.white,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getButtonColor() {
      if (isPrimary) {
        return Theme.of(context).colorScheme.primary;
      }
      if (isSecondary) {
        return Theme.of(context).colorScheme.background;
      }
      return backgroundColor;
    }

    Color getTextColor() {
      if (isPrimary) {
        return Theme.of(context).colorScheme.background;
      }
      if (isSecondary) {
        return Theme.of(context).colorScheme.primary;
      }
      return backgroundColor;
    }

    return EaseInAnimation(
      onTap: onTap,
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
            padding: EdgeInsets.symmetric(
                horizontal: rSize(20), vertical: rSize(10)),
            child: text.isNotEmpty
                ? Text(text.toUpperCase(),
                    style: Theme.of(context).textTheme.button?.copyWith(
                          color: getTextColor(),
                        ))
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
