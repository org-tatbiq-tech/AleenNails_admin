import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CloseSlidableOnTap extends StatelessWidget {
  CloseSlidableOnTap({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;
  SlidableController? controller;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: Builder(builder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => {
            Slidable.of(context)?.close(),
            print(controller?.close()),
          },
          child: SlidableAutoCloseBehavior(
            child: child,
          ),
        );
      }),
    );
  }
}
