
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/utils/url.dart';
import 'package:alalamia_spices/app/exports/model.dart';


class AppAlertModel extends QueryModel {
  AppAlertModel(super.context);

  @override
  Future loadData([BuildContext? context]) async{

    if (appModel.token != '' && await canLoadData()) {
      var data;
      try{
        data = await fetchDataa(AppUrl.alerts, '');
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
          print ("=====App AlertModel=====$data");
          print ("=====App AlertModel api url ===== ${AppUrl.alerts}");
        }
      }

    }

  }

  Alert get appAlert => items[0];

}