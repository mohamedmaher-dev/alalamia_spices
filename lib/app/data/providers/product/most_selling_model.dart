

import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:flutter/foundation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../core/utils/url.dart';
import '../../../module/app_config/app_config_screen.dart';
import 'package:flutter/material.dart';

import '../../model/new_arrival.dart';

/// no pagination

// class MostSellingModel extends QueryModel {
//   MostSellingModel(super.context);
//
//   @override
//   Future loadData([BuildContext? context]) async{
//
//     if(appModel.token != '') {
//       var data;
//       try{
//         data = await fetchDataa(
//             appModel.token == "visitor"
//                 ? "${AppUrl.mostSellProductVisitor}?country_id=$countryId"
//                 : AppUrl.mostSellProduct, "");
//
//
//       }catch (error) {
//         if (kDebugMode) {
//           print("MostSellingModel catch error$error");
//         }
//       }
//
//       if(data != null){
//
//         MostSellData mostSellData = MostSellData.fromJson(data);
//         List mostSellList = mostSellData.product!;
//         items.addAll(mostSellList);
//         finishLoading();
//         // if (kDebugMode) {
//         //   print ("=====MostSellingModel=====$data");
//         //   print ("=====MostSellingModel url ===== ${AppUrl.mostSellProductVisitor}?country_id=$countryId");
//         // }
//
//       }
//     }
//
//
//
//   }
//
//   Product get mostSell => items[0];
//
// }

/// pagination

class MostSellingModel extends QueryModel {
  static const _pageSize = 10;
  final PagingController<int, Product> pagingController = PagingController(firstPageKey: 1);

  MostSellingModel(super.context);

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
              ? "${AppUrl.mostSellProductVisitorPaginate}?country_id=$countryId&page=$pageKey"
              : "${AppUrl.mostSellProductPaginate}?page=$pageKey", "");

      if (data != null) {
        debugPrint("Response Data: $data");
        debugPrint("Response Data: ${AppUrl.mostSellProductPaginate}?page=$pageKey");
        MostSellData mostSellData = MostSellData.fromJson(data);
        final isLastPage = mostSellData.product!.length < _pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(mostSellData.product!);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(mostSellData.product!, nextPageKey);
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