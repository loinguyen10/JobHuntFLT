import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotifications() async{
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token+$fCMToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
  Future<void> handleBackgroundMessage(RemoteMessage message)async{
      print('Title:${message.notification?.title}');
      print('Body:${message.notification?.body}');
      print('Payload:${message.data}');
  }
  Future<void> getFirebaseMessagingToken()async{
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken().then((t) {
      if(t !=null){

      }
    }
    );
  }
  void requestNotificationPermisstion() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('user granted permisson');
    }else  if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('user granted permisson');
    }else{
      print('user granted permisson');
    }
  }
  void firebaseInit(BuildContext context){
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      print('${notification?.title}');
      print('${notification?.body}');
      print('${message.data.toString()}');
    });
  }
}