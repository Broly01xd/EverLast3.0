
import 'package:firebase_core/firebase_core.dart'
    show FirebaseOptions;
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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCiqPYngiKdVh9kws0c2SeN3NKb92M0tOY',
    appId: '1:807956604340:web:63a82aeef747df2a437ee1',
    messagingSenderId: '807956604340',
    projectId: 'everlast-561c0',
    authDomain: 'everlast-561c0.firebaseapp.com',
    storageBucket: 'everlast-561c0.appspot.com',
    measurementId: 'G-R1Y39VZTLM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA_D4HfdJQtwBJ8EneAebGtfMkgTr_gGss',
    appId: '1:807956604340:android:19f0efe70dd6b7c8437ee1',
    messagingSenderId: '807956604340',
    projectId: 'everlast-561c0',
    storageBucket: 'everlast-561c0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDbnJWPl6PM8hkz6OhG5uRZ-EZvouKMb-s',
    appId: '1:807956604340:ios:fe59576502a4c6d0437ee1',
    messagingSenderId: '807956604340',
    projectId: 'everlast-561c0',
    storageBucket: 'everlast-561c0.appspot.com',
    iosClientId:
        '807956604340-r3t9qt4pva026st3cemfqvm2ca97n68s.apps.googleusercontent.com',
    iosBundleId: 'com.example.everlast',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDbnJWPl6PM8hkz6OhG5uRZ-EZvouKMb-s',
    appId: '1:807956604340:ios:fe59576502a4c6d0437ee1',
    messagingSenderId: '807956604340',
    projectId: 'everlast-561c0',
    storageBucket: 'everlast-561c0.appspot.com',
    iosClientId:
        '807956604340-r3t9qt4pva026st3cemfqvm2ca97n68s.apps.googleusercontent.com',
    iosBundleId: 'com.example.everlast',
  );
}
