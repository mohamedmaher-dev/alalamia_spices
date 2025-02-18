import 'package:alalamia_spices/app/core/utils/url.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';

class AlertModel extends QueryModel {
  final String branchId;
  AlertModel(super.context , this.branchId);

  @override
  Future loadData([BuildContext? context]) async{

    if (appModel.token != '' && await canLoadData()) {
      var data;
      try{
        data = await fetchDataa("${AppUrl.branchDetailsCategory}$branchId/alert", '');
      }catch(e){
        if (kDebugMode) {
          print(e);
        }
      }
      if(data != null) {
        AlertData alertData = AlertData.fromJson(data);
        List alert = alertData.alert!;
        items.addAll(alert);
        finishLoading();

        if (kDebugMode) {
          print ("=====AlertModel=====$data");
          print ("=====AlertModel api url ===== ${AppUrl.branchDetailsCategory}$branchId/alert");
        }
      }

    }


  }

  Alert get alert => items[0];

}