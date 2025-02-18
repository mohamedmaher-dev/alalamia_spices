
import 'package:alalamia_spices/app/core/utils/url.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:alalamia_spices/app/exports/model.dart';


class CouponModel extends QueryModel {
  CouponModel(super.context);
  bool _isFetching = false;
  @override
  Future loadData([BuildContext? context]) async{

    if (appModel.token != '' && await canLoadData()) {

    }
  }

  bool get isFetching => _isFetching;
  Future<bool> checkProductCoupon({String? number, String? productId}) async {
    _isFetching = true;
    notifyListeners();
    if (appModel.token != '' && await canLoadData()) {

      items.add(Coupon.fromJson(await fetchData("${AppUrl.checkProductCoupon}$number/$productId")),
      );
    }

    finishLoading();
    _isFetching = false;
    notifyListeners();
    if (errors.containsKey('number')) {
      if (kDebugMode) {
        print("error");
      }
      return false;
    } else {
      if (kDebugMode) {
        print('success');
      }
      return true;
    }
  }
  Future<bool> checkNormalCoupon({String? number}) async {
    _isFetching = true;
    notifyListeners();
    if (appModel.token != '' && await canLoadData()) {

      items.add(Coupon.fromJson(await fetchData("${AppUrl.checkNormalCoupon}$number")),
      );
    }

    finishLoading();
    _isFetching = false;
    notifyListeners();
    if (errors.containsKey('number')) {
      if (kDebugMode) {
        print("error");
      }
      return false;
    } else {
      if (kDebugMode) {
        print('success');
      }
      return true;
    }
  }
  Coupon get coupon => items[0];


  }



// class CouponModel extends QueryModel {
//
//   CouponModel(super.context);
//
//   @override
//   Future loadData([BuildContext? context , String? couponNumber , String? productId]) async{
//
//     var data;
//     try{
//       data = await fetchData("${AppUrl.checkCoupon}$couponNumber/$productId");
//
//     }catch (error) {
//       if (kDebugMode) {
//         print("CouponModel catch error$error");
//       }
//     }
//
//     if(data != null){
//       CouponData couponData = CouponData.fromJson(data);
//       List couponList = couponData.coupon as List;
//       items.addAll(couponList);
//       finishLoading();
//       if (kDebugMode) {
//         print ("=====CouponModel=====$data");
//         print ("=====CouponModel ===== ${AppUrl.checkCoupon}$couponNumber/$productId");
//       }
//     }
//
//   }
//
//   Coupon get coupon => items[0];
//
//   Future sendFlooaskPurchaseRequest(String couponNumber , String productId) async {
//     _newPurchaseId = "";
//     _transactionId = "";
//     _purchaseRequestMessage = "";
//     _purchaseRequestSuccess = false;
//     // String token =  "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMjQwM2JlMTUzNjkxZThlZDhmNjM5OGEzMDAwYzAzODVhODY0NWMwZGI4MTU3ZjUxODk4NmVkNTYyZmQ5MTg5YjczNGUzMDI1MWIxNDQzMTgiLCJpYXQiOjE2NzI1Njc3OTEsIm5iZiI6MTY3MjU2Nzc5MSwiZXhwIjoxNzA0MTAzNzkxLCJzdWIiOiIxMyIsInNjb3BlcyI6W119.C8nJG5z1s2hSQLOd10CeZNTlXmzjOxUrWX_XhHYHEuxtiPmAP4bng4dueaPLMQj7u1bY0P2EY_a9WeporPWyZ3wiCiiDiqTssa8d_G77yxmigkIOXydbhRqFIZs9MckvWkpbcftK7kg0xcX3DQY_7Vpi5ben4668arLTylV8lo6E2PAw2QSHWJSef2fS9jn6pyH5OXPoPwHQg6N8p8tKiH4-yksr6_ZeXm83gkoLO6N4gmy92n8cCxExqEsd8_H7EDBg7G8rPOrdiDrs-G_C-DmGVtMY1TQov1MGRHmfaqOECfjQn6TYvEUbOLjmL5xaVnyDlF3ZBiffpUNO7WxSFFJp7QTetwpU20lbvW2YG6a-Mm-LC7_KdvY6kDLM82AYldEihdxBvJQMHW2qtiCdn7_DM3q82UEQf2RsSOSsWxm5J1xtiTDO5lqeqCKsrau8rs4KHrJTLkMosR5Lh1Qi6GACXq4SHBPw86K_SH5ya1ulq3UjrNI6_RpUgNTyzIImofaxQSw9HRAAUl4q4_eKrf_wUAVK8v_Q0ybYzwbSzETmKElieX8_KYnv2iXc9I82M7t4_wiwFyA6Lt4jAH2oc3GiD5CyyoJRuauNi3xOPvmj5MrOEdu-j_w3D5zP4joqgz0GokwX2fi_1XqK81KPnU3OCHK86KdAWltEowwrUAA";
//
//     Map<String, dynamic> postData = Map();
//     postData.addAll({"target_phone": customerPhone});
//     postData.addAll({"amount": amount});
//     // Map<String, dynamic> _mapSendRequest = {
//     //   "customer_phone": phone,
//     //   "amount": discountModel.total.toString(),
//     // };
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
//               if ((code >= 200 && code <= 300) || code == 401) {
//                 return true;
//               }
//               return false;
//             }),
//       );
//       final response = await _dio.post(
//           Url.flooaskPurchaseRequest,
//           data: postData,
//           options: Options(headers: {
//             'Authorization': 'Bearer ' + appModel.token,
//           }));
//       //if (items.isNotEmpty) items.clear();
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         finishLoading();
//         // _errorMessage = "";
//         // _successMessage = "";
//         // _noAccountMessage = "";
//         // _responseConfirmationSuccessMessage = "";
//
//
//         if(response.data['data'] != null ){
//           _newPurchaseId = response.data['data']['id'].toString();
//           _purchaseRequestMessage = response.data['message'];
//           _purchaseRequestSuccess = response.data['is_success'];
//
//           print("====send request======= Flooask purchase_id " + response.data['data']['id'].toString());
//           print("=====send request======  flooask response message " + response.data['message']);
//           print("=====send request======  flooask all response" + response.data.toString());
//         }else{
//           _purchaseRequestMessage = response.data['message'];
//           print("=====send request======  flooask response message " + response.data['message']);
//           print("=====send request======  flooask all response" + response.data.toString());
//         }
//
//
//
//         return response.data['data'];
//       } else if (response.statusCode == 401) {
//         receivedError();
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
//       } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
//           exception.type == DioErrorType.CONNECT_TIMEOUT) {
//         throw Exception(
//             "Could'nt connect, please ensure you have a stable network.");
//       } else {
//         return null;
//       }
//     }
//   }
//
//
// }

