
import 'package:alalamia_spices/app/core/utils/url.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/request.dart';


class RequestModel extends QueryModel {
  RequestModel(super.context);

  String _requestNumber = "";
  String get requestNumber => _requestNumber;

  @override
  Future loadData([BuildContext? context]) async{

    if (appModel.token != '') {
      List requests = await fetchData(AppUrl.request);
      items.addAll(requests.map((request) => Request.fromJson(request)).toList());
      finishLoading();

      if (kDebugMode) {
        print ("=====RequestModel=====$requests");
      }

    }

  }

  Future addNewRequest(Request request) async {
    if (await canLoadData()) {
      Map<String, dynamic> postData = request.toJson();
      try {
        if (items.isNotEmpty) items.clear();
        var data = await saveData(AppUrl.requestOperation, parameters: postData);
        if (isLoaded) {
          _requestNumber = data['request_number'].toString();
          if (kDebugMode) {
            print(" send request model ==  ${data.toString()}");
            print(" send request model post data ==  ${postData.toString()}");
            print("request number ==  $_requestNumber");
          }

          return data;
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }




  Request get request => items[0];

}