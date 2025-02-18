

import 'package:alalamia_spices/app/core/utils/route.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constants.dart';
import '../../../core/values/app_images.dart';
import '../provider/forgot_password_provider.dart';
import '../provider/phone_provider.dart';
import 'package:alalamia_spices/app/exports/provider.dart';


class PhoneScreen extends StatefulWidget {
  final bool isFromForgotPasswordScreen;
  const PhoneScreen({
    Key? key,
    required this.isFromForgotPasswordScreen
  }) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {

  late TextEditingController phoneController ;
  GlobalKey<FormState> formKey = GlobalKey();
  String? numberCode;
  bool isLoading = false;
  late String error;



  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    error = "";
  }


  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var countriesModel = Provider.of<CountriesModel>(context);
    var userModel = Provider.of<UserModel>(context);
    return GestureDetector(
      onTap: () {
        return FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: Form(
            key: formKey,
            child: ListView(
              children: [
                widget.isFromForgotPasswordScreen == true
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10.0.w),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor
                      ),
                      child: IconButton(
                          onPressed: () {
                            // pushScreenRemoveUntil(context, const AuthTabsScreen());
                            pushNamedRemoveUntil(context, Routes.authTapsScreen);
                            // userModel.isVerification = false;
                          },
                          icon: Icon(
                            Icons.close,
                            color: Theme.of(context).secondaryHeaderColor,
                            size: 28,
                          )
                      ),
                    ),


                    Container(
                      height: 300.h,
                      width: MediaQuery.of(context).size.width,
                      decoration:  BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage(AppImages.login), fit: BoxFit.fill),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(50.w),
                          bottomLeft: Radius.circular(50.w),
                        ),
                      ),
                    ),
                    20.ph,
                  ],
                )
                : 0.ph,


                Padding(
                  padding:  EdgeInsets.all(5.0.w),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    padding:  EdgeInsets.all(15.0.h),
                    decoration: BoxDecoration(
                      borderRadius:    BorderRadius.only(
                        topRight: Radius.circular(AppConstants.defaultBorderRadius.w),
                        topLeft: Radius.circular(AppConstants.defaultBorderRadius.w)
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          allTranslations.text("phoneAuth"),
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp
                          ),
                        ),



                        10.ph,


                        // Container(
                        //   padding: EdgeInsets.symmetric(horizontal: 10.w),
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                        //     border: Border.all(color : Colors.grey[400]!)
                        //   ),
                        //   child: Directionality(
                        //     textDirection: TextDirection.ltr,
                        //     child: InternationalPhoneNumberInput(
                        //       selectorConfig: const SelectorConfig(
                        //           selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        //           useEmoji: true),
                        //       initialValue: PhoneNumber(
                        //           isoCode:  initialCountry,
                        //           dialCode: dialCode
                        //       ),
                        //       onInputChanged: (PhoneNumber number) {
                        //         if (kDebugMode) {
                        //           print(number.phoneNumber);
                        //         }
                        //         setState(() {
                        //           numberCode = number.phoneNumber;
                        //           if (kDebugMode) {
                        //             print(numberCode);
                        //           }
                        //         });
                        //         initialCountry = number.isoCode!;
                        //       },
                        //
                        //       onInputValidated: (bool value) {
                        //         if (kDebugMode) {
                        //           print(value);
                        //         }
                        //       },
                        //       validator: (value) {
                        //         if (value!.isEmpty) {
                        //           return allTranslations.text('enterUserPhone');
                        //         }
                        //         return null;
                        //       },
                        //       ignoreBlank: true,
                        //       inputDecoration: inputDecorationFormField,
                        //       autoValidateMode: AutovalidateMode.disabled,
                        //       textStyle: Theme.of(context).textTheme.bodyMedium!!.copyWith(
                        //           fontFamily: "cairo"
                        //       ),
                        //       selectorTextStyle: Theme.of(context).textTheme.bodyMedium!!.copyWith(
                        //         fontFamily: "cairo"
                        //       ),
                        //       // initialValue: number,
                        //       textFieldController: phoneController,
                        //     ),
                        //   ),
                        // ),

                        CustomInternationalPhoneNumber(
                            textInputAction: TextInputAction.done,
                            onInputChanged: (PhoneNumber number) {
                              if (kDebugMode) {
                                print(number.phoneNumber);
                              }
                              setState(() {
                                numberCode = number.phoneNumber;
                                if (kDebugMode) {
                                  print(numberCode);
                                }
                              });
                              countriesModel.chosenInitialCountry = number.isoCode!;
                            },
                            textEditingController: phoneController
                        ),



                        20.ph,

                        StatefulBuilder(
                          builder: (context , mySetState){
                            return CustomButtons(
                              height: 45.h,
                              text: allTranslations.text("verification"),
                              buttonColor: Theme.of(context).secondaryHeaderColor,
                              isLoading : userModel.isVerification,
                              onTap: () {

                                if(formKey.currentState!.validate()){
                                    userModel.isVerification = true;


                                  if(widget.isFromForgotPasswordScreen == true){
                                    ForgotPasswordProvider().startPhoneAuth (
                                        context : context,
                                        numberCode : numberCode.toString(),

                                    );
                                    // startPhoneAuth(true);
                                  }else {
                                    // pushScreen(context, SignUpTab(phoneNumber: numberCode.toString()));
                                    PhoneProvider().startPhoneAuth(
                                        context : context,
                                        numberCode : numberCode.toString(),
                                    );
                                  }

                                }else {
                                  userModel.isVerification = false;
                                  formKey.currentState!.validate();
                                }


                              },
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
//   startPhoneAuth(bool isOnline) async {
//     if (formKey.currentState!.validate()) {
//       if (isOnline) {
//         print("isOnline");
//         var userProvider = Provider.of<UserModel>(context, listen: false);
//         // var dialog = showProgressDialog(
//         //     context: context,
//         //     loadingText: allTranslations.text('please_wait'),
//         //     backgroundColor: mainColor.withOpacity(0.7));
//
//         ///this function verify from phone number found in database
//         var data = await userProvider.checkPhone(numberCode.toString());
//         if (data == false || data == null) {
//           // dismissProgressDialog();
//           setState(() {
//             error = allTranslations.text("there_is_no_account");
//           });
//         } else {
//           error = "";
//
//           ///start Injaz auth
// //          await userProvider.smsSendCode(
// //              "+967" + controller.text, Url.smsSendCode);
// //          if (userProvider.isLoaded) {
// //            dismissProgressDialog();
// //            Navigator.pushReplacement(
// //                context,
// //                MaterialPageRoute(
// //                    builder: (context) => PinCode(
// //                          phoneNumber: "+967" + controller.text,
// //                          isSignIn: true,
// //                          isResetPassword: true,
// //                        )));
// //          }
//
//           ///start firebase auth
//           FirebasePhoneAuth.instantiate(phoneNumber: numberCode.toString());
//           FirebasePhoneAuth.stateStream.listen((state) {
//             if (state == PhoneAuthState.CodeSent) {
//               // dismissProgressDialog();
//               Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) =>
//                           VerificationCodeScreen(phoneNumber: numberCode, isSignIn: true,isResetPassword: true,)));
//             }
//             if (state == PhoneAuthState.Error) {
//               // dismissProgressDialog();
//             }
//           });
//         }
// //
//       } else {
//         // Fluttertoast.showToast(
//         //     msg: allTranslations.text("make_sure_to_connect"),
//         //     toastLength: Toast.LENGTH_SHORT,
//         //     gravity: ToastGravity.CENTER,
//         //     backgroundColor: pinkColor.withOpacity(0.7),
//         //     textColor: Colors.white,
//         //     fontSize: 16.0);
//       }
//     } else {
//       formKey.currentState!.validate();
//     }
//   }
}
