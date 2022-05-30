import 'package:flutter/services.dart';

/// general validation utils
/// Empty names, strict structure, ....

String? validateNotEmpty(String str) {
  /// Relevant for unexpected empty strings
  if (str.isEmpty) {
    return 'Can not be Empty';
  }
  return null;
}

bool validateEmail(String email) {
  /// Validating Email empty and structure <>@<>.<>
  // if (validateNotEmpty(email)) {
  //   return false;
  // }
  if (RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email)) {
    return true;
  }
  return false;
}

class LimitRangeTextInputFormatter extends TextInputFormatter {
  LimitRangeTextInputFormatter(this.min, this.max) : assert(min < max);

  final int min;
  final int max;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var value = int.tryParse(newValue.text);
    if (value != null) {
      if (value < min) {
        return TextEditingValue(text: min.toString());
      } else if (value > max) {
        return TextEditingValue(text: max.toString());
      }
    }
    return newValue;
  }
}
