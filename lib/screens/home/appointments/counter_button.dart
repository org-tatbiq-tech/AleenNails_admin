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
  final bool fadeAnimation;

  final int? maxLength;

  const CounterButton({
    Key? key,
    required this.discountController,
    this.inputRangeMax = 99,
    this.inputRangeMin = 0,
    this.maxLength = 2,
    this.fadeAnimation = false,
  }) : super(key: key);

  @override
  State<CounterButton> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
  bool plusClicked = false;

  @override
  Widget build(BuildContext context) {
    plusIconClicked() {
      setState(() {
        plusClicked = true;
      });
      if (widget.inputRangeMax >=
          int.parse(widget.discountController.text) + 1) {
        widget.discountController.text =
            (int.parse(widget.discountController.text) + 1).toString();
      }
    }

    minusIconClicked() {
      setState(() {
        plusClicked = false;
      });
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
            final Animation<Offset> inAnimation =
                Tween<Offset>(begin: const Offset(0.5, 0.0), end: Offset.zero)
                    .animate(animation);
            final Animation<Offset> outAnimation =
                Tween<Offset>(begin: const Offset(-0.5, 0.0), end: Offset.zero)
                    .animate(animation);
            final Animation<double> fadeAnimation =
                Tween<double>(begin: 0.0, end: 1).animate(animation);
            if (widget.fadeAnimation) {
              return ClipRect(
                child: FadeTransition(opacity: fadeAnimation, child: child),
              );
            }
            if (plusClicked) {
              return ClipRect(
                child: SlideTransition(position: inAnimation, child: child),
              );
            }
            return ClipRect(
              child: SlideTransition(position: outAnimation, child: child),
            );
          },
          child: SizedBox(
            key: Key(widget.discountController.text),
            width: rSize(80),
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
