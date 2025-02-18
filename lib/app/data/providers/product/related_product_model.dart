
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../core/utils/url.dart';
import '../../../module/app_config/app_config_screen.dart';
import '../../model/new_arrival.dart';
import '../../model/related_product.dart';


/// no pagination
// class RelatedProductModel extends QueryModel{
//   final String productId;
//   RelatedProductModel(super.context , this.productId);
//
//   @override
//   Future loadData([BuildContext? context]) async{
//     var data;
//     try{
//       data = await fetchDataa(
//           appModel.token == "visitor"
//               ? "${AppUrl.relatedProductVisitor}$productId/related-paginate?country_id=$countryId"
//               : "${AppUrl.relatedProduct}$productId/related-paginate" , "");
//
//
//     }catch (error) {
//       if (kDebugMode) {
//         print("AdvertisementModel catch error$error");
//       }
//     }
//
//     if(data != null){
//       RelatedProductData relatedProductData = RelatedProductData.fromJson(data);
//       List advertisementList = relatedProductData.relatedProduct!;
//       items.addAll(advertisementList);
//       finishLoading();
//       if (kDebugMode) {
//         print ("=====related product model=====$data");
//         print ("=====related product api url ===== ${AppUrl.relatedProductVisitor}$productId/related?country_id=$countryId");
//       }
//     }
//
//
//   }
//
//   Product get related => items[0];
//
// }

class RelatedProductModel extends QueryModel {
  static const _pageSize = 10;
  final PagingController<int, Product> pagingController = PagingController(firstPageKey: 1);

  final String productId;
  RelatedProductModel(super.context , this.productId);

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
              ? "${AppUrl.relatedProductVisitorPaginate}$productId/related-paginate?country_id=$countryId"
              : "${AppUrl.relatedProductPaginate}$productId/related-paginate" , "");

      if (data != null) {
        debugPrint("Response Data: $data");
        debugPrint("Response Data: ${AppUrl.relatedProductPaginate}?page=$pageKey");
        RelatedProductData relatedProductData = RelatedProductData.fromJson(data);
        final isLastPage = relatedProductData.relatedProduct!.length < _pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(relatedProductData.relatedProduct!);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(relatedProductData.relatedProduct!, nextPageKey);
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