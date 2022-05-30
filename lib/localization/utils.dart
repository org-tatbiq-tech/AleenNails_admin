import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String english = 'English';
const String arabic = 'العربيه';
const String hebrew = 'עברית';

const String en = 'en';
const String ar = 'ar';
const String he = 'he';
List<Locale> supportedLocale = const [
  Locale(en, ''),
  Locale(ar, ''),
  Locale(he, '')
];

String getLangName(String code) {
  switch (code) {
    case en:
      return english;
    case ar:
      return arabic;
    case he:
      return hebrew;
    default:
      return english;
  }
}

const String prefSelectedLanguageCode = "SelectedLanguageCode";

Future<Locale> saveLocale(String languageCode) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString(prefSelectedLanguageCode, languageCode);
  return _locale(languageCode);
}

Future<Locale> loadLocale() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String languageCode = pref.getString(prefSelectedLanguageCode) ?? en;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  return languageCode.isNotEmpty
      ? Locale(languageCode, '')
      : const Locale(en, '');
}
