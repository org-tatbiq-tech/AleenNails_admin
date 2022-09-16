import 'package:common_widgets/utils/layout.dart';
import 'package:common_widgets/utils/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primary = const Color(0xFFb76e79);
Color secondary = const Color(0xFF6eb7ac);
Color primaryWithAlpha1 = const Color(0xFFd3a8ae);
Color primaryWithAlpha2 = const Color(0xFFe2c5c9);
Color primaryWithAlpha3 = const Color(0xFFf0e2e4);
Color primaryFont = const Color(0xFF362124);
Color primaryFontWithAlpha1 = const Color(0xFF5b373c);

class ThemeNotifier with ChangeNotifier {
  /// Dark theme data definition
  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.red,
    primaryColor: Colors.red,
    shadowColor: Colors.black,
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

  /// Light theme data definition
  final lightTheme = ThemeData(
      brightness: Brightness.light,
      shadowColor: primaryFontWithAlpha1,
      backgroundColor: primaryWithAlpha3,
      fontFamily: GoogleFonts.openSans().fontFamily,
      dividerTheme: DividerThemeData(
        color: primary,
        thickness: rSize(1),
      ),
      cardTheme: CardTheme(
        shadowColor: primaryFontWithAlpha1,
        color: primaryWithAlpha2,
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            rSize(15),
          ),
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
        size: rSize(24),
        opacity: 1,
      ),
      primaryIconTheme: IconThemeData(
        color: primary,
        size: rSize(24),
        opacity: 1,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryWithAlpha2,
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: primaryWithAlpha2,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryWithAlpha1,
        foregroundColor: primary,
        splashColor: Colors.transparent,
      ),
      textTheme: TextTheme(
        button: TextStyle(
          color: primaryFont,
          fontWeight: FontWeight.w600,
          fontSize: rSize(16),
          fontFamily: GoogleFonts.openSans().fontFamily,
        ),
        subtitle1: TextStyle(
            color: primaryFont,
            fontWeight: FontWeight.w300,
            fontSize: rSize(14)),
        subtitle2: TextStyle(
            color: primaryFont,
            fontWeight: FontWeight.w300,
            fontSize: rSize(14),
            fontFamily: GoogleFonts.aclonica().fontFamily),
        bodyText1: TextStyle(
          color: primaryFont,
          fontWeight: FontWeight.w500,
          fontSize: rSize(16),
          fontFamily: GoogleFonts.openSans().fontFamily,
        ),
        bodyText2: TextStyle(
            color: primaryFont,
            fontWeight: FontWeight.w500,
            fontSize: rSize(16),
            fontFamily: GoogleFonts.aclonica().fontFamily),
        headline1: TextStyle(
            color: primaryFont,
            fontWeight: FontWeight.w700,
            fontSize: rSize(20)),
        headline2: TextStyle(
            color: primaryFont,
            fontWeight: FontWeight.w700,
            fontSize: rSize(20),
            fontFamily: GoogleFonts.aclonica().fontFamily),
        caption: TextStyle(
            color: primaryFont,
            fontWeight: FontWeight.w500,
            fontSize: rSize(18)),
      ),
      colorScheme: const ColorScheme.light().copyWith(
        primaryContainer: primaryWithAlpha1,
        primary: primary,
        onPrimary: primary,
        secondaryContainer: const Color(0xFF77454e),
        secondary: secondary,
        onSecondary: const Color(0xFF561723),
        background: primaryWithAlpha3,
        onBackground: primaryWithAlpha2,
        outline: primaryFontWithAlpha1,
      ));

  ThemeData? _themeData;
  ThemeData? getTheme() => _themeData;

  /// Loading theme data from storage, if not exist, then light.
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
