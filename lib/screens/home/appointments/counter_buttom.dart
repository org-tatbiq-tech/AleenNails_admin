import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_input_field.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CounterButton extends StatefulWidget {
  final TextEditingController discountController;

  const CounterButton({Key? key, required this.discountController})
      : super(key: key);

  @override
  State<CounterButton> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomIcon(
          customIconProps: CustomIconProps(
            isDisabled: false,
            onTap: () => widget.discountController.text =
                (int.parse(widget.discountController.text) + 1).toString(),
            icon: Icon(
              Icons.add,
              size: rSize(25),
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
            height: 32.0,
            child: Center(
              child: TextFormField(
                controller: widget.discountController,
                cursorColor: Theme.of(context).colorScheme.primary,
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly
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
            onTap: () => widget.discountController.text =
                (int.parse(widget.discountController.text) - 1).toString(),
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
