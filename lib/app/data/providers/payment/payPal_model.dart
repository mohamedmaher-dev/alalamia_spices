

import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/url.dart';


class PayPalModel extends QueryModel {
  PayPalModel(super.context);

  String? _accessToken;
  String _href = "";
  String _rel = "";
  String _message = "";
  String get accessToken => _accessToken!;
  String get href => _href;
  String get rel => _rel;
  String get message => _message;

  @override
  Future loadData([BuildContext? context]) async{



  }


  Future loginPayPal() async {

    Map<String, dynamic> postData = {};

    try {
      errors.clear();
      final Dio dio = Dio(
        BaseOptions(
            responseType: ResponseType.json,
            connectTimeout: 80000,
            receiveTimeout: 80000,
            headers: {
              'Authorization': 'Bearer ' + appModel.token,
              'lang': allTranslations.currentLanguage,
              'Content-type': 'application/json',
            },
            validateStatus: (code) {
              if ((code! >= 200 && code <= 300) || code == 401) {
                return true;
              }
              return false;
            }),
      );
      final response = await dio.post(
          AppUrl.loginPayPal,
          data: postData,
          options: Options(headers: {
            'Authorization': 'Bearer ' + appModel.token,
          }));
      if (items.isNotEmpty) items.clear();
      if (response.statusCode == 200 || response.statusCode == 201) {

        _accessToken = "";
        _accessToken = response.data['access_token'].toString();

        finishLoading();
        if (kDebugMode) {
          print("login paypal data ==  ${response.data}");
          print("login paypal access token ==  ${response.data['access_token']}");
        }
        return response.data['data'];
      } else if (response.statusCode == 401) {
        receivedError();
        errors = response.data['error'];
        return response.data['error'];
      } else {
        receivedError();
        throw Exception('Authentication Error');
      }
    } on DioError catch (exception) {
      receivedError();
      if (exception == null ||
          exception.toString().contains('SocketException')) {
        throw Exception("Network Error");
      } else if (exception.type == DioErrorType.receiveTimeout ||
          exception.type == DioErrorType.connectTimeout) {
        throw Exception(
            "Couldn't connect, please ensure you have a stable network.");
      } else {
        return null;
      }
    }
  }


  Future payPal({required String auth  , required String total}) async {

    Map<String, dynamic> postData = Map();
    postData.addAll({"Authorization": auth});
    postData.addAll({"price": total});
    postData.addAll({"currency": "USD"});
    try {
      errors.clear();
      final Dio dio = Dio(
        BaseOptions(
            responseType: ResponseType.json,
            connectTimeout: 80000,
            receiveTimeout: 80000,
            headers: {
              'Authorization': 'Bearer ' + appModel.token,
              'lang': allTranslations.currentLanguage,
              'Content-type': 'application/json',
            },
            validateStatus: (code) {
              if ((code! >= 200 && code <= 300) || code == 401) {
                return true;
              }
              return false;
            }),
      );
      final response = await dio.post(
          AppUrl.payPal,
          data: postData,
          options: Options(headers: {
            'Authorization': 'Bearer ' + appModel.token,
          }));
      if (items.isNotEmpty) items.clear();
      if (response.statusCode == 200 || response.statusCode == 201) {

        _rel = "";
        _href = "";
        print("post data paypal = $postData");
        print("response data paypal = ${response.data}");
        if(response.data['links'][1]['rel'] == "approval_url") {
          _href = response.data['links'][1]['href'];
          _rel = response.data['links'][1]['rel'];
          if(kDebugMode){
            print("href = ${response.data['links'][1]['href']}");
          }
        }


        finishLoading();
        if (kDebugMode) {
          print("login paypal data ==  ${response.data}");
          print("login paypal access token ==  ${response.data['access_token']}");
        }
        return response.data['data'];
      } else if (response.statusCode == 401) {
        receivedError();
        errors = response.data['error'];
        return response.data['error'];
      } else {
        receivedError();
        throw Exception('Authentication Error');
      }
    } on DioError catch (exception) {
      receivedError();
      if (exception == null ||
          exception.toString().contains('SocketException')) {
        throw Exception("Network Error");
      } else if (exception.type == DioErrorType.receiveTimeout ||
          exception.type == DioErrorType.connectTimeout) {
        throw Exception(
            "Couldn't connect, please ensure you have a stable network.");
      } else {
        return null;
      }
    }
  }



  Future executePayPal({required String auth, required String payerId}) async {

    // response if there is an error
    // {
    //   "name": "INVALID_RESOURCE_ID",
    // "message": "Requested resource ID was not found.",
    // "information_link": "https://developer.paypal.com/docs/api/payments/#errors",
    // "debug_id": "86b2c6b38c4a1"
    // }


    Map<String, dynamic> postData = Map();
    postData.addAll({"Authorization": auth});
    postData.addAll({"payer_id": payerId});
    try {
      errors.clear();
      final Dio dio = Dio(
        BaseOptions(
            responseType: ResponseType.json,
            connectTimeout: 80000,
            receiveTimeout: 80000,
            headers: {
              'Authorization': 'Bearer ' + appModel.token,
              'lang': allTranslations.currentLanguage,
              'Content-type': 'application/json',
            },
            validateStatus: (code) {
              if ((code! >= 200 && code <= 300) || code == 401) {
                return true;
              }
              return false;
            }),
      );
      final response = await dio.post(
          AppUrl.executePayPal,
          data: postData,
          options: Options(headers: {
            'Authorization': 'Bearer ' + appModel.token,
          }));
      if (items.isNotEmpty) items.clear();
      if (response.statusCode == 200 || response.statusCode == 201) {


        _message = "";
        _message = response.data['message'];
        if (kDebugMode) {
          print("execute paypal data ==  ${response.data}");
          print("execute paypal message ==  ${response.data['message']}");
        }
        // finishLoading();
        return response.data['data'];
      } else if (response.statusCode == 401) {
        receivedError();
        errors = response.data['error'];
        return response.data['error'];
      } else {
        receivedError();
        throw Exception('Authentication Error');
      }
    } on DioError catch (exception) {
      receivedError();
      if (exception == null ||
          exception.toString().contains('SocketException')) {
        throw Exception("Network Error");
      } else if (exception.type == DioErrorType.receiveTimeout ||
          exception.type == DioErrorType.connectTimeout) {
        throw Exception(
            "Couldn't connect, please ensure you have a stable network.");
      } else {
        return null;
      }
    }
  }

}