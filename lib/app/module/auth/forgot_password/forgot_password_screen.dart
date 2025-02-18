

import 'dart:math';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/core/values/app_lottie.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/module/auth/auth_tabs_screen.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constants.dart';
import '../../../core/values/app_images.dart';
import 'package:alalamia_spices/app/exports/widget.dart';


class ForgotPasswordScreen extends StatefulWidget {
  final String phoneNumber;
  const ForgotPasswordScreen({
    Key? key,
    required this.phoneNumber
  }) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {


  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late int rNum;
  late String error;
  bool isLoading = false;
  bool _isHidden2 = true;

  @override
  void initState() {
    super.initState();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    int min = 100000; //min and max values act as your 6 digit range
    int max = 999999;
    var random =   Random();
    rNum = min + random.nextInt(max - min);
    debugPrint(rNum.toString());
    error = "";
  }


  @override
  void dispose() {
    super.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: ChangeNotifierProvider<UserModel>(
          create: (context) => UserModel(context),
          child: Consumer<UserModel>(
            builder: (context , model , child){
              return  Form(
                key: formKey,
                child: ListView(
                  children: [
                    Column(
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
                                pushScreenRemoveUntil(context, const AuthTabsScreen());
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
                            child: ListView(
                              shrinkWrap: true,
                              primary: false,
                              children: [

                                Text(
                                  allTranslations.text("enterNewPassword"),
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp
                                  ),
                                ),

                                20.ph,



                                TextFormFieldWithName(
                                  controller: newPasswordController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  hintTextFormField:  allTranslations.text("newPassword"),
                                  fieldName: allTranslations.text("enterNewPassword"),
                                  obscureText: _isHidden2,
                                  suffixIcon: InkWell(
                                    onTap: _toggleNewPasswordView,
                                    child: Icon(
                                      _isHidden2
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      size: 20,
                                      color: Theme.of(context).secondaryHeaderColor, // black color
                                    ),
                                  ),

                                  validator: (value){
                                    if (model.errors.containsKey('password')) {
                                      return model.errors['password'][0];
                                    }
                                    if (value.length == 0) {
                                      return allTranslations.text('newPassword');
                                    }
                                    if ( value.length <= 7) {
                                      return allTranslations.text("passwordFieldsNumber");
                                    }

                                    return null;
                                  },
                                  onFieldSubmitted: (){
                                    FocusScope.of(context).nextFocus();
                                  },
                                ),

                                20.ph,


                                TextFormFieldWithName(
                                  controller: confirmPasswordController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  hintTextFormField:  allTranslations.text("confirmPassword"),
                                  fieldName: allTranslations.text("confirmCurrentPassword"),
                                  obscureText: _isHidden2,
                                  suffixIcon: InkWell(
                                    onTap: _toggleNewPasswordView,
                                    child: Icon(
                                      _isHidden2
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      size: 20,
                                      color: Theme.of(context).secondaryHeaderColor, // black color
                                    ),
                                  ),

                                  validator: (value){
                                    if (model.errors.containsKey('c_password')) {
                                      return model.errors['c_password'][0];
                                    }
                                    if ( value.length == 0) {
                                      return allTranslations.text('confirmPassword');
                                    }
                                    if (value != newPasswordController.text) {
                                      return allTranslations.text("passwordNotMatch");
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (){
                                    FocusScope.of(context).unfocus();
                                  },
                                ),

                                20.ph,

                               StatefulBuilder(
                                 builder: (context , mySetState){
                                   return  CustomButtons(
                                     height: 45.h,
                                     text: allTranslations.text("agree"),
                                     textWidget: isLoading == true
                                         ? const CircularLoading()
                                         : null,
                                     buttonColor: isLoading == true
                                         ? Theme.of(context).colorScheme.surface
                                         : Theme.of(context).secondaryHeaderColor,
                                     onTap: () async{
                                       if (formKey.currentState!.validate()) {
                                         mySetState((){
                                           isLoading = true;
                                         });
                                         await model.smsResetPassword(
                                             phone: widget.phoneNumber,
                                             code: rNum.toString(),
                                             password: newPasswordController.text,
                                             passwordConfirmation: confirmPasswordController.text

                                         );
                                         if (model.isLoaded) {
                                           mySetState((){
                                             isLoading = false;
                                           });
                                           CustomDialog.showCustomDialog(
                                               context: context,
                                               barrierDismissible: false,
                                               title: allTranslations.text("passwordChangedSuccessfully"),
                                               withActions: true,
                                               withYesButton: true,
                                               icon: Lottie.asset(
                                                   AppLottie.checkMark,
                                                   repeat: false
                                               ),

                                               onPressed: () {
                                                 pushScreenRemoveUntil(context, const AuthTabsScreen());
                                                 // CustomLoadingDialog.hideLoading(context);
                                               }
                                           );

                                         } else {
                                           mySetState((){
                                             isLoading = false;
                                           });
                                         }

                                       } else {
                                         mySetState((){
                                           isLoading = false;
                                         });
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
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  void _toggleNewPasswordView() {
    setState(() {
      _isHidden2 = !_isHidden2;
    });
  }

}
