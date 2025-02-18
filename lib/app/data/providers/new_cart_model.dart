// import 'package:alalamia_spices/app/core/utils/constants.dart';
// import 'package:alalamia_spices/app/exports/provider.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import '../../core/utils/url.dart';
// import '../../module/product_details/product_details_screen.dart';
// import '../classes/new_cart.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
//
// class NewCartModel extends QueryModel {
//
//   // String? cartID;
//   NewCartModel(super.context ,
//       // {this.cartID}
//       );
//
//
//   String _cartId = "";
//   // double _total = 0;
//   // double get total => _total;
//   String get cartId => _cartId;
//   double _totalPrice = 0;
//   double get totalPrice => _totalPrice;
//   int _count = 0;
//   int get count => _count;
//
//   @override
//   Future loadData([BuildContext? context]) async{
//       try{
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         cartID = prefs.getString('cart_id') ?? "";
//         List cartList = await fetchData("${AppUrl.getCartDetails}$cartID");
//         items.addAll(cartList.map((cartItems) => NewCart.fromJson(cartItems)).toList());
//         _count = cartList.length;
//       finishLoading();
//       }
//       catch (error){
//         if (kDebugMode){
//           print("cart error $errors");
//         }
//       }
//       _totalPrice = items.map<double>((item) => double.parse(item.quantity.toString())* double.parse(item.price)).reduce((value1, value2) => value1+value2);
//     }
//
//
//   NewCart get newCartItems => items[0];
//
//   Future addNewCart() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     Map<String, dynamic> postData = Map();
//
//     try {
//       errors.clear();
//       final Dio dio = Dio(
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
//       final response = await dio.post(
//           AppUrl.addNewCart,
//           data: postData,
//           options: Options(headers: {
//             'Authorization': 'Bearer ' + appModel.token,
//           }));
//       if (items.isNotEmpty) items.clear();
//       if (response.statusCode == 200 || response.statusCode == 201) {
//
//         await prefs.setString("cart_id", response.data['cart_id'].toString());
//         _cartId = prefs.getString('cart_id') ?? "";
//         finishLoading();
//         if (kDebugMode) {
//           print("add new cart data ==  ${response.data}");
//           print("cart id ==  ${response.data['cart_id']}");
//         }
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
//   Future addToCart(
//       {required String priceId,
//         required String quantity,
//         required String type,
//         required String cartId,
//         required String name ,
//         required String branchId,
//         required String image,
//         required String addAr,
//          String? cartDetailsId,
//       }) async {
//     Map<String, dynamic> postData = Map();
//     postData.addAll({"id": priceId});
//     postData.addAll({"quantity": quantity});
//     postData.addAll({"type": type});
//     postData.addAll({"cart_id": cartId});
//     postData.addAll({"name": name});
//     postData.addAll({"branchId": branchId});
//     postData.addAll({"image": image});
//     postData.addAll({"addAr": addAr});
//
//     try {
//       errors.clear();
//       final Dio dio = Dio(
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
//       final response = await dio.post(
//           AppUrl.cartDetails,
//           data: postData,
//           options: Options(headers: {
//             'Authorization': 'Bearer ' + appModel.token,
//           }));
//       if (items.isNotEmpty) items.clear();
//       if (response.statusCode == 200 || response.statusCode == 201) {
//
//         var item = NewCart.fromJson(response.data);
//         // await increaseQuantity(item, type, int.parse(quantity) ,  );
//         if (kDebugMode) {
//           print(" cart details response ==  ${response.data}");
//           print("cart id ==  ${response.data['cart_id']}");
//         }
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
//   Future increaseQuantity(NewCart cartItem, String type, String quantity, String cartDetailsId) async {
//
//       Map<String, dynamic> postData = Map();
//       postData.addAll({"quantity": quantity});
//           try {
//             if (items.isNotEmpty) items.clear();
//             var data = await editData("${AppUrl.getCartDetails}$cartDetailsId", parameters: postData);
//             if (isLoaded) {
//               return data;
//             }
//           } catch (e) {
//             if (kDebugMode) {
//               print(e);
//             }
//           }
//
//     notifyListeners();
//   }
//
//   /*
//   *  function used to decrement specific item in cart
//   *  function parameters :-
//   *  carItem Object,
//   *  type String (example:- product , offer , special),
//   * */
//
//   // Future decrement(NewCart cartItem, String type) async {
//   //   //find item  in cart
//   //   final finder = Finder(filter: Filter.and([Filter.equals("id", cartItem.id), Filter.equals("type", type)]));
//   //   var count = int.parse(cartItem.quantity!);
//   //   if (count != null) {
//   //     count -= 1;
//   //   }
//   //   cartItem.quantity = count.toString();
//   //   await _cartFolder.update(await _db, cartItem.toJson(), finder: finder);
//   //   await loadData();
//   //   notifyListeners();
//   // }
//
//   /*
//   *  function used to delete specific item in cart
//   *  function parameters :-
//   *  carItem Object,
//   *  type String (example:- product , offer , special),
//   * */
//
//   // Future delete(NewCart cartItem, String type) async {
//   //   //find item  in cart
//   //   final finder = Finder(filter: Filter.and([Filter.equals("id", cartItem.id), Filter.equals("type", type)]));
//   //   await _cartFolder.delete(await _db, finder: finder);
//   //   _count -= 1;
//   //   await loadData();
//   //   notifyListeners();
//   // }
//
//   deleteSingleProduct(NewCart newCart, String id) async {
//     if (await canLoadData()) {
//       Map<String, dynamic> postData = newCart.toJson();
//       try {
//         await deleteData(AppUrl.deleteCartDetails + id, parameters: postData);
//       } catch (e) {
//         if (kDebugMode) {
//           print(e);
//         }
//       }
//     }
//   }
//   Future sendCart(NewCartList cartList) async {
//     Map<String, dynamic> postData = cartList.toJson();
//     try {
//       var data = await saveDataWithoutFormData(AppUrl.newCart, parameters: postData);
//       if (kDebugMode) {
//         print(data);
//       }
//       return data;
//     } catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//     }
//   }
//
// }
//
// class NewCartList {
//   final List<NewCart>? items;
//   NewCartList({this.items});
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['item'] = this.items;
//     return data;
//   }
// }