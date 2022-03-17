import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../utils/storage_manager.dart';

Color primary = const Color(0xFF1bc4c9);
Color primaryWithAlpha1 = const Color(0xFFa3e7e9);
Color primaryWithAlpha2 = const Color(0xFFd1f3f4);
Color primaryFont = const Color(0xFF003334);
Color primaryFontWithAlpha1 = Color(0xFF668485);

class ThemeNotifier with ChangeNotifier {
  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.red,
    primaryColor: Colors.red,
    shadowColor: Colors.lightBlue,
    colorScheme: const ColorScheme.dark()
        .copyWith(primary: Colors.red, secondary: Colors.pink),
    backgroundColor: Colors.red,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.red,
      shadowColor: Colors.lightBlue,
    ),
    scaffoldBackgroundColor: Colors.red,
    dividerColor: Colors.black12,
  );

  final lightTheme = ThemeData(
      brightness: Brightness.light,
      shadowColor: Colors.black26,
      backgroundColor: primaryWithAlpha2,
      fontFamily: GoogleFonts.openSans().fontFamily,
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 5.w,
        opacity: 1,
      ),
      primaryIconTheme: IconThemeData(
        color: primary,
        size: 5.w,
        opacity: 1,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryWithAlpha2,
      ),
      textTheme: TextTheme(
        button: TextStyle(
            color: primaryFont, fontWeight: FontWeight.w500, fontSize: 13.sp),
        subtitle1: TextStyle(
            color: primaryFont, fontWeight: FontWeight.w300, fontSize: 10.sp),
        subtitle2: TextStyle(
            color: primaryFont,
            fontWeight: FontWeight.w300,
            fontSize: 10.sp,
            fontFamily: GoogleFonts.aclonica().fontFamily),
        bodyText1: TextStyle(
            color: primaryFont, fontWeight: FontWeight.w500, fontSize: 12.sp),
        bodyText2: TextStyle(
            color: primaryFont,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
            fontFamily: GoogleFonts.aclonica().fontFamily),
        headline1: TextStyle(
            color: primaryFont, fontWeight: FontWeight.w700, fontSize: 15.sp),
        headline2: TextStyle(
            color: primaryFont,
            fontWeight: FontWeight.w700,
            fontSize: 15.sp,
            fontFamily: GoogleFonts.aclonica().fontFamily),
        caption: TextStyle(
            color: primaryFont, fontWeight: FontWeight.w500, fontSize: 13.sp),
      ),
      colorScheme: const ColorScheme.light().copyWith(
        primaryContainer: primaryWithAlpha1,
        primary: primary,
        onPrimary: primary,
        secondaryContainer: const Color(0xFF77454e),
        secondary: const Color(0xFF99737b),
        onSecondary: const Color(0xFF561723),
        background: primaryWithAlpha2,
        outline: primaryFontWithAlpha1,
      ));

  ThemeData? _themeData;
  ThemeData? getTheme() => _themeData;

  ThemeNotifier() {
    readData('themeMode').then((value) {
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        _themeData = lightTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    saveData('themeMode', 'light');
    notifyListeners();
  }
}
