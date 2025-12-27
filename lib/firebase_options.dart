import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        return android; // fallback
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // 🔹 Web config
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyDeV6DjuID5KDAnphvryGJhdVpM3Fz3aRQ",
    authDomain: "studybuddy-c7d2c.firebaseapp.com",
    projectId: "studybuddy-c7d2c",
    storageBucket: "studybuddy-c7d2c.firebasestorage.app",
    messagingSenderId: "290916704612",
    appId: "1:290916704612:web:f36d197b12f947d2009a71",
    measurementId: "G-XXXXXXX", // optional, if available
  );

  // 🔹 Android config (same project ID and sender ID)
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyDeV6DjuID5KDAnphvryGJhdVpM3Fz3aRQ",
    appId: "1:290916704612:android:abcdef123456", // replace with actual Android app ID
    messagingSenderId: "290916704612",
    projectId: "studybuddy-c7d2c",
    storageBucket: "studybuddy-c7d2c.firebasestorage.app",
  );

  // 🔹 iOS config
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyDeV6DjuID5KDAnphvryGJhdVpM3Fz3aRQ",
    appId: "1:290916704612:ios:abcdef123456", // replace with actual iOS app ID
    messagingSenderId: "290916704612",
    projectId: "studybuddy-c7d2c",
    storageBucket: "studybuddy-c7d2c.firebasestorage.app",
    iosBundleId: "com.example.studybuddy",
  );
}
