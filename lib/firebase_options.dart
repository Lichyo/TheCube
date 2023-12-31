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
    apiKey: 'AIzaSyBPzxEyOnuDqUVhcpyLpfBWPOBFM_BeM5Y',
    appId: '1:1017295288458:web:afb4a4affe67bc2ec55573',
    messagingSenderId: '1017295288458',
    projectId: 'cube-bddd3',
    authDomain: 'cube-bddd3.firebaseapp.com',
    databaseURL: 'https://cube-bddd3-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'cube-bddd3.appspot.com',
    measurementId: 'G-1GVYQJ41Q6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD3cfx1ByoShphV-AHYUgA9RzOr70Pl5g0',
    appId: '1:1017295288458:android:fd583b281cbb42c1c55573',
    messagingSenderId: '1017295288458',
    projectId: 'cube-bddd3',
    databaseURL: 'https://cube-bddd3-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'cube-bddd3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCGsgtLMW1qnO4vIJS6GKkU96yBUfWny_M',
    appId: '1:1017295288458:ios:0eebdd1644e2944ac55573',
    messagingSenderId: '1017295288458',
    projectId: 'cube-bddd3',
    databaseURL: 'https://cube-bddd3-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'cube-bddd3.appspot.com',
    iosBundleId: 'com.lichyo.cube',
  );
}
