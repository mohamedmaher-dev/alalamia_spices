

import 'dart:io';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/utils/url.dart';
import 'package:flutter/material.dart';

class MerchantModel extends QueryModel {
  MerchantModel(super.context);

  @override
  Future loadData([BuildContext? context]) async{

  }


  Future<void> sendTransferRequestMerchant ({
    required File logImage,
    required File storeImage ,
    // required String logImageName ,
    // required String storeImageName,
    required String description
  }) async{
    if (await canLoadData()) {
      Map<String, dynamic> postData = {};
      postData.addAll({"text": description});
      if (logImage != null && storeImage != null) {
        postData.addAll({"log_photos": MultipartFile.fromFileSync(logImage.path),});
        postData.addAll({"shop_photo": MultipartFile.fromFileSync(storeImage.path),});
      }
      try {
        await saveData(AppUrl.sendMerchant, parameters: postData);
        if (kDebugMode) {
          print(postData);
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

}