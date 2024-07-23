// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyDLi1rY9vnxKWv2k7ni-9nxbQdC3sqxkqw',
    appId: '1:278903885674:web:5cb47b2915735cbde59f13',
    messagingSenderId: '278903885674',
    projectId: 'projfp3',
    authDomain: 'projfp3.firebaseapp.com',
    storageBucket: 'projfp3.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC-jr7BMmILfC5TpjF1bAPKmUqXD4HtbXU',
    appId: '1:278903885674:android:0bd2a76908ed6029e59f13',
    messagingSenderId: '278903885674',
    projectId: 'projfp3',
    storageBucket: 'projfp3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA2ari3AbKPvUAS6-ukGuGYkt4Ynq8PF2U',
    appId: '1:278903885674:ios:8fa6c6d97dd55650e59f13',
    messagingSenderId: '278903885674',
    projectId: 'projfp3',
    storageBucket: 'projfp3.appspot.com',
    iosBundleId: 'com.example.fp3',
  );
}
