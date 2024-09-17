import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static const String _appId = '1:173094524096:android:6901a6bd21ec1965d70925'; // Your App ID
  static const String _apiKey = 'AIzaSyBTAgKOI16TsPQ9TJ6Y9SegLPgpwZfGvg8'; // Your API key
  static const String _messagingSenderId = '173094524096'; // Your project number
  static const String _projectId = 'chai-df164'; // Your project ID
  static const String _storageBucket = 'chai-df164.appspot.com'; // Your Storage bucket
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
