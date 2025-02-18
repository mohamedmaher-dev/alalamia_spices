

import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/url.dart';
import '../../../module/app_config/app_config_screen.dart';

class ProductImageModel extends QueryModel {
  final String productId;
  ProductImageModel(super.context  , this.productId);

  @override
  Future loadData([BuildContext? context]) async {
    // var countriesModel  = Provider.of<CountriesModel>(context! , listen: false);
    var data;
    try{
      data = await fetchDataa(
          appModel.token == "visitor"
          ? "${AppUrl.productImagesVisitor}$productId?country_id=$countryId"
          : "${AppUrl.productImages}$productId" , "");

    }catch (error) {
      if (kDebugMode) {
        print("product image catch error$error");
      }
    }

    if(data != null){
      ProductImageData productImageData = ProductImageData.fromJson(data);
      List productImageList = productImageData.productImage!;
      items.addAll(productImageList);
      finishLoading();

      // if (kDebugMode) {
      //   print ("=====product image model=====$data");
      //   print ("=====product image api url ===== ${AppUrl.productImages}$productId");
      // }
    }

  }
  ProductImage get productImage => items[0];
}