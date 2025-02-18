

import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:alalamia_spices/app/module/app_config/app_config_screen.dart';
import 'package:flutter/foundation.dart';
import '../../../core/utils/url.dart';
import 'package:flutter/material.dart';

class AllCategoriesModel extends QueryModel {
  AllCategoriesModel(super.context);

  @override
  Future loadData([BuildContext? context]) async{
    // var countriesModel  = Provider.of<CountriesModel>(context! , listen: false);
    var data;
    try{
      if(countryId == null){
        data = await fetchDataa(
            appModel.token == "visitor"
                ? "${AppUrl.allcategoryVisitor}?country_id=19"
                : AppUrl.allcategory, "");
      }else {
        data = await fetchDataa(
            appModel.token == "visitor"
                ? "${AppUrl.allcategoryVisitor}?country_id=$countryId"
                : AppUrl.allcategory, "");
      }


    }catch (error) {
      if (kDebugMode) {
        print("AllCategoriesModel catch error$error");
      }
    }

    if(data != null){

      AllCategoriesData allCategoriesData = AllCategoriesData.fromJson(data);
      List allCategoriesList = allCategoriesData.allCategories!;
      items.addAll(allCategoriesList);
      finishLoading();
      // if (kDebugMode) {
      //   print ("=====AllCategoriesModel=====$data");
      //   print ("=====AllCategoriesModel url ===== ${AppUrl.allcategory}?country_id=$countryId");
      // }

    }
  }

  AllCategories get allCategory => items[0];
}