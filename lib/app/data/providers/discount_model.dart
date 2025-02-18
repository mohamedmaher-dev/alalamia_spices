

import 'package:alalamia_spices/app/core/utils/url.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DiscountModel extends QueryModel {
  DiscountModel(super.context);

  @override
  Future loadData([BuildContext? context]) async{

    var data;
    try{
      data = await fetchDataa(AppUrl.volumeDiscount,"");

    }catch (error) {
      if (kDebugMode) {
        print("DiscountModel catch error$error");
      }
    }

    if(data != null){
      DiscountData discountData = DiscountData.fromJson(data);
      List discountList = discountData.discount!;
      items.addAll(discountList);
      finishLoading();
      if (kDebugMode) {
        print ("=====DiscountModel=====$data");
        print ("=====DiscountModel api url ===== ${AppUrl.volumeDiscount}");
      }
    }

  }

  DiscountVolume get discountVolume => items[0];

}