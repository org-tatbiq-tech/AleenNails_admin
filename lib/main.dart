import 'package:appointments/localization/localizations_delegate.dart';
import 'package:appointments/localization/utils.dart';
import 'package:appointments/providers/appointments_mgr.dart';
import 'package:appointments/providers/auth_mgr.dart';
import 'package:appointments/providers/clients_mgr.dart';
import 'package:appointments/providers/langs.dart';
import 'package:appointments/providers/services_mgr.dart';
import 'package:appointments/providers/settings_mgr.dart';
import 'package:appointments/providers/theme_provider.dart';
import 'package:appointments/screens/home/appointments/appointment.dart';
import 'package:appointments/screens/home/appointments/discount_selection.dart';
import 'package:appointments/screens/home/clients/clients.dart';
import 'package:appointments/screens/home/main.dart';
import 'package:appointments/screens/home/notification/notifications.dart';
import 'package:appointments/screens/home/personal_settings/language_settings.dart';
import 'package:appointments/screens/home/personal_settings/notification_settings.dart';
import 'package:appointments/screens/home/personal_settings/personal_settings.dart';
import 'package:appointments/screens/home/profile/business_cover_photo.dart';
import 'package:appointments/screens/home/profile/business_details.dart';
import 'package:appointments/screens/home/profile/business_info.dart';
import 'package:appointments/screens/home/profile/business_logo.dart';
import 'package:appointments/screens/home/profile/business_workplace_photos.dart';
import 'package:appointments/screens/home/profile/profile_images.dart';
import 'package:appointments/screens/home/schedule_management/schedule_management.dart';
import 'package:appointments/screens/home/schedule_management/unavailability.dart';
import 'package:appointments/screens/home/schedule_management/working_days.dart';
import 'package:appointments/screens/home/services/services.dart';
import 'package:appointments/screens/home/settings/booking_settings.dart';
import 'package:appointments/screens/login/forget_password.dart';
import 'package:appointments/screens/login/login.dart';
import 'package:appointments/utils/secure_storage.dart';
import 'package:common_widgets/custom_loading-indicator.dart';
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
        ChangeNotifierProvider<AuthenticationMgr>(
            create: (_) => AuthenticationMgr()),
        ChangeNotifierProvider<AppointmentsMgr>(
            create: (_) => AppointmentsMgr()),
        ChangeNotifierProvider<ServicesMgr>(create: (_) => ServicesMgr()),
        ChangeNotifierProvider<ClientsMgr>(create: (_) => ClientsMgr()),
        ChangeNotifierProvider<SettingsMgr>(create: (_) => SettingsMgr()),
      ],
      child: AppointmentsApp(),
    ),
  );
}

class AppointmentsApp extends StatelessWidget {
  AppointmentsApp({Key? key}) : super(key: key);

  void initApp() {}
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Future<bool> getAutoLoginValue(AuthenticationMgr authData) async {
    String? userAutoLogin = await UserSecureStorage.getAutoLogin();
    if (userAutoLogin != null && userAutoLogin == 'true') {
      if (authData.loginState == ApplicationLoginState.loggedIn) {
        return true;
      }
    }
    return false;
  }

  Widget getInitScreen(BuildContext context, isLoggedIn) {
    // return const Landing();
    if (isLoggedIn == true) {
      return const HomeScreen();
    }
    return const LoginScreen();
  }

  Map<String, Widget Function(BuildContext)> getRoutes(BuildContext context) {
    /// Supported routes for Navigator

    return {
      '/home': (context) => const HomeScreen(),
      '/loginScreen': (context) => const LoginScreen(),
      '/clients': (context) => const Clients(),
      '/forgetPassword': (context) => const ForgetPasswordScreen(),
      '/newAppointment': (context) => const AppointmentScreen(),
      '/discountSelection': (context) => const DiscountSelection(),
      '/services': (context) => const Services(),
      '/businessInfo': (context) => const BusinessInfo(),
      '/businessDetails': (context) => const BusinessDetails(),
      '/profileImages': (context) => const ProfileImages(),
      '/businessLogo': (context) => const BusinessLogo(),
      '/businessCoverPhoto': (context) => const BusinessCoverPhoto(),
      '/businessWorkplacePhotos': (context) => const BusinessWorkplacePhotos(),
      '/scheduleManagement': (context) => const ScheduleManagement(),
      '/unavailability': (context) => const Unavailability(),
      '/workingDays': (context) => const WorkingDays(),
      '/bookingSettings': (context) => const BookingsSettings(),
      '/personalSettings': (context) => const PersonalSettings(),
      '/notificationSettings': (context) => const NotificationSettings(),
      '/languageSettings': (context) => const LanguageSettings(),
      '/notifications': (context) => const Notifications(),
      // '/registerProfile': (context) => const RegisterProfileScreen(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fbApp,
      builder: (context, appLoad) {
        if (appLoad.hasError) {
          return Center(
            child: Text(
              Languages.of(context)!.flashMessageErrorTitle,
            ),
          );
        }
        if (appLoad.hasData) {
          return Consumer2<ThemeNotifier, LocaleData>(
            builder: (context, theme, localeProv, child) => FutureBuilder(
              future: loadLocale(),
              builder: (context, locale) {
                return Consumer<AuthenticationMgr>(
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
                          routes: getRoutes(context),
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
        return CustomLoadingIndicator(
          customLoadingIndicatorProps: CustomLoadingIndicatorProps(),
        );
      },
    );
  }
}
