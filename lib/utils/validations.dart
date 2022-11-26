import 'package:appointments/localization/language/languages.dart';
import 'package:flutter/material.dart';

emptyValidation(String value, BuildContext context) {
  if (value.isEmpty) {
    return Languages.of(context)!.validationEmptyFieldError;
  }
  return null;
}

mobileValidation(String mobile, BuildContext context) {
  if (mobile.isEmpty) {
    return Languages.of(context)!.validationEmptyMobileError;
  }
  if (!RegExp(r"^[0-9]{10}$").hasMatch(mobile)) {
    return Languages.of(context)!.validationMobileInvalidError;
  }
  return null;
}

emailValidation(String email, BuildContext context) {
  if (email.isEmpty) {
    return Languages.of(context)!.validationEmptyEmailError;
  }
  if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email)) {
    return Languages.of(context)!.validationEmailInvalidError;
  }
  return null;
}

passwordValidation(String password, BuildContext context) {
  if (password.isEmpty) {
    return Languages.of(context)!.validationEmptyPasswordError;
  }
  if (password.length < 6) {
    return Languages.of(context)!.validationPasswordInvalidError;
  }
  return null;
}

confirmPasswordValidation(
    String password, String confirmPassword, BuildContext context) {
  if (confirmPassword.isEmpty) {
    return Languages.of(context)!.validationEmptyPasswordError;
  }
  if (confirmPassword.length < 6) {
    return Languages.of(context)!.validationPasswordInvalidError;
  }
  if (confirmPassword != password) {
    return Languages.of(context)!.validationMismatchingPasswordError;
  }
  return null;
}

validateUrl(String url, BuildContext context) {
  if (url.isEmpty) {
    return null;
  }
  String pattern =
      r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
  RegExp regExp = RegExp(pattern);
  if (!regExp.hasMatch(url)) {
    return Languages.of(context)!.validationURLInvalidError;
  }
  return null;
}

priceValidation(String price, BuildContext context) {
  String pattern = r'^\d{0,8}(\.\d{1,4})?$';
  RegExp regExp = RegExp(pattern);
  if (price.isEmpty) {
    return Languages.of(context)!.validationEmptyPriceError;
  }
  if (!regExp.hasMatch(price)) {
    return Languages.of(context)!.validationPriceInvalidError;
  }
  return null;
}
