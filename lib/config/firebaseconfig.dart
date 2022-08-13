import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (kIsWeb) {
      // Web
      return const FirebaseOptions(
        appId: '1:446195242927:android:308c7b5aa62ade4352015a',
        apiKey: 'AAIzaSyBx98TvFTYjjixUyKDfcX7zadcJV5B1by8',
        projectId: 'meribilty-staging',
        messagingSenderId: '446195242927',
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:446195242927:ios:8f5a77f53774fe4852015a',
        apiKey: 'AIzaSyAO1SzvDnYbo4a3xGIz96Hlfpu9Je1G9V8',
        projectId: 'meribilty-staging',
        messagingSenderId: '446195242927',
        iosBundleId: 'io.flutter.plugins.firebasecoreexample',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:446195242927:android:308c7b5aa62ade4352015a',
        apiKey: 'AIzaSyBx98TvFTYjjixUyKDfcX7zadcJV5B1by8',
        projectId: 'meribilty-staging',
        messagingSenderId: '446195242927',
      );
    }
  }
}