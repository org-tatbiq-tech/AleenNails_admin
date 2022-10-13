import 'package:flutter/material.dart';

import '../localization/utils.dart';

class LocaleData extends ChangeNotifier {
  Locale _locale = const Locale(en, '');

  LocaleData() {
    getLocale();
  }

  Future<void> getLocale() async {
    _locale = await loadLocale();
  }

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!supportedLocale.contains(locale)) return;
    _locale = locale;
    notifyListeners();
    saveLocale(_locale.languageCode);
  }
}
