
import 'package:alalamia_spices/app/core/utils/route.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/module/auth/auth_tabs_screen.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../services/screen_navigation_service.dart';
import '../verification_code/verification_code_screen.dart';
import 'firebase_configration.dart';

class PhoneProvider {

  String? errorMessage;
  startPhoneAuth({
    required BuildContext context,
    required String numberCode,

  }) async {

        var userModel = Provider.of<UserModel>(context, listen: false);
        // var countriesModel = Provider.of<CountriesModel>(context, listen: false);
        if (kDebugMode) {
          print(numberCode);
          // print("${countriesModel.initialCountry} ${ countriesModel.dialCode}");
        }


        // if(countriesModel.initialCountry == "YE" && countriesModel.dialCode == "967"){
        //   try{
        //     var data = await userModel.checkPhone(numberCode);
        //     print('phone  $numberCode');
        //
        //
        //     if (data) {
        //       if (kDebugMode) {
        //         print('data  $data');
        //         print('user found');
        //       }
        //
        //       CustomToast.showFlutterToast(
        //           context: context,
        //           message: allTranslations.text("accountExist"),
        //           toastLength: Toast.LENGTH_LONG
        //       );
        //       // userModel.isVerification = false;
        //       pushScreen(context, const AuthTabsScreen());
        //       // userModel.phoneErrorMessage = '';
        //
        //
        //     }else {
        //       if (kDebugMode) {
        //         print('user not found');
        //         print('data  $data');
        //       }
        //       pushScreenRemoveUntil(context,  SignUpTab(phoneNumber: numberCode));
        //       // userModel.isVerification = false;
        //     }
        //   }catch (error){
        //     print("smsVerification null error = $error");
        //     // userModel.isVerification = false;
        //   }
        // }
        // else {
          ///this function verify from phone number found in database
          var data = await userModel.checkPhone(numberCode);
          if (data) {

            CustomToast.showFlutterToast(
                context: context,
                message: allTranslations.text("accountExist"),
                toastLength: Toast.LENGTH_LONG
            );
            // pushScreen(context, const AuthTabsScreen());
            pushNamedScreen(context, Routes.authTapsScreen);
            userModel.isVerification = false;
            errorMessage;
          }
          else {
            errorMessage = "";
            ///start firebase auth
            FirebasePhoneAuth.instantiate(phoneNumber: numberCode);
            FirebasePhoneAuth.stateStream.listen((state) {
              if (state == PhoneAuthState.CodeSent) {
                pushScreen(
                    context,
                    VerificationCodeScreen(
                      phoneNumber: numberCode,
                      isSignIn: true,
                      isResetPassword: false,
                    ));
                userModel.isVerification = false;
              }
              if (state == PhoneAuthState.Error) {
                CustomToast.showFlutterToast(
                    context: context,
                    message: allTranslations.text("errorOccurred"),
                    toastLength: Toast.LENGTH_LONG
                );
                userModel.isVerification = false;
              }
            });
          }
        }
  // }
}