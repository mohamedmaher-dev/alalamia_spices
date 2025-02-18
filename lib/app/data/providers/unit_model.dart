
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import '../../core/utils/url.dart';
import '../../module/app_config/app_config_screen.dart';

class UnitModel extends QueryModel {
  UnitModel(super.context);

  @override
  Future loadData([BuildContext? context]) async{
    // var countriesModel  = Provider.of<CountriesModel>(context! , listen: false);
    var data;
    try{


      data = await fetchDataa(
          appModel.token == "visitor"
              ? "${AppUrl.unitVisitor}?country_id=$countryId"
              :  AppUrl.unit, "");


    }catch (error) {
      if (kDebugMode) {
        print("UnitModel catch error$error");
      }
    }

    if(data != null){
      UnitData unitData = UnitData.fromJson(data);
      List unitList = unitData.units!;
      items.addAll(unitList);
      finishLoading();
      if (kDebugMode) {
        print ("=====UnitModel=====$data");
        print ("=====UnitModel url ===== ${AppUrl.unitVisitor}");
      }
    }
  }
  Unit get units => items[0];
  }

