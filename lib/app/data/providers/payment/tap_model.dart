import 'dart:convert';
import 'package:alalamia_spices/app/exports/provider.dart' show QueryModel, allTranslations, appModel;
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/url.dart';

class TapModel extends QueryModel {
  TapModel(super.context);

  String _tapId = '';
  String _chargeId = '';
  String _errorDescription = '';
  String _chargeStatus = '';
  String _transactionUrl = '';

  String get tapId => _tapId;
  String get transactionUrl => _transactionUrl;
  String get chargeId => _chargeId;
  String get chargeStatus => _chargeStatus;
  String get errorDescription => _errorDescription;

  @override
  Future loadData([BuildContext? context]) async{

  }

  Future createCharge({required String amount  , required String currency}) async {

    Map<String, dynamic> postData = {};
    postData.addAll({"amount": amount});
    postData.addAll({"currency": currency});
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
          AppUrl.createCharge,
          data: postData,
          options: Options(headers: {
            'Authorization': 'Bearer ' + appModel.token,
          }));
      if (items.isNotEmpty) items.clear();
      if (response.statusCode == 200 || response.statusCode == 201) {
        if(response.data['id'] != null){
          _tapId = response.data['id']; // charge id
          SharedPrefsService.remove("CHARGE_ID");
          SharedPrefsService.putString("CHARGE_ID", response.data['id']);
          _transactionUrl = response.data['transaction']['url'];
          debugPrint("tap id = $_tapId");
          debugPrint("transaction url = $_transactionUrl");
        }else {
          _errorDescription = response.data['errors'][0]['description'];
          debugPrint("errorDescription = $_errorDescription");
        }
        finishLoading();

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

  Future getRetrieveCharge () async{
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
    try {
      final response = await dio.get("${AppUrl.retrieveCharge}?tap_id=$_tapId",
          queryParameters: {},
          options: Options(headers: {
            'Authorization': 'Bearer ' + appModel.token,
          }));
      if (items.isNotEmpty) items.clear();

      if (errors.isNotEmpty) errors.clear();
      if (response.statusCode == 200 || response.statusCode == 201) {
        // debugPrint("chaaaaaaarge ${response.data}");
        var decodedResponse = jsonDecode(response.data);
        _chargeStatus = decodedResponse['status'];
        _chargeId = decodedResponse['id'];

        debugPrint("charge status $_chargeStatus");
        debugPrint("tap id $_tapId");
        debugPrint("charge id $_chargeId");

        finishLoading();
        return response.data;
      } else if (response.statusCode == 401) {
        if (response.data['error']["massage"] == "Unauthorized") {
          appModel.setApplicationSavedInformation('token', '');
        }
        receivedError();
        errors = response.data['error'];
        return errors;
      } else {
        receivedError();
        throw Exception('Authentication Error');
      }
    } on DioError catch (exception) {
      if (exception == null ||
          exception.toString().contains('SocketException')) {
        throw Exception("Network Error");
      } else if (exception.type == DioErrorType.receiveTimeout ||
          exception.type == DioErrorType.connectTimeout) {
      } else {
        return [];
      }
    }
  }



}

// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
//
// class PaymentService {
//   final Dio _dio = Dio();
//
//   PaymentService() {
//     _dio.options.baseUrl = "https://api.tap.company/v2";
//     _dio.options.headers = {
//       "Authorization": "Bearer ${dotenv.env['TAP_PAYMENT_API_KEY']}",
//       'accept': 'application/json',
//       "Content-Type": "application/json"
//     };
//     debugPrint("TAP API Key: ${dotenv.env['TAP_PAYMENT_API_KEY']}");
//     _dio.interceptors.add(LogInterceptor(
//       request: true,
//       requestBody: true,
//       responseBody: true,
//       error: true,
//     ));
//   }
//
//   // Tokenize Card Data
//   Future<String> tokenizeCard(Map<String, dynamic> cardData) async {
//     try {
//       Response response = await _dio.post("/tokens", data: {
//         "card": cardData,
//         "customer" : {
//       "first_name": "test",
//       "middle_name": "test",
//       "last_name": "test",
//       "email": "test@test.com",
//       "phone": {
//       "country_code": "965",
//       "number": "50000000"
//       }},
//       });
//       return response.data["id"]; // Return the token ID (source)
//     } catch (e) {
//       debugPrint("Tokenization Error: $e");
//       throw Exception("Failed to tokenize card.");
//     }
//   }
//
//   // Create Payment
//   Future<dynamic> createPayment(Map<String, dynamic> paymentData) async {
//     try {
//       Response response = await _dio.post("/charges", data: paymentData);
//
//       if (response.statusCode == 200) {
//         return response.data;
//       } else {
//         throw Exception("Failed to create payment: ${response.data}");
//       }
//     } catch (e) {
//       debugPrint("Payment Error: $e");
//       throw Exception("Failed to create payment.");
//     }
//   }
// }
//
//
// class TapPaymentProvider with ChangeNotifier {
//   final PaymentService _paymentService = PaymentService();
//
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//
//   Future<void> makePayment(Map<String, dynamic> cardData, double amount, String currency) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       // Step 1: Tokenize the Card
//       final tokenId = await _paymentService.tokenizeCard(cardData);
//
//       // Step 2: Create the Payment
//       final paymentData = {
//         "amount": amount,
//         "currency": currency,
//         "description": "Test Payment",
//         "source": {"id": tokenId}, // Use the tokenized card ID
//         "save_card": cardData["save_card"],
//         "customer": {
//           "first_name": "test",
//           "middle_name": "test",
//           "last_name": "test",
//           "email": "test@test.com",
//           "phone": {
//             "country_code": 965,
//             "number": 51234567
//           }
//         },
//         "redirect": {
//           "url": "http://your_website.com/redirect_url"
//         }
//       };
//       final response = await _paymentService.createPayment(paymentData);
//       debugPrint("Payment Successful: $response");
//     } catch (e) {
//       debugPrint("Payment Failed: $e");
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }