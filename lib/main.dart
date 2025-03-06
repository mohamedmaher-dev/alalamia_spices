import 'dart:io';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'app/alalamiah_app.dart';
import 'app/services/fcm.dart';
import 'app/services/prefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.instance.requestPermission();
  await FirebaseAppCheck.instance.activate(
      // webRecaptchaSiteKey: 'recaptcha-v3-site-key',
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.debug);
  await SharedPrefsService.getInstance();
  await appModel.init();
  await allTranslations.init();
  await FCMService.instance.init();
  HttpOverrides.global = MyHttpOverrides();
  runApp(AlalamiahApp());
}
