import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS) {
      return const FirebaseOptions(
        appId: '1:639777193686:ios:d1a3050082a524bcba9377',
        apiKey: 'AIzaSyCu8FQNwbA8O2fqS-HyREAI3fJhQ9pcs3g',
        projectId: 'shopci',
        messagingSenderId: '639777193686',
        iosBundleId: 'com.example.shopci',
        
      );
    } else if (Platform.isAndroid) {
      return const FirebaseOptions(
        appId: '1:639777193686:android:9f208d11e9e3c8d5ba9377',
        apiKey: 'AIzaSyA5NzNjvD-KCPwJeuMB_jv-jJOuwF1MgZ4',
        projectId: 'shopci',
        messagingSenderId: '639777193686',
        storageBucket: 'shopci.appspot.com',
      );
    } else {
      // Gérer d'autres plates-formes si nécessaire
      throw UnsupportedError('Cette plate-forme n\'est pas prise en charge.');
    }
  }
}
