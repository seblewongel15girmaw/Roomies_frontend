import 'package:begara_mobile/core/util/sharedPreference.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FireBaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotification( )async {
    await firebaseMessaging.requestPermission();
    final fcmToken = await firebaseMessaging.getToken();
    if (fcmToken != null) {
      await SharedPreferencesService.setString("fcmToken", fcmToken);
    }
  }
}
