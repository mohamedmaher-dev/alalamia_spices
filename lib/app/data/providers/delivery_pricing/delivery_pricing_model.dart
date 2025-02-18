// import 'package:alalamia_spices/app/core/utils/url.dart';
// import 'package:alalamia_spices/app/exports/provider.dart';
// import 'package:alalamia_spices/app/exports/provider.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
//
//
// class DeliveryPricingModel extends QueryModel {
//   DeliveryPricingModel(super.context);
//
//   @override
//   Future loadData([BuildContext? context , String? id1,String? id2]) async {
//     var data;
//     try{
//       data = await fetchDataa("${AppUrl.deliveryPricing}${id1!}-$id2" ,"");
//
//     }catch (error) {
//       if (kDebugMode) {
//         print("DeliveryPricingModel catch error$error");
//       }
//     }
//
//     if(data != null){
//       DeliveryPricingData deliveryPricingData = DeliveryPricingData.fromJson(data);
//       List deliveryPriceList = deliveryPricingData.deliveryPricing!;
//       items.addAll(deliveryPriceList);
//       finishLoading();
//       if (kDebugMode) {
//         print ("=====DeliveryPricingModel=====$data");
//         print ("=====DeliveryPricingModel api url ===== ${AppUrl.deliveryPricing}${id1!}-$id2");
//       }
//     }
//   }
//
//   DeliveryPricing get deliveryPricing => items[0];
//
// }