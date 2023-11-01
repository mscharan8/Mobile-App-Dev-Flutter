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
    apiKey: 'AIzaSyCzbUyvnC-eeDSrerO01rzeD_vwafTUsRc',
    appId: '1:612408492430:web:a0ac470c63254bc43b24df',
    messagingSenderId: '612408492430',
    projectId: 'fp-467',
    authDomain: 'fp-467.firebaseapp.com',
    storageBucket: 'fp-467.appspot.com',
    measurementId: 'G-TH4NDSB0JQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAI-JDZ_oM6NcMrpNLYWTqphTRAR10eJGY',
    appId: '1:612408492430:android:bcb82a7602e5fd243b24df',
    messagingSenderId: '612408492430',
    projectId: 'fp-467',
    storageBucket: 'fp-467.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAPdxrWpt2ua6W9wb8m4qygOrTfxt5tWh4',
    appId: '1:612408492430:ios:08528b12044fc9dc3b24df',
    messagingSenderId: '612408492430',
    projectId: 'fp-467',
    storageBucket: 'fp-467.appspot.com',
    iosBundleId: 'com.example.finalproject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAPdxrWpt2ua6W9wb8m4qygOrTfxt5tWh4',
    appId: '1:612408492430:ios:4a064360bbb68e453b24df',
    messagingSenderId: '612408492430',
    projectId: 'fp-467',
    storageBucket: 'fp-467.appspot.com',
    iosBundleId: 'com.example.finalproject.RunnerTests',
  );
}