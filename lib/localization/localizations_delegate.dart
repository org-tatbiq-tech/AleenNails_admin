import 'package:appointments/localization/language/language_ar.dart';
import 'package:appointments/localization/language/language_en.dart';
import 'package:appointments/localization/language/language_he.dart';
import 'package:appointments/localization/utils.dart';
import 'package:flutter/material.dart';

import 'language/languages.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => [en, ar, he].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case en:
        return LanguageEn();
      case ar:
        return LanguageAr();
      case he:
        return LanguageHe();
      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => true;
}
