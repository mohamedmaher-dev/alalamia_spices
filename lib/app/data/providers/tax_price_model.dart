

import 'package:alalamia_spices/app/core/utils/url.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class TaxModel extends QueryModel {
  TaxModel(super.context);

  @override
  Future loadData([BuildContext? context]) async{

    var data;
    try{
      data = await fetchDataa(AppUrl.taxPrice , "");

    }catch (error) {
      if (kDebugMode) {
        print("TaxModel catch error$error");
      }
    }

    if(data != null){

      TaxPriceData taxPriceData = TaxPriceData.fromJson(data);
      List taxList = taxPriceData.taxPrice!;
      items.addAll(taxList);
      finishLoading();
      if (kDebugMode) {
        print ("=====TaxModel=====$data");
        print ("=====TaxModel url ===== ${AppUrl.taxPrice}");
      }

    }

  }

  TaxPrice get taxPrice => items[0];

}