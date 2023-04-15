// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBjPozY0JKocRCJNawP89qZdMP7jXOtT_s',
    appId: '1:788313607719:android:7f8a759cb6ac8b6f014802',
    messagingSenderId: '788313607719',
    projectId: 'aleennail-prod',
    storageBucket: 'aleennail-prod.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCXniWKB0qcEPQ-FM7VssSbsxmdxY1xN-M',
    appId: '1:788313607719:ios:56103145718980c6014802',
    messagingSenderId: '788313607719',
    projectId: 'aleennail-prod',
    storageBucket: 'aleennail-prod.appspot.com',
    androidClientId: '788313607719-8t6l72vvlq26kq5b5ilm3l97n5v8i216.apps.googleusercontent.com',
    iosClientId: '788313607719-lnn6f3d97b1s7gcudbd7v9mlaaq4imdn.apps.googleusercontent.com',
    iosBundleId: 'com.tatbiq.tech.aleenNailsAdmin',
  );
}
