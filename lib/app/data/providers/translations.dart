import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

const String _storageKey = "MyApplication_";
const List<String> _supportedLanguages = ['en', 'ar'];
Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class GlobalTranslations with ChangeNotifier {
  Locale? _locale;
  Map<dynamic, dynamic> ?_localizedValues;
  VoidCallback? _onLocaleChangedCallback;
  Iterable<Locale> supportedLocales() => _supportedLanguages.map<Locale>((lang) => new Locale(lang, ''));

  String text(String key) {
    // Return the requested string
    return (_localizedValues == null || _localizedValues![key] == null)
        ? '** $key not found'
        : _localizedValues![key];
  }

  get currentLanguage => _locale == null ? '' : _locale!.languageCode;

  get locale => _locale;

  Future<Null> init([String? language]) async {
    if (_locale == null) {
      await setNewLanguage(language);
    }
    return null;
  }

  getPreferredLanguage() async {
    return _getApplicationSavedInformation('language');
  }

  setPreferredLanguage(String lang) async {
    return _setApplicationSavedInformation('language', lang);
  }

  Future<Null> setNewLanguage([String? newLanguage, bool saveInPrefs = false]) async {
    String? language = newLanguage;
    if (language == null) {
      language = await getPreferredLanguage();
    }

    if (language == "") {
      language = "ar";
    }
    _locale = Locale(language!, "");

    String jsonContent = await rootBundle.loadString("assets/locale/i18n_${_locale!.languageCode}.json");
    _localizedValues = json.decode(jsonContent.toString());
    if (saveInPrefs) {
      await setPreferredLanguage(language);
    }

    if (_onLocaleChangedCallback != null) {_onLocaleChangedCallback!();
    }
    notifyListeners();
    return null;
  }

  set onLocaleChangedCallback(VoidCallback callback) {
    _onLocaleChangedCallback = callback;
  }

  Future<String> _getApplicationSavedInformation(String name) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(_storageKey + name) ?? '';
  }

  Future<bool> _setApplicationSavedInformation(
      String name, String value) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setString(_storageKey + name, value);
  }

  static final GlobalTranslations _translations =  GlobalTranslations._internal();
  factory GlobalTranslations() {
    return _translations;
  }
  GlobalTranslations._internal();
}

GlobalTranslations allTranslations =  GlobalTranslations();
