import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/ease_in_animation.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:common_widgets/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CounterButton extends StatefulWidget {
  final TextEditingController discountController;
  final int inputRangeMax;
  final int inputRangeMin;

  final int? maxLength;

  const CounterButton({
    Key? key,
    required this.discountController,
    this.inputRangeMax = 99,
    this.inputRangeMin = 0,
    this.maxLength = 2,
  }) : super(key: key);

  @override
  State<CounterButton> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
  @override
  Widget build(BuildContext context) {
    plusIconClicked() {
      if (widget.inputRangeMax >=
          int.parse(widget.discountController.text) + 1) {
        widget.discountController.text =
            (int.parse(widget.discountController.text) + 1).toString();
      }
    }

    minusIconClicked() {
      if (widget.inputRangeMin <=
          int.parse(widget.discountController.text) - 1) {
        widget.discountController.text =
            (int.parse(widget.discountController.text) - 1).toString();
      }
    }

    return Row(
      children: [
        EaseInAnimation(
          onTap: () => plusIconClicked(),
          onLongTap: () => plusIconClicked(),
          child: CustomIcon(
            customIconProps: CustomIconProps(
              icon: Icon(
                Icons.add,
                size: rSize(25),
              ),
            ),
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
            return currentChild!;
          },
          transitionBuilder: (Widget child, Animation<double> animation) {
            final Animation<double> fadeAnimation =
                Tween<double>(begin: 0.0, end: 1).animate(animation);
            if (child.key.toString() == widget.discountController.text) {
              return ClipRect(
                child: FadeTransition(opacity: fadeAnimation, child: child),
              );
            } else {
              return ClipRect(
                child: FadeTransition(opacity: fadeAnimation, child: child),
              );
            }
          },
          child: SizedBox(
            key: Key(widget.discountController.text),
            width: rSize(100),
            child: Center(
              child: TextFormField(
                controller: widget.discountController,
                cursorColor: Theme.of(context).colorScheme.primary,
                textAlign: TextAlign.center,
                autofocus: true,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(widget.maxLength),
                  FilteringTextInputFormatter.digitsOnly,
                  LimitRangeTextInputFormatter(
                      widget.inputRangeMin, widget.inputRangeMax),
                ],
                keyboardType: TextInputType.number,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
        ),
        CustomIcon(
          customIconProps: CustomIconProps(
            isDisabled: false,
            onTap: () => minusIconClicked(),
            icon: Icon(
              Icons.remove,
              size: rSize(25),
            ),
          ),
        ),
      ],
    );
  }
}
