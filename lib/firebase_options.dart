// lib/firebase_options.dart

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

  // ═══════════════════════════════════════════════════════════
  // 🌐 WEB (not configured yet)
  // ═══════════════════════════════════════════════════════════
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCjY-zuDDWI1vkEV5ZjWXaIYR-VPaMjBrI',
    appId: '1:981950903690:web:YOUR_WEB_APP_ID',
    messagingSenderId: '981950903690',
    projectId: 'nexora-8142f',
    authDomain: 'nexora-8142f.firebaseapp.com',
    storageBucket: 'nexora-8142f.firebasestorage.app',
  );

  // ═══════════════════════════════════════════════════════════
  // 🤖 ANDROID — YOUR REAL VALUES
  // ═══════════════════════════════════════════════════════════
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCjY-zuDDWI1vkEV5ZjWXaIYR-VPaMjBrI',
    appId: '1:981950903690:android:fa2921bc0b67f494b28473',
    messagingSenderId: '981950903690',
    projectId: 'nexora-8142f',
    storageBucket: 'nexora-8142f.firebasestorage.app',
  );

  // ═══════════════════════════════════════════════════════════
  // 🍎 iOS (not configured yet)
  // ═══════════════════════════════════════════════════════════
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCjY-zuDDWI1vkEV5ZjWXaIYR-VPaMjBrI',
    appId: '1:981950903690:ios:YOUR_IOS_APP_ID',
    messagingSenderId: '981950903690',
    projectId: 'nexora-8142f',
    storageBucket: 'nexora-8142f.firebasestorage.app',
    iosBundleId: 'com.example.nexora',
  );

  // ═══════════════════════════════════════════════════════════
  // 🖥️ macOS (not configured yet)
  // ═══════════════════════════════════════════════════════════
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCjY-zuDDWI1vkEV5ZjWXaIYR-VPaMjBrI',
    appId: '1:981950903690:ios:YOUR_MACOS_APP_ID',
    messagingSenderId: '981950903690',
    projectId: 'nexora-8142f',
    storageBucket: 'nexora-8142f.firebasestorage.app',
    iosBundleId: 'com.example.nexora',
  );
}