import 'package:common_widgets/ease_in_animation.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';

class CustomCheckText extends StatefulWidget {
  final CustomCheckTextProps customCheckTextProps;
  const CustomCheckText({Key? key, required this.customCheckTextProps})
      : super(key: key);

  @override
  State<CustomCheckText> createState() => _CustomCheckTextState();
}

class _CustomCheckTextState extends State<CustomCheckText> {
  @override
  Widget build(BuildContext context) {
    return EaseInAnimation(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          color: widget.customCheckTextProps.isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: rSize(1),
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(
            rSize(5),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: rSize(10),
            vertical: rSize(6),
          ),
          child: Text(
            widget.customCheckTextProps.text.toTitleCase(),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: widget.customCheckTextProps.isSelected
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
      ),
      onTap: () => widget.customCheckTextProps.onClicked(),
    );
  }
}

class CustomCheckTextProps {
  String text;
  bool isSelected;
  Function onClicked;
  CustomCheckTextProps({
    required this.text,
    this.isSelected = false,
    required this.onClicked,
  });
}
