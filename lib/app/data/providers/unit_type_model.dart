
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/utils/url.dart';
import '../../module/app_config/app_config_screen.dart';
import 'package:alalamia_spices/app/exports/model.dart';

class UnitTypeModel extends QueryModel {
  UnitTypeModel(super.context);

  @override
  Future loadData([BuildContext? context]) async{
    // var countriesModel  = Provider.of<CountriesModel>(context! , listen: false);
    var data;
    try{
      // if(countryId == null){
      //   data = await fetchDataa(
      //       appModel.token == "visitor"
      //           ?  "${AppUrl.unitTypeVisitor}?country_id=19"
      //           : AppUrl.unitType , "");
      // }else{
      //   data = await fetchDataa(
      //       appModel.token == "visitor"
      //           ?  "${AppUrl.unitTypeVisitor}?country_id=$countryId"
      //           : AppUrl.unitType , "");
      // }

      data = await fetchDataa(
          appModel.token == "visitor"
              ?  "${AppUrl.unitTypeVisitor}?country_id=$countryId"
              : AppUrl.unitType , "");


    }catch (error) {
      if (kDebugMode) {
        print("UnitModel catch error$error");
      }
    }

    if(data != null){
      UnitData unitData = UnitData.fromJson(data);
      List unitsList = unitData.units!;
      items.addAll(unitsList);
      finishLoading();
      if (kDebugMode) {
        print ("=====UnitModel=====$data");
        print ("=====UnitModel api url ===== ${AppUrl.unitTypeVisitor}?country_id=$countryId");
      }
    }

  }
  Unit get unit => items[0];
}