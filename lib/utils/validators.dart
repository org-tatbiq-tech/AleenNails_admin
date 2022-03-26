/// general validation utils
/// Empty names, strict structure, ....

bool validateNotEmpty(String str) {
  /// Relevant for unexpected empty strings
  if (str.isEmpty) {
    return false;
  }
  return true;
}

bool validateEmail(String email) {
  /// Validating Email empty and structure <>@<>.<>
  if (validateNotEmpty(email)) {
    return false;
  }
  if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
    return true;
  }
  return false;
}
