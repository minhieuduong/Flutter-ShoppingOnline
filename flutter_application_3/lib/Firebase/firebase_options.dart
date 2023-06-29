import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isAndroid) {
      // Android
      return const FirebaseOptions(
        appId: '1:188068081997:android:e90a54ed447a1e11b6c704',
        apiKey: 'AIzaSyCNU5-aDU2qKof5GF8Zk3xs0jJXL5ZG5c4',
        projectId: 'datashop-c5642',
        messagingSenderId: '188068081997',
      );
    } else {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:188068081997:android:e90a54ed447a1e11b6c704',
        apiKey: 'AIzaSyCNU5-aDU2qKof5GF8Zk3xs0jJXL5ZG5c4',
        projectId: 'datashop-c5642',
        messagingSenderId: '188068081997',
        iosBundleId: 'com.example.applaptop_firebase',
      );
    }
  }
}
