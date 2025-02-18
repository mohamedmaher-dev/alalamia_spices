

import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../core/utils/url.dart';
import 'package:flutter/material.dart';
import '../../../module/app_config/app_config_screen.dart';
import '../../model/new_arrival.dart';

/// no pagination

// class NewArrivalModel extends QueryModel {
//
//   NewArrivalModel(super.context);
//
//   @override
//   Future loadData([BuildContext? context]) async{
//
//     var data;
//     if(appModel.token != '') {
//       try{
//
//         data = await fetchDataa(
//             appModel.token == "visitor"
//                 ? "${AppUrl.newArrivalProductVisitor}?country_id=$countryId"
//                 : AppUrl.newArrivalProduct, "");
//
//
//       }catch (error) {
//         if (kDebugMode) {
//           print("NewArrivalModel catch error$error");
//         }
//       }
//       if(data != null){
//         NewArrivalData newArrivalData = NewArrivalData.fromJson(data);
//         List newArrivalList = newArrivalData.product!;
//         items.addAll(newArrivalList);
//         finishLoading();
//         // if (kDebugMode) {
//         //   print ("=====new arrival model=====$data");
//         //   print ("=====new arrival api url ===== ${AppUrl.newArrivalProductVisitor}?country_id=$countryId");
//         // }
//       }
//     }
//
//
//   }
//
//   Product get newArrivalProduct => items[0];
// }

/// pagination with infinite_scroll_pagination and api

class NewArrivalModel extends QueryModel {
  static const _pageSize = 10;
  final PagingController<int, Product> pagingController = PagingController(firstPageKey: 1);

  NewArrivalModel(super.context);

  @override
  Future loadData([BuildContext? context]) async {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final data = await fetchDataa(
          appModel.token == "visitor"
              ? "${AppUrl.newArrivalProductVisitorPaginate}?country_id=$countryId&page=$pageKey"
              : "${AppUrl.newArrivalProductPaginate}?page=$pageKey", "");

      if (data != null) {
        debugPrint("Response Data: $data");
        debugPrint("Response Data: ${AppUrl.newArrivalProductPaginate}?page=$pageKey");
        NewArrivalData newArrivalProductData = NewArrivalData.fromJson(data);
        final isLastPage = newArrivalProductData.product!.length < _pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(newArrivalProductData.product!);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(newArrivalProductData.product!, nextPageKey);
        }
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}



/// hard coded pagination without button to show all

// class NewArrivalModel extends QueryModel{
//   NewArrivalModel(super.context);
//
//   List<dynamic> allProducts = []; // Store all products here
//   bool hasMoreProducts = false; // Track if there are more products to load
//
//
//   @override
//   Future loadData([BuildContext? context]) async {
//     var data;
//     if (appModel.token != '') {
//       try {
//         data = await fetchDataa(
//             appModel.token == "visitor"
//                 ? "${AppUrl.newArrivalProductVisitor}?country_id=$countryId"
//                 : AppUrl.newArrivalProduct,
//             "");
//       } catch (error) {
//         if (kDebugMode) {
//           print("NewArrivalModel catch error$error");
//         }
//       }
//       if (data != null) {
//         NewArrivalData newArrivalData = NewArrivalData.fromJson(data);
//         allProducts = newArrivalData.product!; // Store all products
//         resetItems();
//         finishLoading();
//       }
//     }
//   }
//
//   // Method to load more products (used in the new screen)
//   Future<void> loadMoreProducts() async {
//     if (hasMoreProducts) {
//       int currentLength = items.length;
//       int remainingProducts = allProducts.length - currentLength;
//       int nextProducts = remainingProducts > 10 ? 10 : remainingProducts;
//       items.addAll(allProducts.sublist(currentLength, currentLength + nextProducts));
//       hasMoreProducts = remainingProducts > nextProducts;
//       notifyListeners(); // Notify listeners to update the UI
//     }
//   }
//
//   // Method to reset items to the first 10 products
//   void resetItems() {
//     items.clear(); // Clear the current items
//     items.addAll(allProducts.take(10)); // Add only the first 10 products
//     hasMoreProducts = allProducts.length > 10; // Update hasMoreProducts
//     notifyListeners(); // Notify listeners to update the UI
//   }
//
//   Product get newArrivalProduct => items[0];
// }

/// hard coded pagination without button to show all

// class NewArrivalModel extends QueryModel {
//
//   NewArrivalModel(super.context);
//
//   List<dynamic> allProducts = []; // Store all products here
//   bool hasMoreProducts = false; // Track if there are more products to load
//
//   @override
//   Future loadData([BuildContext? context]) async {
//     var data;
//     if(appModel.token != '') {
//       try {
//         data = await fetchDataa(
//             appModel.token == "visitor"
//                 ? "${AppUrl.newArrivalProductVisitor}?country_id=$countryId"
//                 : AppUrl.newArrivalProduct, "");
//       } catch (error) {
//         if (kDebugMode) {
//           print("NewArrivalModel catch error$error");
//         }
//       }
//       if(data != null){
//         NewArrivalData newArrivalData = NewArrivalData.fromJson(data);
//         allProducts = newArrivalData.product!; // Store all products
//         items.addAll(allProducts.take(10)); // Add only the first 10 products
//         hasMoreProducts = allProducts.length > 10; // Check if there are more products
//         finishLoading();
//       }
//     }
//   }
//
//   // Method to load more products
//   void loadMoreProducts() {
//     if (hasMoreProducts) {
//       int currentLength = items.length;
//       int remainingProducts = allProducts.length - currentLength;
//       int nextProducts = remainingProducts > 10 ? 10 : remainingProducts;
//       items.addAll(allProducts.sublist(currentLength, currentLength + nextProducts));
//       hasMoreProducts = remainingProducts > nextProducts;
//       notifyListeners(); // Notify listeners to update the UI
//     }
//   }
//
//   Product get newArrivalProduct => items[0];
// }