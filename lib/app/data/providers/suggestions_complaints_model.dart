
import 'dart:io';
import 'package:alalamia_spices/app/core/utils/url.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SuggestionsComplaintsModel extends QueryModel {
  SuggestionsComplaintsModel(super.context);

  @override
  Future loadData([BuildContext? context]) async{

  }


  ///this function for send complaint or proposals
  Future sendComplaint({required Suggestions suggestions, File? image,  String? imageName}) async {
    if (await canLoadData()) {
      Map<String, dynamic> postData = suggestions.toJson();
      if (imageName != null) {
        postData.addAll({
          "image": MultipartFile.fromFileSync(image!.path,filename: imageName),
        });
      }
      try {
        if (items.isNotEmpty) items.clear();
        var data = await saveData(AppUrl.suggestion, parameters: postData);
        if (isLoaded) {
          return data;
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  Suggestions get suggestions => items[0];

}