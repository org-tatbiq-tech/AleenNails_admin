import 'package:get/utils.dart';

fullNameValidation(String fullName) {
  if (fullName.isEmpty) {
    return 'Full Name can not be empty!';
  }
  if (fullName.split(' ').length < 2) {
    return 'Please enter valid name! example: Saeed Isa';
  }
  return null;
}

mobileValidation(String mobile) {
  if (mobile.isEmpty) {
    return 'Mobile can not be empty!';
  }
  if (!RegExp("^(?:05)?[0-9]{8}").hasMatch(mobile)) {
    return 'Please Enter a valid Email.';
  }
  return null;
}

emailValidation(String email) {
  if (email.isEmpty) {
    return 'Email can not be empty!';
  }
  if (!GetUtils.isEmail(email)) {
    return 'Please enter valid email! example: hello@hello.com';
  }
  return null;
}

passwordValidation(String password) {
  if (password.isEmpty) {
    return 'Password can not be empty!';
  }
  if (password.length < 6) {
    return 'Password is too short! must be > 6';
  }
  return null;
}

confirmPasswordValidation(String password, String confirmPassword) {
  if (confirmPassword.isEmpty) {
    return 'Password can not be empty!';
  }
  if (confirmPassword.length < 6) {
    return 'Password is too short! must be > 6';
  }
  if (confirmPassword != password) {
    return 'Passwords do NOT match!';
  }
  return null;
}

String getStringPrice(double price) {
  return '₪ ' + price.toStringAsFixed(2);
}
