
import 'package:alalamia_spices/app/core/utils/url.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class RatingOrderModel extends QueryModel {
  RatingOrderModel(super.context);

  @override
  Future loadData([BuildContext? context]) async{

    List rate = await fetchData(AppUrl.rate);
    items.addAll(rate.map((rate) => Rate.fromJson(rate)).toList());
  }

  RatingOrderData get rates => items[0];


  Future sendRate(RatingOrderData rate, [BuildContext? context]) async {
    if (await canLoadData()) {
      Map<String, dynamic> postData = rate.toJson();
      try {
        if(items.isNotEmpty) items.clear();
        await saveDataWithoutFormData(AppUrl.sendRate, parameters: postData);
        if (kDebugMode) {
          print("======= rated done ============$postData");
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

}