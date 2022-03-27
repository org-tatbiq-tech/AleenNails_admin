import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  const CustomContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(
            height: Device.screenHeight,
          ),
          child: child,
        ),
      ),
    );
  }
}
