import 'package:appointments/utils/layout.dart';
import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final Widget? icon;
  final Color? color;
  const CustomIcon({Key? key, this.icon, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor =
        color ?? Theme.of(context).colorScheme.primaryContainer;
    return Container(
      width: rSize(40),
      height: rSize(40),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(
            rSize(10),
          )),
      child: icon,
    );
  }
}
