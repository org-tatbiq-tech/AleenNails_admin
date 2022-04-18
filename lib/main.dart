import 'package:appointments/localization/localizations_delegate.dart';
import 'package:appointments/localization/utils.dart';
import 'package:appointments/providers/auth_state.dart';
import 'package:appointments/providers/langs.dart';
import 'package:appointments/providers/theme_provider.dart';
import 'package:appointments/screens/home/appointments/appointment_details.dart';
import 'package:appointments/screens/home/appointments/new_appointment.dart';
import 'package:appointments/screens/home/contacts/contact_details.dart';
import 'package:appointments/screens/home/main.dart';
import 'package:appointments/screens/home/services/new_service.dart';
import 'package:appointments/screens/home/services/services.dart';
import 'package:appointments/screens/login/forget_password.dart';
import 'package:appointments/screens/login/login.dart';
import 'package:appointments/screens/register/main.dart';
import 'package:appointments/screens/register/mobile.dart';
import 'package:appointments/screens/register/otp.dart';
import 'package:appointments/utils/secure_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'localization/language/languages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider<LocaleData>(create: (_) => LocaleData()),
        ChangeNotifierProvider<AuthenticationState>(
            create: (_) => AuthenticationState())
      ],
      child: StudiosApp(),
    ),
  );
}

class StudiosApp extends StatelessWidget {
  StudiosApp({Key? key}) : super(key: key);

  void initApp() {}
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Future<bool> getAutoLoginValue(AuthenticationState authData) async {
    String? userAutoLogin = await UserSecureStorage.getAutoLogin();

    if (userAutoLogin != null && userAutoLogin == 'true') {
      if (authData.loginState == ApplicationLoginState.loggedIn) {
        return true;
      }
    }
    return false;
  }

  Widget getInitScreen(BuildContext context, isLoggedIn) {
    return const LoginScreen();
    // if (isLoggedIn == true) {
    //   return const HomePage();
    // }
    // return const LoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fbApp,
      builder: (context, appLoad) {
        if (appLoad.hasError) {
          return Center(
            child: Text(
              Languages.of(context)!.wentWrong,
            ),
          );
        }
        if (appLoad.hasData) {
          return Consumer2<ThemeNotifier, LocaleData>(
            builder: (context, theme, localeProv, child) => FutureBuilder(
              future: loadLocale(),
              builder: (context, locale) {
                return Consumer<AuthenticationState>(
                  builder: (context, authData, _) {
                    return FutureBuilder(
                      future: getAutoLoginValue(authData),
                      builder: (context, auth) {
                        return MaterialApp(
                          builder: (context, _) {
                            var child = _!;
                            return child;
                          },
                          debugShowCheckedModeBanner: false,
                          theme: theme.getTheme(),
                          home: getInitScreen(context, auth.data),
                          routes: {
                            '/home': (context) => const HomeScreen(),
                            '/loginScreen': (context) => const LoginScreen(),
                            '/contactDetails': (context) =>
                                const ContactDetails(),
                            '/forgetPassword': (context) =>
                                const ForgetPasswordScreen(),
                            // '/resetPassword': (context) => const ResetPasswordScreen(),
                            '/register': (context) =>
                                const RegisterMainScreen(),
                            '/register/registerMobile': (context) =>
                                const RegisterMobileScreen(),
                            '/register/otpConfirmation': (context) =>
                                const RegisterOTPScreen(),
                            '/newAppointment': (context) =>
                                const NewAppointment(),
                            '/appointmentDetails': (context) =>
                                const AppointmentDetails(),
                            '/services': (context) => const Services(),
                            '/newService': (context) => const NewService(),
                            // '/registerProfile': (context) => const RegisterProfileScreen(),
                          },
                          locale: localeProv.locale,
                          supportedLocales: supportedLocale,
                          localizationsDelegates: const [
                            AppLocalizationsDelegate(),
                            GlobalMaterialLocalizations.delegate,
                            GlobalWidgetsLocalizations.delegate,
                            GlobalCupertinoLocalizations.delegate,
                          ],
                          localeResolutionCallback: (locale, supportedLocales) {
                            for (var supportedLocale in supportedLocales) {
                              if (supportedLocale.languageCode ==
                                      locale?.languageCode &&
                                  supportedLocale.countryCode ==
                                      locale?.countryCode) {
                                return supportedLocale;
                              }
                            }
                            return supportedLocales.first;
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
