import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/utils/url.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';

class ListenToRequestStatusModel extends QueryModel{
  final String id;
  ListenToRequestStatusModel(super.context , this.id);

  bool _cancelingOrder = false;
  bool get cancelingOrder => _cancelingOrder;

  set cancelingOrder (bool newValue){
    _cancelingOrder = newValue;
    notifyListeners();
  }

  @override
  Future loadData([BuildContext? context]) async {
    if (appModel.token!='' && await canLoadData()) {
      var status = await fetchData("${AppUrl.requestDetails}$id/call_request_status");
      if(status != null)
      {
        StatusData statusData = StatusData.fromJson(status);
        items.add(statusData);
        finishLoading();
      }

    }
  }
  StatusData get status => items[0];

  Future cancelRequestFunction({required String id}) async {
    if (await canLoadData()) {
      Map<String, dynamic> postData = {};
      try {
        await deleteData("${AppUrl.cancelRequest}$id/cancel", parameters: postData);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }
}