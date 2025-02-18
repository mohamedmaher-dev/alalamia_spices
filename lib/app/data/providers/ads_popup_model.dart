

import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:alalamia_spices/app/module/app_config/app_config_screen.dart';
import 'package:alalamia_spices/app/services/prefs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/utils/url.dart';


class AdsPopupModel extends QueryModel {
  AdsPopupModel(super.context);

  bool _isNotEmpty = false;
  bool get  isNotEmpty => _isNotEmpty;

  @override
  Future loadData([BuildContext? context]) async{
    var data;
    try{

      data = await fetchDataa(
          appModel.token == "visitor"
              ? "${AppUrl.adsPopupVisitor}?country_id=$countryId"
              : AppUrl.adsPopup, "");


    }catch (error) {
      if (kDebugMode) {
        print("AdsPopupModel catch error$error");
      }
    }

    if(data != null){
      AdsPopupData adsPopupData = AdsPopupData.fromJson(data);
      List adsPopupList = adsPopupData.adsPopup!;
      items.addAll(adsPopupList);
       SharedPrefsService.putBool("AdsLength", items.isNotEmpty ? true : false);
       _isNotEmpty = SharedPrefsService.getBool("AdsLength");

      finishLoading();
      // if (kDebugMode) {
      //   print ("=====AdsPopupModel=====$data");
      //   print ("=====AdsPopupModel api url ===== ${AppUrl.adsPopupVisitor}?country_id=$countryId");
      // }
    }
  }

  AdsPopup get adsPopup => items[0];

}