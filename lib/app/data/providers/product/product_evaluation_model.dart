
import 'package:alalamia_spices/app/core/utils/url.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/module/app_config/app_config_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../model/product_evaluation.dart';


class ProductEvaluationModel extends QueryModel {
  int productId;

  ProductEvaluationModel(super.context , {required this.productId});

  @override
  Future loadData([BuildContext? context]) async{

    var data;
    try{
      data = await fetchDataa(
      appModel.token == 'visitor'
         ? "${AppUrl.productEvaluationVisitor}$productId?country_id=$countryId"
         : "${AppUrl.productEvaluation}$productId"
      , "");

    }catch (error) {
      if (kDebugMode) {
        print("ProductEvaluationModel catch error$error");
      }
    }

    if(data != null){
      ProductEvaluationData productEvaluationData = ProductEvaluationData.fromJson(data);
      List productEvaList = productEvaluationData.productEvaluation!;
      items.addAll(productEvaList);
      finishLoading();
      if (kDebugMode) {
        print ("=====ProductEvaluationModel=====$data");
        print ("=====ProductEvaluationModel api url ===== ${AppUrl.productEvaluation}$productId");
      }
    }

  }
  ProductEvaluation get productEva => items[0];

  Future sendProductRate({required ProductEvaluation productEvaluation ,  required String productPriceId }) async {
    if (await canLoadData()) {
      Map<String, dynamic> postData = productEvaluation.toJson();
      postData.addAll({"product_price_id": productPriceId});
//      postData.addAll({"product_id": productId});


      try {
        await saveData(AppUrl.sendProductEvaluation, parameters: postData);
        if (kDebugMode) {
          print("=========== sendProductEvaluation ==========$postData");
        }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }
  }
}