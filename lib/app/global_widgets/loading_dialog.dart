//
// import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
// import 'package:alalamia_spices/app/core/values/app_images.dart';
// import 'package:alalamia_spices/app/core/values/app_lottie.dart';
// import 'package:alalamia_spices/app/data/model/translations.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lottie/lottie.dart';
//
// class LoadingDialog {
//
//
//   Future<void> showSimpleDialog(BuildContext context) async {
//     await showDialog<void>(
//         context: context,
//         barrierDismissible: true,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             backgroundColor: Theme.of(context).primaryColor,
//             elevation: 0.5,
//             title:  SizedBox(
//               height: 50.h,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Lottie.asset(
//                       AppLottie.loading,
//                       width: 50.w,
//                       height: 50.h
//                     ),
//                   ),
//                   10.pw,
//                   Expanded(
//                     child: Text(
//                       allTranslations.text("pleaseWait"),
//                       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             content: null,
//           );
//         });
//   }
//   void hideLoadingDialog (BuildContext context) {
//     Navigator.of(context).pop();
//   }
//
// }

import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../core/values/app_lottie.dart';

class CustomLoadingDialog {
  static void showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomLoadingDialog._buildDialog(context);
      },
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static Widget _buildDialog(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context , listen: false);
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: AlertDialog(
        backgroundColor: themeModel.darkTheme == false
          ? Theme.of(context).primaryColor
          : Colors.grey[400],
        elevation: 0.5,
        title:  SizedBox(
          height: 50.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Lottie.asset(
                    AppLottie.loading,
                    width: 50.w,
                    height: 50.h
                ),
              ),
              10.pw,
              Expanded(
                child: Text(
                  allTranslations.text("pleaseWait"),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
        ),
        content: null,
      ),
    );
  }
}