import 'package:alalamia_spices/app/core/utils/url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../model/aramex_shipment.dart';
import '../appModel.dart';
import '../translations.dart';

class AramexProvider with ChangeNotifier {
  Dio _dio = Dio();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _calculateLoading = false;
  bool get calculateLoading => _calculateLoading;

  String _totalAmountBeforeTax = "";
  String _taxAmount = "";
  double _deliveryPriceAramex = 0.0;

  String get totalAmountBeforeTax => _totalAmountBeforeTax;
  String get taxAmount => _taxAmount;
  double get deliveryPriceAramex => _deliveryPriceAramex;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  String _shipmentId = "";
  String get shipmentId => _shipmentId;

  
  double deliveryPrice () {
    return _deliveryPriceAramex = double.parse(_totalAmountBeforeTax) + double.parse(_taxAmount);
  }

  Future<void> calculateRate(CalculateRate calculateRate) async {
    _calculateLoading = true;
    notifyListeners();

    try {
      _dio = Dio(
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
      final response = await _dio.post(
        AppUrl.calculateRate,
        data: calculateRate.toJson(),
          options: Options(headers: {
            'Authorization': 'Bearer ' + appModel.token,
          }));

      if (response.statusCode == 200 || response.statusCode == 201) {

        debugPrint("calculate rate!!!");
        debugPrint("CalculateRate to json ${calculateRate.toJson()}");
        debugPrint("CalculateRate response ${response.data}");
        _totalAmountBeforeTax = response.data['RateDetails']['TotalAmountBeforeTax'].toString();
        _taxAmount = response.data['RateDetails']['TaxAmount'].toString();
        debugPrint("_totalAmountBeforeTax !!! $_totalAmountBeforeTax");
        debugPrint("_taxAmount !!! $_taxAmount");
        return response.data['data'];
      } else if (response.statusCode == 401) {
        _errorMessage = response.data['error'];
        return response.data['error'];
      } else {
        throw Exception('Authentication Error');
      }
    } on DioError catch (exception) {

      if (exception == null ||
          exception.toString().contains('SocketException')) {
        throw Exception("Network Error");
      } else if (exception.type == DioErrorType.receiveTimeout ||
          exception.type == DioErrorType.connectTimeout) {
        throw Exception(
            "Couldn't connect, please ensure you have a stable network.");
      } else {
        return;
      }
    } finally {
      _calculateLoading = false;
      notifyListeners();
    }
  }


  Future<void> createShipment(ShipmentData shipmentData) async {

    _isLoading = true;
    notifyListeners();

    try {
      _dio = Dio(
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
      final response = await _dio.post(
        AppUrl.createShipment,
        data: shipmentData.toJson(),
          options: Options(headers: {
            'Authorization': 'Bearer ' + appModel.token,
          }));

      if (response.statusCode == 200 || response.statusCode == 201) {

        debugPrint("shipment has been created");
        debugPrint("shipment to json ${shipmentData.toJson()}");
        if (response.data['Shipments'] != null && response.data['Shipments'].isNotEmpty) {
          _shipmentId = response.data['Shipments'][0]['ID'];
          debugPrint("Shipment ID: $_shipmentId");
        } else {
          debugPrint("No Shipments found in the response");
        }

        return response.data['data'];
      } else if (response.statusCode == 401) {
        _errorMessage = response.data['error'];
        return response.data['error'];
      } else {
        throw Exception('Authentication Error');
      }
    } on DioError catch (exception) {

      if (exception == null ||
          exception.toString().contains('SocketException')) {
        throw Exception("Network Error");
      } else if (exception.type == DioErrorType.receiveTimeout ||
          exception.type == DioErrorType.connectTimeout) {
        throw Exception(
            "Couldn't connect, please ensure you have a stable network.");
      } else {
        return;
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendAramexData({required String requestNumber, required String aramexId}) async {
    _isLoading = true;
    notifyListeners();

    try {
      _dio = Dio(
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
      final response = await _dio.post(
        AppUrl.aramexId,
        data: {
          'request_number': requestNumber,
          'aramex_id': aramexId,
        },
        options: Options(headers: {
          'Authorization': 'Bearer ' + appModel.token,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("Aramex data sent successfully");
      } else {
        throw Exception('Failed to send Aramex data');
      }
    } catch (e) {
      throw Exception('Error sending Aramex data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}