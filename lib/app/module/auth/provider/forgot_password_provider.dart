import 'package:alalamia_spices/app/core/utils/route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import '../../../global_widgets/custom_toast.dart';
import '../../../services/screen_navigation_service.dart';
import '../verification_code/verification_code_screen.dart';
import 'firebase_configration.dart';


class ForgotPasswordProvider {

  String? errorMessage;
  startPhoneAuth({
    required BuildContext context,
    required String numberCode,

  }) async {

    var userModel = Provider.of<UserModel>(context, listen: false);
    // var countriesModel = Provider.of<CountriesModel>(context, listen: false);
    if (kDebugMode) {
      print(numberCode);
    }

    // if(countriesModel.initialCountry == "YE" && countriesModel.dialCode == "967"){
    //   try{
    //     var data = await userModel.checkPhone(numberCode);
    //     if (data == false || data == null) {
    //
    //       CustomToast.showFlutterToast(
    //           context: context,
    //           message: allTranslations.text("accountNotExist"),
    //           toastLength: Toast.LENGTH_LONG
    //       );
    //       pushScreen(context, const AuthTabsScreen());
    //       // userModel.isVerifyForgetPassword = false;
    //       errorMessage;
    //
    //     } else {
    //       pushScreenReplacement(context, ForgotPasswordScreen(phoneNumber: numberCode,));
    //     }
    //   }catch (error){
    //     print("smsVerification null error = $error");
    //     // userModel.isVerification = false;
    //   }
    // }
    // else {
      ///this function verify from phone number found in database
      var data = await userModel.checkPhone(numberCode);
      if (data == false || data == null) {

        CustomToast.showFlutterToast(
            context: context,
            message: allTranslations.text("accountNotExist"),
            toastLength: Toast.LENGTH_LONG
        );
        userModel.isVerification = false;
        // pushScreen(context, const AuthTabsScreen());
        pushNamedScreen(context, Routes.authTapsScreen);
        errorMessage;
      } else {
        errorMessage = "";
        ///start firebase auth
        FirebasePhoneAuth.instantiate(phoneNumber: numberCode);
        FirebasePhoneAuth.stateStream.listen((state) {
          if (state == PhoneAuthState.CodeSent) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>   VerificationCodeScreen(
                  phoneNumber: numberCode,
                  isSignIn: true,
                  isResetPassword: true,
                ))
            );


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
    // }

  }

}