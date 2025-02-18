
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../core/utils/constants.dart';


class FCMService {
  FCMService._();

  static final FCMService instance = FCMService._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;





  Future<void> init() async {
    // For iOS
    // await _firebaseMessaging.requestPermission(
    //   alert: true,
    //   announcement: false,
    //   badge: true,
    //   carPlay: false,
    //   criticalAlert: false,
    //   provisional: false,
    //   sound: true,
    // );
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print("User provisional permission");
      }
    } else {
      if (kDebugMode) {
        print("User declined has not accepted permission");
      }
    }

  }

  Future<void> unsubscribe() async {
    await _firebaseMessaging.unsubscribeFromTopic(AppConstants.topic);
  }

  Future<void> subscribe() async {
    await _firebaseMessaging.subscribeToTopic(AppConstants.topic);
  }
}