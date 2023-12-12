import 'package:firebase_messaging/firebase_messaging.dart';

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
}