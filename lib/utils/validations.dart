import 'package:appointments/localization/language/languages.dart';
import 'package:flutter/material.dart';

emptyValidation(String value, BuildContext context) {
  if (value.isEmpty) {
    return 'Field can not be empty!.';
  }
  return null;
}

mobileValidation(String mobile, BuildContext context) {
  if (mobile.isEmpty) {
    return 'Mobile can not be empty!.';
  }
  if (!RegExp(r"^[0-9]{10}$").hasMatch(mobile)) {
    return 'Please Enter valid mobile number.';
  }
  return null;
}

emailValidation(String email, BuildContext context) {
  if (email.isEmpty) {
    return Languages.of(context)!.emptyEmail;
  }
  if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email)) {
    return 'Please enter valid email! example: hello@mail.com.';
  }
  return null;
}

passwordValidation(String password, BuildContext context) {
  if (password.isEmpty) {
    return Languages.of(context)!.emptyPassword;
  }
  if (password.length < 6) {
    return 'Password is too short! must be > 6.';
  }
  return null;
}

confirmPasswordValidation(
    String password, String confirmPassword, BuildContext context) {
  if (confirmPassword.isEmpty) {
    return Languages.of(context)!.emptyPassword;
  }
  if (confirmPassword.length < 6) {
    return 'Password is too short! must be > 6.';
  }
  if (confirmPassword != password) {
    return Languages.of(context)!.passwordMismatch;
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
    return 'Please enter valid url';
  }
  return null;
}

priceValidation(String price, BuildContext context) {
  String pattern = r'^\d{0,8}(\.\d{1,4})?$';
  RegExp regExp = RegExp(pattern);
  if (price.isEmpty) {
    return 'Price can not be empty!.';
  }
  if (!regExp.hasMatch(price)) {
    return 'Please enter valid price';
  }
  return null;
}
