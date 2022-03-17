import 'package:flutter_device_type/flutter_device_type.dart';

double rSize(double fontSize, {double standardScreenHeight = 926}) {
  double offset = Device.get().isIphoneX ? 78 : 0;
  double standardLength = Device.screenWidth > Device.screenHeight
      ? Device.screenWidth
      : Device.screenHeight;

  double deviceHeight = standardLength - offset;
  double heightPercent = (fontSize * deviceHeight) / standardScreenHeight;
  return heightPercent;
}
