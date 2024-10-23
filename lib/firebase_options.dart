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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBWoAveIs64zwBPQUyhwYUOOeVgwvShzds',
    appId: '1:787858264104:web:70620ba353dbb166e0251d',
    messagingSenderId: '787858264104',
    projectId: 'chatapp-fd0a7',
    authDomain: 'chatapp-fd0a7.firebaseapp.com',
    storageBucket: 'chatapp-fd0a7.appspot.com',
    measurementId: 'G-VQM837E6MZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDm-1x_coT4o6QPUxx2obA-E7CCW4CkdBE',
    appId: '1:787858264104:android:71d9ce82b227dc8ae0251d',
    messagingSenderId: '787858264104',
    projectId: 'chatapp-fd0a7',
    storageBucket: 'chatapp-fd0a7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCazidaRttAoScGrgShvmU5uZn0pnTYsN0',
    appId: '1:787858264104:ios:5892f336efafd780e0251d',
    messagingSenderId: '787858264104',
    projectId: 'chatapp-fd0a7',
    storageBucket: 'chatapp-fd0a7.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCazidaRttAoScGrgShvmU5uZn0pnTYsN0',
    appId: '1:787858264104:ios:5892f336efafd780e0251d',
    messagingSenderId: '787858264104',
    projectId: 'chatapp-fd0a7',
    storageBucket: 'chatapp-fd0a7.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBWoAveIs64zwBPQUyhwYUOOeVgwvShzds',
    appId: '1:787858264104:web:0ce2f31e7fc9d008e0251d',
    messagingSenderId: '787858264104',
    projectId: 'chatapp-fd0a7',
    authDomain: 'chatapp-fd0a7.firebaseapp.com',
    storageBucket: 'chatapp-fd0a7.appspot.com',
    measurementId: 'G-N74GG2QEGF',
  );
}