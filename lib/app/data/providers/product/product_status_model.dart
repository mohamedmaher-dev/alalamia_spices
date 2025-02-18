
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/url.dart';
import '../../../module/app_config/app_config_screen.dart';
import '../../model/product_status.dart';

class ProductStatusModel extends QueryModel{
  ProductStatusModel(super.context);


  bool _status = true;
  bool get status => _status;

  @override
  Future loadData([BuildContext? context]) async{

    if(appModel.token != '') {
      try{

        List productStatus = await fetchData(
          appModel.token == 'visitor'
            ? "${AppUrl.productStatusVisitor}?country_id=$countryId"
            : AppUrl.productStatus
        );
        items.addAll(productStatus.map((product) => ProductStatus.fromJson(product)).toList());
        finishLoading();

      }catch (error) {
        if (kDebugMode) {
          print("ProductStatusModel catch error$error");
        }
      }

    }

  }

  ProductStatus get productStatus => items[0];


  getProductStatus({required String productId}) {

    _status  = true;
      if(items.isNotEmpty){
        for(int i = 0; i < items.length; i++){
          if(productId  == items[i].productId){
            _status = items[i].status == 1 ? true : false;
          }
        }
      }
  }
}