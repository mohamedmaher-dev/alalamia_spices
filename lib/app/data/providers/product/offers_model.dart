

import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/url.dart';
import '../../../module/app_config/app_config_screen.dart';

class OffersModel extends QueryModel {
  OffersModel(super.context);

  @override
  Future loadData([BuildContext? context]) async{
    if(appModel.token != '') {
      var data;
      try{
        data = await fetchDataa(
            appModel.token == "visitor"
                ? "${AppUrl.branchesOfferVisitor}?country_id=$countryId"
                : AppUrl.branchesOffer , "");



        OffersData offersData = OffersData.fromJson(data);
        List offersList = offersData.offers!;
        items.addAll(offersList);
        finishLoading();

        // if (kDebugMode) {
        //   print ("=====offers model=====$data");
        //   print ("=====offers api url ===== ${AppUrl.branchesOfferVisitor}?country_id=$countryId ");
        // }

      }catch (error) {
        if (kDebugMode) {
          print("OffersModel catch error$error");
        }
      }
    }



    // if(data != null){
    //   OffersData offersData = OffersData.fromJson(data);
    //   List offersList = offersData.offers!;
    //   items.addAll(offersList);
    //   finishLoading();
    //
    //   if (kDebugMode) {
    //     print ("=====offers model=====$data");
    //     print ("=====offers api url ===== ${AppUrl.offers}?country_id=${countriesModel.currentCountryId} ");
    //   }
    // }

  }

  Offers get offer => items[0];

}