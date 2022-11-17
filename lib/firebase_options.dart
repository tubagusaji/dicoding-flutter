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
      return web;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB3uEM9VGXONxUXh9dXu33V0ftTALPZQII',
    appId: '1:1060717381200:web:489ab5b2c31f1671b07355',
    messagingSenderId: '1060717381200',
    projectId: 'dicoding-flutter-d1e8e',
    authDomain: 'dicoding-flutter-d1e8e.firebaseapp.com',
    storageBucket: 'dicoding-flutter-d1e8e.appspot.com',
    measurementId: 'G-QZRCY5D1ZH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCxB1BbRD1cpBNhdCRBvc7AG-KxwjMZxU8',
    appId: '1:1060717381200:android:ce93fd2a876ac284b07355',
    messagingSenderId: '1060717381200',
    projectId: 'dicoding-flutter-d1e8e',
    storageBucket: 'dicoding-flutter-d1e8e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCTIctGc9gIDPzCvYQvjFKHrQ00kqs8re4',
    appId: '1:1060717381200:ios:a23016b903be9effb07355',
    messagingSenderId: '1060717381200',
    projectId: 'dicoding-flutter-d1e8e',
    storageBucket: 'dicoding-flutter-d1e8e.appspot.com',
    iosClientId: '1060717381200-9rr1illroopfp19d1s7gu5k66fch8c7t.apps.googleusercontent.com',
    iosBundleId: 'com.dicoding.ditonton',
  );
}
