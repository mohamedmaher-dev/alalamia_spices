import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// SharedPreferences
class SharedPrefsService {
  static SharedPrefsService? _singleton;
  static SharedPreferences? _prefs;
  static Future<SharedPrefsService?> getInstance() async {
    if (_singleton == null) {
      if (_singleton == null) {
        // keep local instance till it is fully initialized.
        SharedPrefsService singleton = SharedPrefsService._();
        await singleton._init();
        _singleton = singleton;
      }
    }
    return _singleton;
  }

  SharedPrefsService._();

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // put object
  static Future<bool>? putObject(String key, Object value) {
    if (_prefs == null) return null;
    return _prefs!.setString(key, json.encode(value));
  }

  // get obj
  static T? getObj<T>(String key, T Function(Map v) f, {T? defValue}) {
    Map? map = getObject(key);
    return map == null ? defValue : f(map);
  }

  // get object7
  static Map<dynamic, dynamic>? getObject(String key) {
    if (_prefs == null) return null;
    String? _data = _prefs!.getString(key);
    return (_data == null || _data.isEmpty) ? null : json.decode(_data);
  }

  // put object list
  static Future<bool>? putObjectList(String key, List<Object> list) {
    if (_prefs == null) return null;
    List<String> _dataList = list.map((Object value) {
      return json.encode(value);
    }).toList();
    return _prefs!.setStringList(key, _dataList);
  }

  // get obj list
  static List<T> getObjList<T>(String key, T Function(Map? v) f,
      {List<T> defValue = const []}) {
    List<Map?>? dataList = getObjectList(key);
    List<T>? list = dataList?.map((value) {
      return f(value);
    }).toList();
    return list ?? defValue;
  }

  // get object list
  static List<Map<dynamic, dynamic>?>? getObjectList(String key) {
    if (_prefs == null) return null;
    List<String>? dataLis = _prefs!.getStringList(key);
    return dataLis?.map((String value) {
      Map<dynamic, dynamic>? _dataMap = json.decode(value);
      return _dataMap;
    }).toList();
  }

  // get string
  static String getString(String key, {String defValue = ''}) {
    return _prefs!.getString(key) ?? defValue;
  }

  // put string
  static Future<bool>? putString(String key, String? value) {
    return _prefs!.setString(key, value!);
  }

  // get bool
  static bool getBool(String key, {bool defValue = false}) {
    return _prefs!.getBool(key) ?? defValue;
  }

  // put bool
  static Future<bool>? putBool(String key, bool value) {
    return _prefs!.setBool(key, value);
  }

  // get int
  static int getInt(String key, {int defValue = 0}) {
    return _prefs!.getInt(key) ?? defValue;
  }

  // put int.
  static Future<bool>? putInt(String key, int value) {
    return _prefs!.setInt(key, value);
  }

  // get double
  static double getDouble(String key, {double defValue = 0.0}) {
    return _prefs!.getDouble(key) ?? defValue;
  }

  // put double
  static Future<bool>? putDouble(String key, double value) {
    return _prefs!.setDouble(key, value);
  }

  // get string list
  static List<String> getStringList(String key,
      {List<String> defValue = const <String>[]}) {
    return _prefs!.getStringList(key) ?? defValue;
  }

  // put string list
  static Future<bool>? putStringList(String key, List<String?> value) {
    return _prefs!.setStringList(key, value as List<String>);
  }

  // get dynamic
  static dynamic getDynamic(String key, {Object? defValue}) {
    return _prefs!.get(key) ?? defValue;
  }

  // have key
  static bool? haveKey(String key) {
    return _prefs!.getKeys().contains(key);
  }

  // get keys
  static Set<String>? getKeys() {
    return _prefs!.getKeys();
  }

  // remove
  static Future<bool>? remove(String key) {
    return _prefs!.remove(key);
  }

  // clear
  static Future<bool>? clear() {
    return _prefs!.clear();
  }

  //Sp is initialized
  static bool isInitialized() {
    return _prefs != null;
  }
}