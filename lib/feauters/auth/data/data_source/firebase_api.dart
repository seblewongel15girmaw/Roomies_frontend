import 'package:firebase_messaging/firebase_messaging.dart';

class FireBaseApi{
  final firebaseMessaging= FirebaseMessaging.instance;
  Future<void> initNotification( )async {
    await firebaseMessaging.requestPermission();
    final fcmToken= await firebaseMessaging.getToken();
    print("the tokens is ${fcmToken}");
  }
}