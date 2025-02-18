

import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/url.dart';
import '../../../module/app_config/app_config_screen.dart';

class OfferImageModel extends QueryModel {
  final String offerId;
  OfferImageModel(super.context ,  this.offerId);

  @override
  Future loadData([BuildContext? context]) async {
    var data;
    try{

      data = await fetchDataa(
          appModel.token == "visitor"
              ? "${AppUrl.offerImagesVisitor}$offerId?country_id=$countryId"
              : "${AppUrl.offerImages}$offerId"  , "");


    }catch (error) {
      if (kDebugMode) {
        print("offer image catch error$error");
      }
    }

    if(data != null){
      OfferImageData offerImageData = OfferImageData.fromJson(data);
      List offerImageList = offerImageData.offerImage!;
      items.addAll(offerImageList);
      finishLoading();

      if (kDebugMode) {
        print ("=====offer image model=====$data");
        print ("=====offer image api url ===== ${AppUrl.offerImages}$offerId?country_id=$countryId");
      }
    }

  }
  OfferImage get offerImage => items[0];
}