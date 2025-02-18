

import 'dart:io';

import 'package:alalamia_spices/app/core/utils/url.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/special_order.dart';



class SpecialOrderModel extends QueryModel {
  SpecialOrderModel(super.context);

  String _mustSelectDateError = '';
  String _mustSelectBranch = '';
  String get mustSelectDateError => _mustSelectDateError;
  String get mustSelectBranch => _mustSelectBranch;

  set mustSelectDateError (String date){
    _mustSelectDateError = date;
    notifyListeners();
  }

  set mustSelectBranch (String branchId){
    _mustSelectBranch = branchId;
    notifyListeners();
  }


  @override
  Future loadData([BuildContext? context]) async{

    if (appModel.token != '' && await canLoadData()) {
      List? userSpecialOrders;
      try {
        userSpecialOrders = await fetchData("${AppUrl.specialOrderAll}/all");
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      items.addAll(userSpecialOrders!.map((specialOrder) => SpecialOrder.fromJson(specialOrder)).toList());
      if(kDebugMode){
        print("special order model $userSpecialOrders");
      }
    }
    finishLoading();



  }

  Future sendSpecialOrder(SpecialOrder specialOrder, File? image, String? imageName, [BuildContext? context]) async {
    if (await canLoadData()) {
      Map<String, dynamic> postData = specialOrder.toJson();
      if (image != null) {
        postData.addAll({"image": MultipartFile.fromFileSync(image.path, filename: imageName),
        });
      }
      try {
        if (items.isNotEmpty) items.clear();
        await saveData(AppUrl.specialOrder, parameters: postData);

        if (kDebugMode) {
          print({"special order post data == ${postData.toString()}"});
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  SpecialOrder get specialOrder => items[0];

}