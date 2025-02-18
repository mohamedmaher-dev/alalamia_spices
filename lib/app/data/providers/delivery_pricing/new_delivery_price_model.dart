

import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/url.dart';
import '../../../services/prefs.dart';
import 'package:alalamia_spices/app/exports/model.dart';

class NewDeliveryPriceModel extends QueryModel {
  NewDeliveryPriceModel(super.context);

  String? _minimum;
  String? _currencyName;
  double _price = 0.0;
  String? get minimum => _minimum;
  String? get currencyName => _currencyName;
  double get price => _price;

  set price (double newValue){
    _price = newValue;
    notifyListeners();
  }

  @override
  Future loadData([BuildContext? context]) async{

    try{
      List newDeliveryList = await fetchData(AppUrl.newDeliveryPricing);
      items.addAll(newDeliveryList.map((newDelivery) => NewDeliveryPrice.fromJson(newDelivery)).toList());


    }catch (error) {
      if (kDebugMode) {
        print("NewDeliveryPriceModel catch error$error");
      }
    }
    finishLoading();


    // var data;
    // try{
    //
    //     data = await fetchData(AppUrl.newDeliveryPrice);
    //
    // }catch (error) {
    //   if (kDebugMode) {
    //     print("NewArrivalModel catch error$error");
    //   }
    // }
    //
    // if(data != null){
    //   NewDeliveryPriceData newArrivalData = NewDeliveryPriceData.fromJson(data);
    //   List newArrivalList = newArrivalData.newDeliveryPrice!;
    //   items.addAll(newArrivalList);
    //   finishLoading();
    //   if (kDebugMode) {
    //     print ("=====new arrival model=====$data");
    //     print ("=====new arrival api url ===== ${AppUrl.newDeliveryPrice}");
    //   }
    // }



  }

  NewDeliveryPrice get newDeliveryPrice => items[0];


  getMinimumTotalOrder(BuildContext context) {

    if(items.isNotEmpty){
      for(int i = 0; i < items.length; i++){
        _minimum = items[i].minimum.toString();
        SharedPrefsService.putString(AppConstants.minimum , _minimum!);
      }
    }else {
      _minimum = "0.0";
    }

    // if(kDebugMode){
    //   print(minimum);
    // }


  }

  // getDeliveryPrice(double totalPrice , String currency) {
  //
  //   if (items.isNotEmpty) {
  //     for (int i = 0; i < items.length; i++) {
  //       if (double.parse(items[i].minimum) <= totalPrice && totalPrice <= double.parse(items[i].maximum)) {
  //         _price = double.parse(items[i].fixedDeliveryRate);
  //         break;
  //       }else {
  //         _price = 0.0;
  //
  //       }
  //     }
  //   }
  // }

}