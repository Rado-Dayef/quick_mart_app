import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBk6K-9hFx-S0S_X0N4KqbJTNaNa_WC7qw',
    appId: '1:491108337032:web:d23c7463f2aef908bf263d',
    messagingSenderId: '491108337032',
    projectId: 'quick-mart-app',
    authDomain: 'quick-mart-app.firebaseapp.com',
    storageBucket: 'quick-mart-app.appspot.com',
    measurementId: 'G-9BJGVFS5JW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCNd73Y12LAOnN7EB3nMuF3UR2RxweGiDU',
    appId: '1:491108337032:android:045b8a45808f64aabf263d',
    messagingSenderId: '491108337032',
    projectId: 'quick-mart-app',
    storageBucket: 'quick-mart-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyARae2WaY46yH5m7RsTTf2cdpVK2-g8H6c',
    appId: '1:491108337032:ios:77443281a02edb61bf263d',
    messagingSenderId: '491108337032',
    projectId: 'quick-mart-app',
    storageBucket: 'quick-mart-app.appspot.com',
    iosBundleId: 'com.example.quickMart',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyARae2WaY46yH5m7RsTTf2cdpVK2-g8H6c',
    appId: '1:491108337032:ios:ed3db749380c1450bf263d',
    messagingSenderId: '491108337032',
    projectId: 'quick-mart-app',
    storageBucket: 'quick-mart-app.appspot.com',
    iosBundleId: 'com.example.quickMart.RunnerTests',
  );
}
