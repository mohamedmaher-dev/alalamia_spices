

import 'package:alalamia_spices/app/core/utils/url.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../services/prefs.dart';

class ContentModel extends QueryModel {
  ContentModel(super.context);

  String _aboutMatjer = "";
  String get aboutMatjer => _aboutMatjer;

  @override
  Future loadData([BuildContext? context]) async{
    var data;
    if(appModel.token != ''){
      try{
        data = await fetchDataa(
            appModel.token == 'visitor'
            ? AppUrl.contentVisitor
            : AppUrl.content, ""
        );
      }catch (error){
        if (kDebugMode) {
          print("content model catch error $error");
        }
      }

      if(data != null){
        ContentData contentData = ContentData.fromJson(data);
        List contentList = contentData.content!;
        items.addAll(contentList);
        if(items.isNotEmpty){
          SharedPrefsService.putString("theShop", content.theShop ?? "");
        }

        finishLoading();
        // if (kDebugMode) {
        //   print ("=====content model=====$data");
        //   print ("=====content model===== ${AppUrl.content}");
        // }
      }

    }
  }

  Content get content => items[0];

  Future getShopContent () async {
    _aboutMatjer = SharedPrefsService.getString("theShop") ?? "";
  }

}