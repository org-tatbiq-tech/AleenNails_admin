import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

/// This function managing responsive size for different screens.
double rSize(double fontSize, {double standardScreenHeight = 926}) {
  double offset = Device.get().isIphoneX ? 78 : 0;
  double standardLength = Device.screenWidth > Device.screenHeight
      ? Device.screenWidth
      : Device.screenHeight;

  double deviceHeight = standardLength - offset;
  double heightPercent = (fontSize * deviceHeight) / standardScreenHeight;
  return heightPercent;
}

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}

int roundUpAbsolute(double number) {
  return number.isNegative ? number.floor() : number.ceil();
}
