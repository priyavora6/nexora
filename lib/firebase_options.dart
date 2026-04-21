// lib/firebase_options.dart

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
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
          'DefaultFirebaseOptions have not been configured for windows.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // ═══════════════════════════════════════════════════════════
  // 🌐 WEB
  // ═══════════════════════════════════════════════════════════
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCM3gLDmC_ihrLAy2vFJTIooUrCweGraHI',
    appId: '1:619659937589:web:373f1367018318041e6e7c', // Note: Placeholder, re-run flutterfire configure for real web
    messagingSenderId: '619659937589',
    projectId: 'nexora-f1f3d',
    authDomain: 'nexora-f1f3d.firebaseapp.com',
    storageBucket: 'nexora-f1f3d.firebasestorage.app',
  );

  // ═══════════════════════════════════════════════════════════
  // 🤖 ANDROID - UPDATED FOR MARWADI UNIVERSITY
  // ═══════════════════════════════════════════════════════════
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCM3gLDmC_ihrLAy2vFJTIooUrCweGraHI',
    appId: '1:619659937589:android:a85069dac62eeac01e6e7c',
    messagingSenderId: '619659937589',
    projectId: 'nexora-f1f3d',
    storageBucket: 'nexora-f1f3d.firebasestorage.app',
  );

  // ═══════════════════════════════════════════════════════════
  // 🍎 iOS
  // ═══════════════════════════════════════════════════════════
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCM3gLDmC_ihrLAy2vFJTIooUrCweGraHI',
    appId: '1:619659937589:ios:9e8a7d6e5c4b3a2f1e0d9c', // Note: Placeholder
    messagingSenderId: '619659937589',
    projectId: 'nexora-f1f3d',
    storageBucket: 'nexora-f1f3d.firebasestorage.app',
    iosBundleId: 'com.marwadiuniversity.nexora',
  );

  // ═══════════════════════════════════════════════════════════
  // 🖥️ macOS
  // ═══════════════════════════════════════════════════════════
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCM3gLDmC_ihrLAy2vFJTIooUrCweGraHI',
    appId: '1:619659937589:ios:9e8a7d6e5c4b3a2f1e0d9c', // Note: Placeholder
    messagingSenderId: '619659937589',
    projectId: 'nexora-f1f3d',
    storageBucket: 'nexora-f1f3d.firebasestorage.app',
    iosBundleId: 'com.marwadiuniversity.nexora',
  );
}