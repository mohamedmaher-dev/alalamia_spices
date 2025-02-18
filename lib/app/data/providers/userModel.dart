import 'dart:io';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/utils/constants.dart';
import '../../core/utils/url.dart';
import '../../services/prefs.dart';
import 'package:alalamia_spices/app/exports/model.dart';

class UserModel extends QueryModel {
  UserModel(super.context);
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  String _errorEmailSignup = '';
  String _errorMessageSignup = '';
  String? userCountryId;
  String? userCountryName;
  bool _isVerification = false;

  bool _changePasswordLoading = false;
  bool get changePasswordLoading => _changePasswordLoading;
  String get errorEmailSignup => _errorEmailSignup;
  String get errorMessageSignup => _errorMessageSignup;

  set changePasswordLoading(bool value) {
    _changePasswordLoading = value;
    notifyListeners();
  }

  String _userName = "";
  String _userCurrency = "";
  String _countryId = "";
  String _userPhone = "";
  String _userEmail = "";
  String _userType ="";
  String _userImage = "";
  String? _countryImage;
  String? _countryCurrencyId;
  String _userCountry = '';
  String _shortcutCurrency = '';
  String _aramexStatus = '';
  String get userName => _userName;
  String get userCurrency => _userCurrency;
  String get countryId => _countryId;
  String get userPhone => _userPhone;
  String get userEmail => _userEmail;
  String get userType => _userType;
  String get userImage => _userImage;
  String get countryImage => _countryImage!;
  String get countryCurrencyId => _countryCurrencyId!;
  bool get isVerification => _isVerification;
  String get userCountry => _userCountry;
  String get shortcutCurrency => _shortcutCurrency;
  String get aramexStatus => _aramexStatus;

  set isVerification (bool newValue){
    _isVerification = newValue;
    notifyListeners();
  }

  @override
  Future loadData([BuildContext? context]) async {
    if (appModel.token != '' && await canLoadData()) {
      var data;
      try {
        data = await fetchDataa(AppUrl.user, "");
      } catch (e) {
        data = await fetchDataa(AppUrl.user, "");
      }

      if (data != null) {
        UserData userData = UserData.fromJson(data);
        items.add(userData.user);
        SharedPrefsService.putString("username", user.name ?? "");
        SharedPrefsService.putString("userCurrency", user.currencyName ?? "");
        SharedPrefsService.putString("countryId", user.countryId ?? "");
        SharedPrefsService.putString("userPhone", user.phone ?? "");
        SharedPrefsService.putString("userEmail", user.email ?? "");
        SharedPrefsService.putString("userType", user.userType ?? "");
        SharedPrefsService.putString("userImage", user.image ?? "");
        SharedPrefsService.putString("countryImage", user.country!.imagePath ?? "");
        SharedPrefsService.putString("countryCurrencyId", user.country!.currencyId.toString() ?? "");
        SharedPrefsService.putString("USER-CountryName", user.countryName ?? "");
        SharedPrefsService.putString("ARAMEX_STATUS", user.country!.aramexStatus ?? "");
        // prefs.setString("USER_STATUS", data['status_message'] ?? "" );
        // if (kDebugMode) {
        //   print("user infoooooooo $data");
        // }
        finishLoading();
      }
    }
  }

  User get user => items[0];

  set newUserCountryId(String value) {
    userCountryId = value;
    SharedPrefsService.putString(AppConstants.countryUserId, value);
    notifyListeners();
  }

  set newUserCountryName(String value) {
    userCountryName = value;
    SharedPrefsService.putString(AppConstants.countryUserName, value);
    notifyListeners();
  }

  Future getUserInfo() async {
    _userName = SharedPrefsService.getString("username") ?? "";
    _userCurrency = SharedPrefsService.getString("userCurrency") ?? "";
    _countryId = SharedPrefsService.getString("countryId") ?? "";
    _userPhone = SharedPrefsService.getString("userPhone") ?? "";
    _userEmail = SharedPrefsService.getString("userEmail") ?? "";
    _userType = SharedPrefsService.getString("userType") ?? "";
    _userImage = SharedPrefsService.getString("userImage") ?? "";
    _countryImage = SharedPrefsService.getString("countryImage");
    _countryCurrencyId = SharedPrefsService.getString("countryCurrencyId");
    _userCountry = SharedPrefsService.getString("USER-CountryName");
    _userCountry = SharedPrefsService.getString("USER-CountryName");
    _aramexStatus = SharedPrefsService.getString("ARAMEX_STATUS");
    if(_userCountry == "مصر - Egypt"){
      _shortcutCurrency = "EGP";
    }else if (_userCountry == "الولايات المتحدة - USA"){
      _shortcutCurrency = "USD";
    }else if (_userCountry == "الإمارات - UAE") {
      _shortcutCurrency = "AED";
    }else if (_userCountry == "السعودية - KSA"){
      _shortcutCurrency = "SAR";
    }else if (_userCountry == "اليمن - Yemen"){
      _shortcutCurrency = "YER";
    }

    // notifyListeners();
  }

  Future signUp(User user, String password, String fcm) async {
    if (await canLoadData()) {
      Map<String, dynamic> postData = user.toJson();
      postData.addAll({"password": password});
      postData.addAll({"c_password": password});
      postData.addAll({"fcm": fcm});
      try {
        if (items.isNotEmpty) items.clear();
        var data = await saveData(AppUrl.register, parameters: postData);
        if (isLoaded) {
          appModel.setApplicationSavedInformation('token', data["token"]);
          appModel.token = data["token"];
          items.add(
            User.fromJson(data),
          );
          return data;
        } else {
          _errorEmailSignup = data['email'].toString();
          _errorMessageSignup = data['message'].toString();
          debugPrint("$_errorEmailSignup");
          debugPrint("$_errorMessageSignup");

          return data;
        }
      } catch (e) {
        print(e);
      }
    }
  }

//  Future signUp(User user, String password,String fcm, {File image, String imageName}) async {
//    if (await canLoadData()) {
//      Map<String, dynamic> postData = user.toJson();
//      postData.addAll({"password": password});
//      postData.addAll({"c_password": password});
//      postData.addAll({"fcm": fcm});
//      if (imageName != null)
//        postData.addAll({
//          "image": MultipartFile.fromFileSync(image.path,filename: imageName),
//        });
//      try {
//        if (items.isNotEmpty) items.clear();
//        var data = await saveData(Url.register, parameters: postData);
//        if (isLoaded) {
//          appModel.setApplicationSavedInformation('token', data["token"]);
//          appModel.token = data["token"];
//          items.add(
//            User.fromJson(data),
//          );
//          return data;
//        }
//        return data;
//      } catch (e) {
//        print(e.toString());
//      }
//    }
//  }
  void visit() {
    try {
      appModel.setApplicationSavedInformation('token', "visitor");
      appModel.token = "visitor";
    } catch (e) {
      appModel.setApplicationSavedInformation('token', "visitor");
      appModel.token = "visitor";
      debugPrint(e.toString());
    }
  }

  Future logout() async {
    appModel.setApplicationSavedInformation('token', 'visitor');
    appModel.token = 'visitor';
    try {
      var data = await saveData(AppUrl.logout, parameters: {});
      appModel.setApplicationSavedInformation('token', 'visitor');
      appModel.token = 'visitor';
      if (isLoaded) {
        debugPrint(data);
      }
    } catch (e) {
      debugPrint(e.toString());
//      appModel.setApplicationSavedInformation('token', '');
//      appModel.token = '';
    }
  }
//  Future logout() async {
//    appModel.setApplicationSavedInformation('token', '');
//  }
//

  Future login(User user, String password, String fcm,
      [BuildContext? context]) async {
    if (await canLoadData()) {
      Map<String, dynamic> postData = user.toJson();
      postData.addAll({"password": password});
      postData.addAll({"fcm": fcm});
      try {
        var data = await saveData(AppUrl.login, parameters: postData);
        if (isLoaded) {
          appModel.setApplicationSavedInformation('token', data["token"]);
          appModel.token = data["token"];
          print(appModel.token);
          items.add(User.fromJson(data),);
          SharedPrefsService.remove("USER_STATUS");
          return data;
        } else {
          _errorMessage = data['status_message'];
          SharedPrefsService.putString("USER_STATUS", data['status_message'].toString());
          if (kDebugMode) {
            print(data['massage']);
          }
          return data;
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future delete() async {
    if (await canLoadData()) {
      Map<String, dynamic> postData = {};
      try {
        await deleteData(AppUrl.deleteAccount, parameters: postData);
        print("user data has been deleted");
      } catch (e) {
        print(e);
      }
    }
  }

//  Future edit(User user,{File image, String imageName , oldPass , newPass , confirmPass }) async {
//
//    Map<String, dynamic> postData = user.toJson();
//    postData.addAll({"_method": "PUT"});
//    postData.addAll({"old_password": oldPass});
//    postData.addAll({"password": newPass});
//    postData.addAll({"confirm_password": confirmPass});
//    if (imageName != null)
//      postData.addAll({
//        "image": MultipartFile.fromFileSync(image.path,filename: imageName),
//      });
//    try {
//      errors.clear();
//      final Dio _dio = Dio(
//        BaseOptions(
//            responseType: ResponseType.json,
//            connectTimeout: 80000,
//            receiveTimeout: 80000,
//            headers: {
//              'Authorization': 'Bearer ' + appModel.token,
//              'lang': allTranslations.currentLanguage,
//              'Content-type': 'application/json',
//            },
//            validateStatus: (code) {
//              if ((code >= 200 && code <= 300) || code == 401) {
//                return true;
//              }
//              return false;
//            }),
//      );
//      final response = await _dio.post(Url.user,
//          data: postData,
//          options: Options(headers: {
//            'Authorization': 'Bearer ' + appModel.token,
//          }));
//      //if (items.isNotEmpty) items.clear();
//
//      if (response.statusCode == 200 || response.statusCode == 201) {
//        finishLoading();
//
//        return response.data['data'];
//      } else if (response.statusCode == 401 || response.statusCode == 400) {
//        receivedError();
//        errors = response.data['error'];
////        _message = "";
////        _message = response.data['message'].toString();
////        print("=====edit user model======" + response.data['message'].toString());
////        print("=====edit user model======" + errors.toString());
//        return response.data['error'];
//      } else {
//        receivedError();
//        throw Exception('Authentication Error');
//      }
//    } on DioError catch (exception) {
//      receivedError();
//      if (exception == null ||
//          exception.toString().contains('SocketException')) {
//        throw Exception("Network Error");
//      } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
//          exception.type == DioErrorType.CONNECT_TIMEOUT) {
//        throw Exception(
//            "Could'nt connect, please ensure you have a stable network.");
//      } else {
//        return null;
//      }
//    }
//  }

  editUserInfo(User user, {File? image, String? imageName}) async {
    if (await canLoadData()) {
      Map<String, dynamic> postData = user.toJson();
      postData.addAll({"_method": "PUT"});

      if (imageName != null) {
        postData.addAll({
          "image": MultipartFile.fromFileSync(image!.path, filename: imageName),
        });
      }
      try {
        await saveData(AppUrl.user, parameters: postData);
        if (kDebugMode) {
          print(postData);
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  /// change user password ////

  Future editUserPassword(User user,
      {String? oldPass, String? newPass, String? confirmPass}) async {
    if (await canLoadData()) {
      Map<String, dynamic> postData = user.toJson();
      postData.addAll({"_method": "PUT"});
      postData.addAll({"old_password": oldPass});
      if (kDebugMode) {
        print(oldPass);
      }
      postData.addAll({"password": newPass});
      if (kDebugMode) {
        print(newPass);
      }
      postData.addAll({"confirm_password": confirmPass});
      if (kDebugMode) {
        print(confirmPass);
      }

      try {
        var data;
        data = await saveData(AppUrl.user, parameters: postData);
        if (kDebugMode) {
          print(appModel.token);
        }

        if (kDebugMode) {
          print(data);
        }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }
  }

  Future checkPhone(String phone) async {
    if (await canLoadData()) {
      try {
        Map<String, dynamic> postData = Map();
        postData.addAll({"phone": phone});
        var data = await saveData(AppUrl.phoneCheck, parameters: postData);
        if (isLoaded) {
          if (data == "User is found!") {
            return true;
          } else {
            return false;
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Future smsSendCode(String phone, String url) async {
    if (await canLoadData()) {
      Map<String, dynamic> postData = {};
      postData.addAll({"phone": phone});
      try {
        var data = await saveData(url, parameters: postData);
        return data;
      } catch (e) {}
    }
  }

  Future smsVerifyCode(String phone, String code, String url) async {
    if (await canLoadData()) {
      Map<String, dynamic> postData = {};
      postData.addAll({"phone": phone});
      postData.addAll({"code": code});
      try {
        var data = await saveData(url, parameters: postData);
        return data;
      } catch (e) {}
    }
  }

  Future smsResetPassword(
      {required String phone,
      required String code,
      required String password,
      required String passwordConfirmation}) async {
    if (await canLoadData()) {
      Map<String, dynamic> postData = {};
      postData.addAll({"phone": phone});
      print(phone);
      postData.addAll({"code": code});
      print(code);
      postData.addAll({"password": password});
      print(password);
      postData.addAll({"password_confirmation": passwordConfirmation});
      print(passwordConfirmation);
      try {
        var data =
            await saveData(AppUrl.smsResetPassword, parameters: postData);
        print(data);
      } catch (e) {}
    }
  }
}
