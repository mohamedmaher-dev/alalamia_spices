

import 'package:alalamia_spices/app/core/utils/url.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../module/app_config/app_config_screen.dart';
import '../../services/prefs.dart';
import 'package:alalamia_spices/app/exports/model.dart';

class CeilingPriceModel extends QueryModel {
  CeilingPriceModel(super.context);

  // String _ceilingPrice = "";
  // String get ceilingPrice => _ceilingPrice;
  @override
  Future loadData([BuildContext? context]) async {
    if (appModel.token != '') {
      var data;
      try {
        data = await fetchDataa(
          appModel.token == 'visitor'
            ? "${AppUrl.ceilingPriceVisitor}?country_id=$countryId"
            : AppUrl.ceilingPrice, ""
        );
      } catch (e) {
        data = await fetchDataa(AppUrl.ceilingPrice, "");
      }
      if (data != null) {
        CeilingPrice ceilingPrice = CeilingPrice.fromJson(data);
        items.add(ceilingPrice);
        SharedPrefsService.putString("ceilingPrice", ceiling.price.toString());
        finishLoading();

          debugPrint ("=====CeilingPriceModel=====$data");
          debugPrint ("=====CeilingPriceModel api url ===== ${AppUrl.ceilingPrice}");

      }
    }
  }

  CeilingPrice get ceiling => items[0];


//   Future getCeilingPrice() async{
//     if(items.isNotEmpty){
//       _ceilingPrice = SharedPrefsService.getString("ceilingPrice");
//     }else {
//       _ceilingPrice = "0.0";
//     }
//
// }
}