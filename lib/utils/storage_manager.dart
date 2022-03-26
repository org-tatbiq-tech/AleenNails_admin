import 'package:shared_preferences/shared_preferences.dart';

/// Local data storage manager, reading/writing/overriding from phone data.

void saveData(String key, dynamic value) async {
  final preferences = await SharedPreferences.getInstance();
  if (value is int) {
    preferences.setInt(key, value);
  } else if (value is String) {
    preferences.setString(key, value);
  } else if (value is bool) {
    preferences.setBool(key, value);
  }
}

Future<dynamic> readData(String key) async {
  final preferences = await SharedPreferences.getInstance();
  dynamic obj = preferences.get(key);
  return obj;
}

Future<bool> deleteData(String key) async {
  final preferences = await SharedPreferences.getInstance();
  return preferences.remove(key);
}
