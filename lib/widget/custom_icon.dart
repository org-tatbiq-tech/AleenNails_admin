import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomIcon extends StatelessWidget {
  final Widget? icon;
  final Color? color;
  const CustomIcon({Key? key, this.icon, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor =
        color ?? Theme.of(context).colorScheme.primaryContainer;
    return Container(
      width: 7.5.w,
      height: 7.5.w,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(3.w)),
      child: icon,
    );
  }
}
