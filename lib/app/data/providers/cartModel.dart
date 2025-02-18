// import 'package:alalamia_spices/app/exports/provider.dart';
// import 'package:alalamia_spices/app/exports/model.dart';
// import 'package:flutter/material.dart';
// import 'package:sembast/sembast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../core/utils/url.dart';
//
//
//
// /*
// * App Cart Model
// * Use sembast db to store cart items
// * functions used:-
// * loadDate
// * addToCart
// * increment
// * decrement
// * delete
// * deleteAll
// * sendCart
// * findDifferent
// * */
//
// class CartModel extends QueryModel {
//
//   CartModel(super.context);
//   bool _showPaidAdds = false;
//   bool _showFreeAdds = true;
//   bool _combined = false;
//   bool _combined2 = false;
//   int _selectedPaidAdds = 0;
//   String _cartItemsQuantity = "";
//
//   int get selectedPaidAdds => _selectedPaidAdds;
//   bool get showPaidAdds => _showPaidAdds;
//   bool get showFreeAdds => _showFreeAdds;
//   bool get combined => _combined;
//   bool get combined2 => _combined2;
//   String get cartItemsQuantity => _cartItemsQuantity;
//
//   // set selectedPrice (newValue){
//   //   _selectedPrice = newValue;
//   //   notifyListeners();
//   // }
//   set selectedPaidAdds (newValue){
//     _selectedPaidAdds = newValue;
//     notifyListeners();
//   }
//
//   set showPaidAdds (bool newValue){
//     _showPaidAdds = newValue;
//     notifyListeners();
//   }
//   set showFreeAdds (bool newValue){
//     _showFreeAdds = newValue;
//     notifyListeners();
//   }
//   set combined (bool newValue){
//     _combined = newValue;
//     notifyListeners();
//   }
//   set combined2 (bool newValue){
//     _combined2 = newValue;
//     notifyListeners();
//   }
//
//   set cartItemsQuantity (String newValue){
//     _cartItemsQuantity = newValue;
//     notifyListeners();
//   }
//
//
//   var _cartFolder = intMapStoreFactory.store(appModel.token);
//
//   var store = intMapStoreFactory.store(appModel.token);
//
//
//   Future<Database> get _db async => await AppDatabase.instance.database;
//   int _count = 0;
//   double _totalPrice = 0;
//   int _totalQuantity = 0; // Add this variable
//
//   // Add a getter for totalQuantity
//   int get totalQuantity => _totalQuantity;
//
//   // Add a setter for totalQuantity (optional, if needed)
//   set totalQuantity(int newValue) {
//     _totalQuantity = newValue;
//     notifyListeners();
//   }
//
//   @override
//   Future loadData([BuildContext? context]) async {
//
//     // check if items is empty if not clear items so items will not be repeated
//     if (items.isNotEmpty) items.clear();
//     final recordSnapshot = await _cartFolder.find(await _db); // to find cart file
//     var data = recordSnapshot.map((snapshot) { //fetch cart
//       final cart = CartItem.fromJson(snapshot.value);
//       return cart;
//     }).toList();
//     if(items != null) {
//
//       items.addAll(data);
//     }
//
//     _count = items.length;
//     //calculate cart total price
//     _totalPrice = items.map((entry) => double.parse(entry.price) * (int.parse(entry.quantity) ?? 0)).fold(0, (value, element) => value! + element) ?? 0;
//     _totalQuantity = items.fold(0, (sum, item) => sum + int.parse(item.quantity ?? '0'));
//     finishLoading();
//   }
//
//   CartItem get cartItem => items[0];
//   int get nCount => _count;
//   // int get productCount => _productCount;
//   double get totalPrice => _totalPrice;
//
//
//   /*
//   *  function used to add new item in cart
//   *  function parameters :-
//   *  carItem Object
//   *  type String (example:- product , offer , special)
//   * */
//   Future addToCart({
//     required CartItem cartItem,
//     required String type,
//     String? branch_id,
//   }
//       // String area_id,
//       ) async {
//     //find item in cart
//     final finder = Finder(filter: Filter.and([Filter.equals("id", cartItem.id), Filter.equals("type", type)]));
//     var records = await _cartFolder.findFirst(await _db, finder: finder); // fetch item if exit in finder
//     debugPrint(cartItem.toString());
//
//     Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//     final SharedPreferences prefs = await _prefs;
//
//     prefs.setString("branchId", branch_id ?? "2");
//     // prefs.setString("AreaId", area_id);
//
//
//     if (records != null) { // if item exit call increment function
//       var item = CartItem.fromJson(records.value);
//       await increment(item, type, int.parse(cartItem.quantity!));
//     } else {
//       await _cartFolder.add(await _db, cartItem.toJson());
//       _count += 1;
//       _totalQuantity += int.parse(cartItem.quantity ?? '0');
//       notifyListeners();
//     }
//   }
//
//   // Future updateCart(CartItem cartItem, String type, String branch_id,
//   //     // String area_id,
//   //     ) async {
//   //
//   //   final finder = Finder(filter: Filter.and([Filter.equals("id", cartItem.id), Filter.equals("type", type)]));
//   //   var count = int.parse(cartItem.quantity!);
//   //   // var productCount = int.parse(cartItem.productQuantity!);
//   //   if (count != null) {
//   //     count += quantity;
//   //   }
//   //   cartItem.quantity = count.toString();
//   //   // cartItem.productQuantity = productCount.toString();
//   //   await _cartFolder.update(await _db, cartItem.toJson(), finder: finder);
//   //   notifyListeners();
//   // }
//
//
//
// /*
//   *  function used to increment specific item in cart
//   *  function parameters :-
//   *  carItem Object,
//   *  type String (example:- product , offer , special),
//   *  quantity
//   * */
//   Future increment(CartItem cartItem, String type, int quantity) async {
//     //find item  in cart
//
//     final finder = Finder(filter: Filter.and([Filter.equals("id", cartItem.id), Filter.equals("type", type)]));
//     var count = int.parse(cartItem.quantity!);
//     // var productCount = int.parse(cartItem.productQuantity!);
//     if (count != null) {
//       count += quantity;
//     }
//     cartItem.quantity = count.toString();
//     await _cartFolder.update(await _db, cartItem.toJson(), finder: finder);
//     _totalQuantity += quantity;
//     notifyListeners();
//   }
//   /*
//   *  function used to decrement specific item in cart
//   *  function parameters :-
//   *  carItem Object,
//   *  type String (example:- product , offer , special),
//   * */
//
//   Future decrement(CartItem cartItem, String type) async {
//     //find item  in cart
//     final finder = Finder(filter: Filter.and([Filter.equals("id", cartItem.id), Filter.equals("type", type)]));
//     var count = int.parse(cartItem.quantity!);
//     if (count != null) {
//       count -= 1;
//     }
//     cartItem.quantity = count.toString();
//     await _cartFolder.update(await _db, cartItem.toJson(), finder: finder);
//     _totalQuantity -= 1;
//     await loadData();
//     notifyListeners();
//   }
//
//   /*
//   *  function used to delete specific item in cart
//   *  function parameters :-
//   *  carItem Object,
//   *  type String (example:- product , offer , special),
//   * */
//
//   Future delete(CartItem cartItem, String type) async {
//     //find item  in cart
//     final finder = Finder(filter: Filter.and([Filter.equals("id", cartItem.id), Filter.equals("type", type)]));
//     await _cartFolder.delete(await _db, finder: finder);
//     _count -= 1;
//     _totalQuantity -= int.parse(cartItem.quantity ?? '0');
//     await loadData();
//     notifyListeners();
//   }
//
//
//   /*
//   *  function used to delete all items in cart
//   *  function parameters :-
//   *  carItem Object,
//   *  type String (example:- product , offer , special),
//   * */
//   Future deleteAll() async {
//     for (var i = 0; i < items.length; i++) {
//       final finder = Finder(filter: Filter.and([Filter.equals("id", items[i].id), Filter.equals("type", items[i].type)]));
//       await _cartFolder.delete(await _db, finder: finder);
//       _count = 0;
//       _totalQuantity = 0;
//       notifyListeners();
//     }
//   }
//
//
//
//   /*
//   *  function used to find if that type passed to it exit or not
//   *  function parameters :-
//   *  type String (example:- product , offer , special),
//   * */
//
//   Future<bool> findDifferent(String type) async {
//     final finder = Finder(filter: Filter.matches("type", type));
//     var records = await _cartFolder.findFirst(await _db, finder: finder);
//     if (records != null) {
//       return true;
//     } else {
//       return false;
//     }
//   }
//
//   Future findDifferentequal(String type) async {
//     final finder = Finder(filter: Filter.matches("branchId", type));
//     var records = await _cartFolder.findFirst(await _db, finder: finder);
//     if (records != null) {
//       // CartItem.fromJson(records.value);
//       return  records.value['branchId'];
//     } else {
//       return null;
//     }
//   }
//
//   Future findDifferentequalid(String type) async {
//     final finder = Finder(filter: Filter.matches("replayid", type));
//     var records = await _cartFolder.findFirst(await _db, finder: finder);
//     if (records != null) {
//       // CartItem.fromJson(records.value);
//       return  records.value['replayid'];
//     } else {
//       return null;
//     }
//   }
//
//   Future findDifferentequalcurrency(String type) async {
//     final finder = Finder(filter: Filter.matches("currency", type));
//     var records = await _cartFolder.findFirst(await _db, finder: finder);
//     if (records != null) {
//       // CartItem.fromJson(records.value);
//       return  records.value['currency'];
//     } else {
//       return null;
//     }
//   }
//   /*
//   *  function used to send list of cart to server
//   *  url used https://api.mokasweets.com/api/cart, POST
//   *  function parameters :-
//   *  carList,
//   * */
//
//   Future sendCart(CartList cartList) async {
//     Map<String, dynamic> postData = cartList.toJson();
//     try {
//       var data = await saveDataWithoutFormData(AppUrl.newCart, parameters: postData);
//       debugPrint(data);
//       return data;
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
// }
//
// class CartList {
//   final List<CartItem>? items;
//   CartList({this.items});
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['item'] = items;
//     return data;
//   }
// }

import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/url.dart';

/*
* App Cart Model
* Use sembast db to store cart items
* functions used:-
* loadDate
* addToCart
* increment
* decrement
* delete
* deleteAll
* sendCart
* findDifferent
* */

class CartModel extends QueryModel {
  CartModel(super.context);
  bool _showPaidAdds = false;
  bool _showFreeAdds = true;
  bool _combined = false;
  bool _combined2 = false;
  // int _selectedPrice = 0;
  int _selectedPaidAdds = 0;
  // int get selectedPrice => _selectedPrice;
  int get selectedPaidAdds => _selectedPaidAdds;
  bool get showPaidAdds => _showPaidAdds;
  bool get showFreeAdds => _showFreeAdds;
  bool get combined => _combined;
  bool get combined2 => _combined2;

  set selectedPaidAdds(newValue) {
    _selectedPaidAdds = newValue;
    notifyListeners();
  }

  set showPaidAdds(bool newValue) {
    _showPaidAdds = newValue;
    notifyListeners();
  }

  set showFreeAdds(bool newValue) {
    _showFreeAdds = newValue;
    notifyListeners();
  }

  set combined(bool newValue) {
    _combined = newValue;
    notifyListeners();
  }

  set combined2(bool newValue) {
    _combined2 = newValue;
    notifyListeners();
  }

  final _cartFolder = intMapStoreFactory.store(appModel.token);

  var store = intMapStoreFactory.store(appModel.token);

  Future<Database> get _db async => await AppDatabase.instance.database;
  int _count = 0;
  double _totalPrice = 0;
  int _totalQuantity = 0;

  int get totalQuantity => _totalQuantity;

  set totalQuantity(int newValue) {
    _totalQuantity = newValue;
    notifyListeners();
  }

  @override
  Future loadData([BuildContext? context]) async {
    // check if items is empty if not clear items so items will not be repeated
    if (items.isNotEmpty) items.clear();
    final recordSnapshot =
        await _cartFolder.find(await _db); // to find cart file
    var data = recordSnapshot.map((snapshot) {
      //fetch cart
      final cart = CartItem.fromJson(snapshot.value);
      return cart;
    }).toList();
    items.addAll(data);

    _count = items.length;
    //calculate cart total price
    _totalPrice = items
            .map((entry) =>
                double.parse(entry.price) * (int.parse(entry.quantity) ?? 0))
            .fold(0, (value, element) => value! + element) ??
        0;
    _totalQuantity =
        items.fold(0, (sum, item) => sum + int.parse(item.quantity ?? '0'));
    finishLoading();
  }

  CartItem get cartItem => items[0];
  int get nCount => _count;
  // int get productCount => _productCount;
  double get totalPrice => _totalPrice;
  set totalPrice(double newValue) {
    _totalPrice = newValue;
    notifyListeners();
  }
  // int get selectedPrice => _selectedPrice;

  // set selectedPrice (int newValue){
  //   _selectedPrice = newValue;
  //   notifyListeners();
  // }

  /*
  *  function used to add new item in cart
  *  function parameters :-
  *  carItem Object
  *  type String (example:- product , offer , special)
  * */
  Future addToCart({
    required CartItem cartItem,
    required String type,
    String? branch_id,
  }
      // String area_id,
      ) async {
    //find item in cart
    final finder = Finder(
        filter: Filter.and(
            [Filter.equals("id", cartItem.id), Filter.equals("type", type)]));
    var records = await _cartFolder.findFirst(await _db,
        finder: finder); // fetch item if exit in finder
    print(cartItem.toString());

    Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;

    prefs.setString("branchId", branch_id ?? "2");
    // prefs.setString("AreaId", area_id);

    if (records != null) {
      // if item exit call increment function
      var item = CartItem.fromJson(records.value);
      await increment(item, type, int.parse(cartItem.quantity!));
    } else {
      // if not added it and increment cart items count
      await _cartFolder.add(await _db, cartItem.toJson());
      _count += 1;
      _totalQuantity += int.parse(cartItem.quantity ?? '0');
      notifyListeners();
    }
  }

  // Future updateCart(CartItem cartItem, String type, String branch_id,
  //     // String area_id,
  //     ) async {
  //
  //   final finder = Finder(filter: Filter.and([Filter.equals("id", cartItem.id), Filter.equals("type", type)]));
  //   var count = int.parse(cartItem.quantity!);
  //   // var productCount = int.parse(cartItem.productQuantity!);
  //   if (count != null) {
  //     count += quantity;
  //   }
  //   cartItem.quantity = count.toString();
  //   // cartItem.productQuantity = productCount.toString();
  //   await _cartFolder.update(await _db, cartItem.toJson(), finder: finder);
  //   notifyListeners();
  // }

/*
  *  function used to increment specific item in cart
  *  function parameters :-
  *  carItem Object,
  *  type String (example:- product , offer , special),
  *  quantity
  * */
  Future increment(CartItem cartItem, String type, int quantity) async {
    //find item  in cart

    final finder = Finder(
        filter: Filter.and(
            [Filter.equals("id", cartItem.id), Filter.equals("type", type)]));
    var count = int.parse(cartItem.quantity!);
    count += quantity;
    cartItem.quantity = count.toString();
    await _cartFolder.update(await _db, cartItem.toJson(), finder: finder);
    _totalQuantity += quantity;
    notifyListeners();
  }
  /*
  *  function used to decrement specific item in cart
  *  function parameters :-
  *  carItem Object,
  *  type String (example:- product , offer , special),
  * */

  Future decrement(CartItem cartItem, String type) async {
    //find item  in cart
    final finder = Finder(
        filter: Filter.and(
            [Filter.equals("id", cartItem.id), Filter.equals("type", type)]));
    var count = int.parse(cartItem.quantity!);
    count -= 1;
    cartItem.quantity = count.toString();
    await _cartFolder.update(await _db, cartItem.toJson(), finder: finder);
    _totalQuantity -= 1;
    await loadData();
    notifyListeners();
  }

  /*
  *  function used to delete specific item in cart
  *  function parameters :-
  *  carItem Object,
  *  type String (example:- product , offer , special),
  * */

  Future delete(CartItem cartItem, String type) async {
    //find item  in cart
    final finder = Finder(
        filter: Filter.and(
            [Filter.equals("id", cartItem.id), Filter.equals("type", type)]));
    await _cartFolder.delete(await _db, finder: finder);
    _count -= 1;
    _totalQuantity -= int.parse(cartItem.quantity ?? '0');
    await loadData();
    notifyListeners();
  }

  /*
  *  function used to delete all items in cart
  *  function parameters :-
  *  carItem Object,
  *  type String (example:- product , offer , special),
  * */
  Future deleteAll() async {
    for (var i = 0; i < items.length; i++) {
      final finder = Finder(
          filter: Filter.and([
        Filter.equals("id", items[i].id),
        Filter.equals("type", items[i].type)
      ]));
      await _cartFolder.delete(await _db, finder: finder);
      _count = 0;
      _totalQuantity = 0;
      notifyListeners();
    }
  }

  /*
  *  function used to find if that type passed to it exit or not
  *  function parameters :-
  *  type String (example:- product , offer , special),
  * */

  Future<bool> findDifferent(String type) async {
    final finder = Finder(filter: Filter.matches("type", type));
    var records = await _cartFolder.findFirst(await _db, finder: finder);
    if (records != null) {
      return true;
    } else {
      return false;
    }
  }

  Future findDifferentequal(String type) async {
    final finder = Finder(filter: Filter.matches("branchId", type));
    var records = await _cartFolder.findFirst(await _db, finder: finder);
    if (records != null) {
      // CartItem.fromJson(records.value);
      return records.value['branchId'];
    } else {
      return null;
    }
  }

  Future findDifferentequalid(String type) async {
    final finder = Finder(filter: Filter.matches("replayid", type));
    var records = await _cartFolder.findFirst(await _db, finder: finder);
    if (records != null) {
      // CartItem.fromJson(records.value);
      return records.value['replayid'];
    } else {
      return null;
    }
  }

  Future findDifferentequalcurrency(String type) async {
    final finder = Finder(filter: Filter.matches("currency", type));
    var records = await _cartFolder.findFirst(await _db, finder: finder);
    if (records != null) {
      // CartItem.fromJson(records.value);
      return records.value['currency'];
    } else {
      return null;
    }
  }
  /*
  *  function used to send list of cart to server
  *  url used https://api.mokasweets.com/api/cart, POST
  *  function parameters :-
  *  carList,
  * */

  Future sendCart(CartList cartList) async {
    Map<String, dynamic> postData = cartList.toJson();
    try {
      var data =
          await saveDataWithoutFormData(AppUrl.newCart, parameters: postData);
      print(data);
      return data;
    } catch (e) {
      print(e);
    }
  }
}

class CartList {
  final List<CartItem>? items;
  CartList({this.items});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item'] = items;
    return data;
  }
}
