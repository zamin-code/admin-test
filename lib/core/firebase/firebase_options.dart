import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static const String _appId = '1:431772533087:android:8cef233c2e728b1bae76ea'; // Your App ID
  static const String _apiKey = 'AIzaSyCkkGMVzB-U77Fqe442cECOGlb_g-hjPmo'; // Your API key
  static const String _messagingSenderId = '431772533087'; // Your project number
  static const String _projectId = 'test-9fd9b'; // Your project ID
  static const String _storageBucket = 'test-9fd9b.appspot.com'; // Your Storage bucket
  // static const String _appMeasurementId = 'YOUR_APP_MEASUREMENT_ID';

  static FirebaseOptions get currentPlatform {
    if (Platform.isIOS) {
      return const FirebaseOptions(
        appId: _appId,
        apiKey: _apiKey,
        messagingSenderId: _messagingSenderId,
        projectId: _projectId,

        storageBucket: _storageBucket,
        // appMeasurementId: _appMeasurementId,
      );
    } else if (Platform.isAndroid) {
      return const FirebaseOptions(
        appId: _appId,
        apiKey: _apiKey,
        messagingSenderId: _messagingSenderId,
        projectId: _projectId,
        storageBucket: _storageBucket,

        // appMeasurementId: _appMeasurementId,
      );
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
