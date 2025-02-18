
import 'package:alalamia_spices/app/core/utils/url.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FinancialPortfoliosModel extends QueryModel {
  FinancialPortfoliosModel(super.context);

  // String _chosenPayment = allTranslations.text("receipt");
  // String get chosenPayment => _chosenPayment;
  // set chosenPayment (String newValue){
  //   _chosenPayment = newValue;
  //   notifyListeners();
  // }

  List<DropdownMenuItem<String>> _financialItems = [];
  List<DropdownMenuItem<String>> get financialItems => _financialItems;
  String? currentFinancial;

  @override
  Future loadData([BuildContext? context]) async{

    var data;
    try{
      data = await fetchDataa(AppUrl.financialPortfolios , "");

    }catch (error) {
      if (kDebugMode) {
        print("FinancialPortfoliosModel catch error$error");
      }
    }

    if(data != null){

      FinancialPortfoliosData financialPortfoliosData = FinancialPortfoliosData.fromJson(data);
      List financialList = financialPortfoliosData.financialPortfolios!;
      items.addAll(financialList.reversed);
      finishLoading();
      // if (kDebugMode) {
      //   print ("=====FinancialPortfoliosModel=====$data");
      //   print ("=====FinancialPortfoliosModel url ===== ${AppUrl.financialPortfolios}");
      // }

    }

  }

  FinancialPortfolios get financialPortfolios => items[0];


  // getFinancialPortfolios() {
  //   _financialItems = [];
  //   for (var i = 0; i < items.length; i++) {
  //     _financialItems.add(DropdownMenuItem(
  //       value: "${items[i].name}",
  //       child:  Padding(
  //         padding:  EdgeInsets.all(5.0.w),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text("${items[i].name}"),
  //
  //             ClipRRect(
  //               borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
  //               child: CustomCachedNetworkImage(
  //                 imageUrl: items[i].imagePath100.toString(),
  //                 fit: BoxFit.contain,
  //                 width: 30.w,
  //                 height: 30.h,
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ));
  //
  //     currentFinancial = items[0].name;
  //
  //   }
  //
  // }

}