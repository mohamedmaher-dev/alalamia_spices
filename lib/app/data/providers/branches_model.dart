
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/utils/url.dart';
import '../../module/app_config/app_config_screen.dart';

class BranchesModel extends QueryModel {
  BranchesModel(super.context);

  List<DropdownMenuItem<String>> _branchItems = [];
  List<DropdownMenuItem<String>> get branchItems => _branchItems;
  String? currentBranch;



  @override
  Future loadData([BuildContext? context]) async{
    // var countriesModel  = Provider.of<CountriesModel>(context! , listen: false);
    var data;
    try{
      // if(countryId == null){
      //   data = await fetchDataa(
      //       appModel.token == "visitor"
      //           ? "${AppUrl.branchVisitor}?country_id=19"
      //           :  AppUrl.branch, "");
      // }else {
      //   data = await fetchDataa(
      //       appModel.token == "visitor"
      //           ? "${AppUrl.branchVisitor}?country_id=$countryId"
      //           :  AppUrl.branch, "");
      // }
      data = await fetchDataa(
          appModel.token == "visitor"
              ? "${AppUrl.branchVisitor}?country_id=$countryId"
              :  AppUrl.branch, "");



    }catch (error) {
      if (kDebugMode) {
        print("BranchesModel catch error$error");
      }
    }

    if(data != null){
      BranchesData branchesData = BranchesData.fromJson(data);
      List branchesList = branchesData.branches!;
      items.addAll(branchesList);
      finishLoading();
      if (kDebugMode) {
        print ("=====BranchesModel=====$data");
        print ("=====BranchesModel api url ===== ${AppUrl.branchVisitor}?country_id=$countryId");
      }
    }

  }
  Branches get branch => items[0];


  getBranches() {
    _branchItems = [];
    for (var i = 0; i < items.length; i++) {
      _branchItems.add(DropdownMenuItem(
        value: "${items[i].name}",
        child:  Text("${items[i].name}"),
      ));

      currentBranch = items[i].name;

    }
  }
}