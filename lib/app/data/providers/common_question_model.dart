import 'package:alalamia_spices/app/core/utils/url.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CommonQuestionModel extends QueryModel {
  CommonQuestionModel(super.context);

  @override
  Future loadData([BuildContext? context]) async{

    var data;

    if(appModel.token != ''){
      try{
        data = await fetchDataa(
          appModel.token == 'visitor'
           ? AppUrl.commonQuestionVisitor
           : AppUrl.commonQuestion,
            "");
      }catch (error) {
        if (kDebugMode) {
          print("CommonQuestionModel catch error$error");
        }
      }
      if(data != null){
        CommonQuestionData commonQuestionData = CommonQuestionData.fromJson(data);
        List commonQuestionList = commonQuestionData.commonQuestions!;
        items.addAll(commonQuestionList);
        finishLoading();
        if (kDebugMode) {
          print ("=====CommonQuestionModel=====$data");
          print ("=====CommonQuestionModel api url ===== ${AppUrl.commonQuestion}");
        }
      }
    }

  }

  CommonQuestion get commonQuestion => items[0];

}