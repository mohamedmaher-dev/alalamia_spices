//
//
// import 'package:alalamia_spices/app/core/utils/url.dart';
// import 'package:alalamia_spices/app/exports/provider.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
//
//
// class StripePaymentModel extends QueryModel {
//   StripePaymentModel(super.context);
//
//
//   String _message = "";
//   String _id = "";
//   // String _success = "";
//   bool _captured = false;
//   bool _paid = false;
//
//
//   String get message => _message;
//   String get id => _id;
//   // String get success => _success;
//   bool get captured => _captured;
//   bool get paid => _paid;
//
//   @override
//   Future loadData([BuildContext? context]) async{
//
//   }
//
//
//   Future stripeToken(
//       {required String cardNumber,
//       required String expireMonth,
//       required String expireYear,
//       required String cvcNumber,
//
//       }) async {
//
//     Map<String, dynamic> postData = Map();
//     postData.addAll({"number": cardNumber});
//     postData.addAll({"exp_month": expireMonth});
//     postData.addAll({"exp_year": expireYear});
//     postData.addAll({"cvc": cvcNumber});
//
//     // postData.addAll({"number": "5391711010033254"});
//     // postData.addAll({"exp_month": "05"});
//     // postData.addAll({"exp_year": "2024"});
//     // postData.addAll({"cvc": "995"});
//
//
//     try {
//       errors.clear();
//       final Dio _dio = Dio(
//         BaseOptions(
//             responseType: ResponseType.json,
//             connectTimeout: 80000,
//             receiveTimeout: 80000,
//             headers: {
//               'Authorization': 'Bearer ' + appModel.token,
//               'lang': allTranslations.currentLanguage,
//               'Content-type': 'application/json',
//             },
//             validateStatus: (code) {
//               if ((code! >= 200 && code <= 300) || code == 401) {
//                 return true;
//               }
//               return false;
//             }),
//       );
//       final response = await _dio.post(
//           AppUrl.stripeToken,
//           data: postData,
//           options: Options(headers: {
//             'Authorization': 'Bearer ' + appModel.token,
//           }));
//       //if (items.isNotEmpty) items.clear();
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         finishLoading();
//         _message = "";
//         _id = "";
//         if(response.data['error'] != null) {
//           _message = response.data['error']['message'].toString();
//           print("_message $_message");
//         }else {
//           _id = response.data['id'].toString();
//           print("iddd token $_id");
//         }
//
//
//
//
//
//         // if (kDebugMode) {
//         //   print("Strip payment ==  ${response.data}");
//         //   print("Strip payment message ==  ${response.data['error']['message']}");
//         //   print("Strip payment message ==  ${response.data['success']}");
//         // }
//         return response.data['data'];
//       } else if (response.statusCode == 401) {
//         receivedError();
//
//         _message = "";
//         _message = response.data['error']['message'].toString();
//
//
//         if (kDebugMode) {
//           print("Strip payment ==  ${response.data}");
//           print("Strip payment message ==  ${response.data['message']}");
//           print("Strip payment message ==  ${response.data['success']}");
//         }
//
//         errors = response.data['error'];
//         return response.data['error'];
//       } else {
//         receivedError();
//         throw Exception('Authentication Error');
//       }
//     } on DioError catch (exception) {
//       receivedError();
//       if (exception == null ||
//           exception.toString().contains('SocketException')) {
//         throw Exception("Network Error");
//       } else if (exception.type == DioErrorType.receiveTimeout ||
//           exception.type == DioErrorType.connectTimeout) {
//         throw Exception(
//             "Couldn't connect, please ensure you have a stable network.");
//       } else {
//         return null;
//       }
//     }
//   }
//
//
//
//   Future stripe({
//     required String totalAmount,
//     required String description,
//     required String currency
// }) async {
//
//     Map<String, dynamic> postData = Map();
//     postData.addAll({"amount": totalAmount});
//     postData.addAll({"description": description});
//     postData.addAll({"currency": currency});
//     postData.addAll({"id": _id});
//
//
//     try {
//       errors.clear();
//       final Dio _dio = Dio(
//         BaseOptions(
//             responseType: ResponseType.json,
//             connectTimeout: 80000,
//             receiveTimeout: 80000,
//             headers: {
//               'Authorization': 'Bearer ' + appModel.token,
//               'lang': allTranslations.currentLanguage,
//               'Content-type': 'application/json',
//             },
//             validateStatus: (code) {
//               if ((code! >= 200 && code <= 300) || code == 401) {
//                 return true;
//               }
//               return false;
//             }),
//       );
//       final response = await _dio.post(
//           AppUrl.stripe,
//           data: postData,
//           options: Options(headers: {
//             'Authorization': 'Bearer ' + appModel.token,
//           }));
//       //if (items.isNotEmpty) items.clear();
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         finishLoading();
//         if(response.data['error'] != null) {
//           _message = response.data['error']['message'].toString();
//           _captured = false;
//           _paid = false;
//           print("_message $_message");
//         }else {
//           _message = "";
//           _captured = response.data['captured'];
//           _paid = response.data['paid'];
//
//         }
//
//         return response.data['data'];
//       } else if (response.statusCode == 401) {
//         receivedError();
//
//         _message = "";
//         _message = response.data['error']['message'].toString();
//
//
//         if (kDebugMode) {
//           print("Strip payment ==  ${response.data}");
//           print("Strip payment message ==  ${response.data['message']}");
//           print("Strip payment message ==  ${response.data['success']}");
//         }
//
//         errors = response.data['error'];
//         return response.data['error'];
//       } else {
//         receivedError();
//         throw Exception('Authentication Error');
//       }
//     } on DioError catch (exception) {
//       receivedError();
//       if (exception == null ||
//           exception.toString().contains('SocketException')) {
//         throw Exception("Network Error");
//       } else if (exception.type == DioErrorType.receiveTimeout ||
//           exception.type == DioErrorType.connectTimeout) {
//         throw Exception(
//             "Couldn't connect, please ensure you have a stable network.");
//       } else {
//         return null;
//       }
//     }
//   }
//
//
//
//
// }