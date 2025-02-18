
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../../core/utils/url.dart';
import '../../module/app_config/app_config_screen.dart';
import 'package:flutter/material.dart';
import '../model/new_arrival.dart';


class SearchModel extends QueryModel {
  String? searchText;
  SearchModel(super.context , {this.searchText});

  bool _isSearching = false;
  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  bool get isSearching => _isSearching;

  set isSearching (bool newValue){
    _isSearching = newValue;
    notifyListeners();
  }

  set searchQuery (String newValue){
    _searchQuery = newValue;
    notifyListeners();
  }

  // categories
  late List _allCategoryItems;
  List get allCategoryItems => _allCategoryItems;
  AllCategories? allCategories ;
  late String categoryId ;


  // branches
  late List _branchItems;
  List get branchItems => _branchItems;
  Branches? branches ;
  late String branchId ;


  // units
  late List _unitItems;
  List get unitItems => _unitItems;
  Unit? unit ;
  late String unitId ;


  // availability

  // late List _availabilityItems;
  // List get availabilityItems => _availabilityItems;
  // String? availabilityController;
  //
  // late String availabilityId ;



  @override
  Future loadData([BuildContext? context]) async{
    // var countriesModel  = Provider.of<CountriesModel>(context! , listen: false);
    var data;
    try{
      // if(countryId == null){
      //   data = await fetchDataa(
      //       appModel.token == "visitor"
      //           ? "${AppUrl.searchVisitor}?country_id=19&search=$searchText"
      //           :  "${AppUrl.search}?search=$searchText", "");
      // }else {
      //   data = await fetchDataa(
      //       appModel.token == "visitor"
      //           ? "${AppUrl.searchVisitor}?country_id=$countryId&search=$searchText"
      //           :  "${AppUrl.search}?search=$searchText", "");
      // }

      data = await fetchDataa(
          appModel.token == "visitor"
              ? "${AppUrl.searchVisitor}?country_id=$countryId&search=$searchText"
              :  "${AppUrl.search}?search=$searchText", "");


    }catch (error) {
      if (kDebugMode) {
        print("SearchModel catch error$error");
      }
    }

    if(data != null){

      NewArrivalData newArrivalData = NewArrivalData.fromJson(data);
      List newArrivalList = newArrivalData.product!;
      items.addAll(newArrivalList);
      finishLoading();
      if (kDebugMode) {
        print ("=====SearchModel=====$data");
        print ("=====SearchModel url ===== ${AppUrl.searchVisitor}?country_id=$countryId&search=$searchText");
      }

    }

  }

  Product get search => items[0];

   getCategoriesItems (BuildContext context) {
     _allCategoryItems = [];
    var allCategoryModel =  Provider.of<AllCategoriesModel>(context , listen: false);
    _allCategoryItems = allCategoryModel.items;
  }

  getBranchesItems(BuildContext context) {
    _branchItems = [];
    var branchModel =  Provider.of<BranchesModel>(context , listen: false);
    _branchItems = branchModel.items;
   }


   getUnitsItems(BuildContext context) {
     _unitItems = [];
     var unitModel =  Provider.of<UnitModel>(context , listen: false);
     _unitItems = unitModel.items;
   }

  // getAvailabilityItems () {
  //   _availabilityItems = [
  //     "ريال يمني",
  //     "دولار أمريكي",
  //     "ريال سعودي",
  //   ];
  // }



}