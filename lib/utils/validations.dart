emptyValidation(String value) {
  if (value.isEmpty) {
    return 'Field can not be empty!.';
  }
  return null;
}

mobileValidation(String mobile) {
  if (mobile.isEmpty) {
    return 'Mobile can not be empty!.';
  }
  if (!RegExp("[0-9]{10}").hasMatch(mobile)) {
    return 'Please Enter valid mobile number.';
  }
  return null;
}

emailValidation(String email) {
  if (email.isEmpty) {
    return 'Email can not be empty!.';
  }
  if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email)) {
    return 'Please enter valid email! example: hello@mail.com.';
  }
  return null;
}

passwordValidation(String password) {
  if (password.isEmpty) {
    return 'Password can not be empty!.';
  }
  if (password.length < 6) {
    return 'Password is too short! must be > 6.';
  }
  return null;
}

confirmPasswordValidation(String password, String confirmPassword) {
  if (confirmPassword.isEmpty) {
    return 'Password can not be empty!.';
  }
  if (confirmPassword.length < 6) {
    return 'Password is too short! must be > 6.';
  }
  if (confirmPassword != password) {
    return 'Passwords do NOT match!.';
  }
  return null;
}

validateUrl(String url) {
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

priceValidation(String price) {
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
