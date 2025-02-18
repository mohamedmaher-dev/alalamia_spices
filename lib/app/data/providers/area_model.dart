import 'package:alalamia_spices/app/core/utils/url.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class AreaModel extends QueryModel {
  AreaModel(super.context);

  String? areaId;
   List<String> _areaList = [];
  List<String> get areaList => _areaList;

  @override
  Future loadData([BuildContext? context]) async{

    var data;
    try{
      data = await fetchDataa(AppUrl.area , "");

    }catch (error) {
      if (kDebugMode) {
        print("AreaModel catch error$error");
      }
    }

    if(data != null){
      AreaData areaData = AreaData.fromJson(data);
      List areaList = areaData.area!;
      items.addAll(areaList);
      finishLoading();
      if (kDebugMode) {
        print ("=====AreaModel=====$data");
        print ("=====AreaModel api url ===== ${AppUrl.area}");
      }
    }

  }

  Area get area => items[0];


  getAreaList () {
    _areaList = [];
    areaId = "";
    for(var i = 0; i < items.length; i++){
      _areaList.add(items[i].name);
      areaId = items[i].stateId;
    }

    if (kDebugMode) {
      print(_areaList);
    }

  }


}