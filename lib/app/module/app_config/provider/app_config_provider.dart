

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/prefs.dart';

class AppConfigProvider extends ChangeNotifier {
  bool _splashFirstSeen = false;

  bool get splashFirstSeen => _splashFirstSeen;

  // set splashFirstSeen (bool newValue) {
  //   _splashFirstSeen = newValue;
  //   notifyListeners();
  // }

  Future saveFirstSeen() async {
    SharedPrefsService.putBool('splashSeen', true);
  }

  Future getFirstSeen() async{
    _splashFirstSeen = SharedPrefsService.getBool('splashSeen');
  }








}