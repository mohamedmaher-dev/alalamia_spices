
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:flutter/foundation.dart';
import '../../../core/utils/url.dart';
import '../../../module/app_config/app_config_screen.dart';
import 'package:flutter/material.dart';

class MainCategoriesModel extends QueryModel {
  MainCategoriesModel(super.context);

  @override
  Future loadData([BuildContext? context]) async{

    if(appModel.token != ''){
      var data;
      try{
        data = await fetchDataa(
            appModel.token == "visitor"
                ? "${AppUrl.mainCategoryVisitor}?country_id=$countryId"
                : AppUrl.mainCategory, ""
        );

      }catch (error) {
        if (kDebugMode) {
          print("MainCategoriesModel catch error$error");
        }
      }

      if(data != null){
        MainCategoryData mainCategoryData = MainCategoryData.fromJson(data);
        List mainCateList = mainCategoryData.mainCategory!;
        items.addAll(mainCateList);
        finishLoading();
        // if (kDebugMode) {
        //   print ("=====Main category model=====$data");
        //   print ("=====Main category model api url ===== ${AppUrl.mainCategory}");
        // }
      }
    }



  }

  MainCategory get mainCateItems => items[0];

}