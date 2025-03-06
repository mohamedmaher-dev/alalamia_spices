/// without pagination
///
// import 'package:alalamia_spices/app/exports/provider.dart';
// import 'package:alalamia_spices/app/exports/model.dart';
// import 'package:flutter/material.dart';
// import '../../../core/utils/url.dart';
// import '../../../module/app_config/app_config_screen.dart';
// import '../../model/new_arrival.dart';
//
// class SubCategoryProductModel extends QueryModel {
//   final String? mainId;
//   final String? subMainId;
//   SubCategoryProductModel(super.context , {this.mainId , this.subMainId});
//
//   List<dynamic> allProducts = []; // Store all products here
//   bool hasMoreProducts = false; // Track if there are more products to load
//   ScrollController scrollController = ScrollController(); // Add a ScrollController
//   bool isLoadingMore = false; // Track if more products are being loaded
//   @override
//   Future loadData([BuildContext? context]) async{
//
//     if(appModel.token != '') {
//       var data;
//       try{
//         data = await fetchDataa(
//             appModel.token == "visitor"
//                 ? "${AppUrl.categoryProductVisitor}$mainId/$subMainId?country_id=$countryId"
//                 :  "${AppUrl.categoryProduct}$mainId/$subMainId" , "");
//
//
//       }catch (error) {
//           debugPrint("SubCategoryProductModel catch error$error");
//
//       }
//
//       if(data != null){
//         SubCategoryProductData subCategoryProductData = SubCategoryProductData.fromJson(data);
//         allProducts = subCategoryProductData.categoryProduct!; // Store all products
//         items.addAll(allProducts.take(10)); // Add only the first 10 products
//         hasMoreProducts = allProducts.length > 10; // Check if there are more products
//
//         finishLoading();
//         scrollController.addListener(_scrollListener);
//           debugPrint ("=====SubCategoryProductModel=====$data");
//         debugPrint ("=====SubCategoryProductModel api url ===== ${AppUrl.categoryProductVisitor}$mainId/0?country_id=$countryId");
//       }
//     }
//
//
//   }
//
//   // Method to load more products
//   Future<void> loadMoreProducts() async {
//     if (hasMoreProducts && !isLoadingMore) {
//       isLoadingMore = true; // Set loading state to true
//       notifyListeners();
//
//       // Simulate a delay (optional, for testing)
//       await Future.delayed(const Duration(seconds: 1));
//
//       int currentLength = items.length;
//       int remainingProducts = allProducts.length - currentLength;
//       int nextProducts = remainingProducts > 10 ? 10 : remainingProducts;
//       items.addAll(allProducts.sublist(currentLength, currentLength + nextProducts));
//       hasMoreProducts = remainingProducts > nextProducts;
//
//       isLoadingMore = false; // Set loading state to false
//       notifyListeners(); // Notify listeners to update the UI
//     }
//   }
//
//   // Scroll listener to detect when the user reaches the end of the list
//   void _scrollListener() {
//     if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
//       loadMoreProducts(); // Load more products when the user reaches the end
//     }
//   }
//
//   @override
//   void dispose() {
//     scrollController.removeListener(_scrollListener); // Clean up the listener
//     scrollController.dispose(); // Dispose the controller
//     super.dispose();
//   }
//   Product get subCategoryProduct => items[0];
// }

/// pagination using infinite_scroll_pagination
library;

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import '../../../core/utils/url.dart';
import '../../../module/app_config/app_config_screen.dart';
import '../../model/new_arrival.dart';

class SubCategoryProductModel extends QueryModel {
  final String? subMainId;
  final String? mainId;
  static const _pageSize = 10;
  final PagingController<int, Product> pagingController =
      PagingController(firstPageKey: 1);

  SubCategoryProductModel(super.context, {this.subMainId, this.mainId});

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
              ? "${AppUrl.categoryProductPaginateVisitor}$mainId/$subMainId?page=$pageKey"
              : "${AppUrl.categoryProductPaginate}$mainId/$subMainId?page=$pageKey",
          "");

      if (data != null) {
        debugPrint("Response Data: $data");
        debugPrint(
            "Response Data: ${AppUrl.categoryProductPaginateVisitor}/$mainId/$subMainId?page=$pageKey");
        SubCategoryProductData subCategoryProductData =
            SubCategoryProductData.fromJson(data);
        final isLastPage =
            subCategoryProductData.categoryProduct!.length < _pageSize;
        if (isLastPage) {
          pagingController
              .appendLastPage(subCategoryProductData.categoryProduct!);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(
              subCategoryProductData.categoryProduct!, nextPageKey);
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
