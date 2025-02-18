

import 'package:alalamia_spices/app/core/utils/url.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:flutter/foundation.dart';
import '../../services/prefs.dart';
import 'package:flutter/material.dart';

class UserWalletModel extends QueryModel {
  UserWalletModel(super.context);

  String? _userBalance;
  // String? _userCurrency;
  String get userBalance => _userBalance!;

   bool _hiddenBalance = false;
   bool get hiddenBalance => _hiddenBalance;

   set hiddenBalance (bool newValue){
     _hiddenBalance = newValue;
     notifyListeners();
   }

  @override
  Future loadData([BuildContext? context]) async{
    try{
      List userWallet = await fetchData(AppUrl.userWallet);
      items.addAll(userWallet.map((userWallet) => UserWallet.fromJson(userWallet)).toList());
      SharedPrefsService.putString("userBalance", userCurrentBalance.currentBalance ?? "");
      // prefs.setString("userBalanceCurrency", userCurrentBalance.currency ?? "");
      finishLoading();
    }catch (error) {
        debugPrint("UserWalletModel catch error$error");

    }


  }

  UserWallet get userCurrentBalance => items[0];


  Future getUserBalance() async{
    _userBalance = SharedPrefsService.getString("userBalance");
  }
}