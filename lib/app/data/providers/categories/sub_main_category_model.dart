

import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/url.dart';

class SubMainCategoryModel extends QueryModel{

  String? id;
  SubMainCategoryModel(super.context , {this.id});

  @override
  Future loadData([BuildContext? context]) async{


    if(appModel.token != ''  &&  await canLoadData()) {

      var data;
      try{
        data = await fetchDataa(
            appModel.token == "visitor"
                ? "${AppUrl.subMainCategoryVisitor}$id"
                : "${AppUrl.subMainCategory}$id", ""
        );

      }catch (error) {
        if (kDebugMode) {
          print("Sub MainCategoriesModel catch error$error");
        }
      }

      if(data != null){
        SubMainCategoryData subCategoryData = SubMainCategoryData.fromJson(data);
        List subMainCateList = subCategoryData.subMainCategory!;
        items.addAll(subMainCateList);
        finishLoading();
        // if (kDebugMode) {
        //   print ("=====Sub main category model=====$data");
        //   print ("=====Sub main category model api url ===== ${AppUrl.subMainCategoryVisitor}$id");
        // }
      }
    }


  }

  SubMainCategory get subCateItems => items[0];

}