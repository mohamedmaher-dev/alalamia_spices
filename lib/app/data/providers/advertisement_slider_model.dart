
import 'package:flutter/foundation.dart';
import '../../core/utils/url.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:flutter/material.dart';
import '../../module/app_config/app_config_screen.dart';

class AdvertisementSliderModel extends QueryModel{


  AdvertisementSliderModel(super.context);

  @override
  Future loadData([BuildContext? context]) async{
    // var countriesModel = Provider.of<CountriesModel>(context! , listen: false);

    if(appModel.token != ''){
      var data;
      try{
        // if(countryId == null){
        //   data = await fetchDataa(
        //       appModel.token == "visitor"
        //           ? "${AppUrl.advertisementVisitor}?country_id=19"
        //           : AppUrl.advertisement, "");
        // }else {
        //   data = await fetchDataa(
        //       appModel.token == "visitor"
        //           ? "${AppUrl.advertisementVisitor}?country_id=$countryId"
        //           : AppUrl.advertisement, "");
        // }
        data = await fetchDataa(
            appModel.token == "visitor"
                ? "${AppUrl.advertisementVisitor}?country_id=$countryId"
                : AppUrl.advertisement, "");

      }catch (error) {
        if (kDebugMode) {
          print("AdvertisementModel catch error$error");
        }
      }

      if(data != null){
        AdvertisementSliderData advertisementSliderData = AdvertisementSliderData.fromJson(data);
        List advertisementList = advertisementSliderData.advertisementSlider as List;
        items.addAll(advertisementList);
        finishLoading();
        // if (kDebugMode) {
        //   print ("=====advertisement model=====$data");
        //   print ("=====advertisement api url ===== ${AppUrl.advertisement}");
        // }
      }
    }



  }

  AdvertisementSlider get advertisementSlider => items[0];

}