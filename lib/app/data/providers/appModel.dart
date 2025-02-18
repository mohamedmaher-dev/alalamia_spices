import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
const String _storageKey = "AlalamiahApplication_";
Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class AppModel with ChangeNotifier {
   String? _token;
   bool? isFirstSeen;
  get token => _token == null ? '' : _token;

  set token(var token){
    _token = token;
    notifyListeners();
  }

  Future<Null> checkFirstSeen() async {
    final SharedPreferences prefs = await _prefs;
    bool seen = (prefs.getBool('seen') ?? false);
    isFirstSeen=seen;
  }

  Future<Null> setFirstSeen(bool isSeen) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool('seen', true);
  }


  Future<Null> init([String? language]) async {

    if (_token == null) {
      _token = await getApplicationSavedInformation('token');
    }
    return null;
  }
  Future<String> getApplicationSavedInformation(String name) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.getString(_storageKey + name) ?? '';
  }


  Future<Null> setApplicationSavedInformation(String name, String value) async {
    final SharedPreferences prefs = await _prefs;

    prefs.setString(_storageKey + name, value);
//    _token = prefs.get(_storageKey + name);
//    print(_token);
    //prefs.setString("intro" , "false");
    notifyListeners();
  }

  ///
  /// Singleton Factory
  ///
  static final AppModel _translations =  AppModel._internal();
  factory AppModel() {
    return _translations;
  }
  AppModel._internal();
}

AppModel appModel = new AppModel();
