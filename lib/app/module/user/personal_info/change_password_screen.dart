

import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/global_widgets/custom_app_bar.dart';
import 'package:alalamia_spices/app/global_widgets/text_form_field_with_name.dart';
import 'package:alalamia_spices/app/module/user/user_screen/widget/index.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constants.dart';
import '../../../core/values/app_lottie.dart';
import '../../../global_widgets/custom_buttons.dart';
import '../../../global_widgets/custom_dialog.dart';
import '../../../global_widgets/custom_toast.dart';
import '../../auth/auth_tabs_screen.dart';


class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isHidden = true;
  bool _isHidden2 = true;
  bool _isHidden3 = true;


  @override
  void dispose() {
    super.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // var networkStatus = Provider.of<NetworkStatus>(context);
    var connection = Provider.of<ConnectivityNotifier>(context);
    return ChangeNotifierProvider<UserModel>(
      create: (context) => UserModel(context),
      child: Consumer<UserModel>(
        builder: (context , model , child) {
          model.isLoading || model.loadingFailed
              ? ""
              : model.getUserInfo();
          return SafeArea(
            child: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
                child: const CustomAppBar(),
              ),
              body: GestureDetector(
                onTap: (){
                  return FocusScope.of(context).unfocus();
                },
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          20.ph,
                           UserHeader(),


                          Container(
                              padding: EdgeInsets.all(10.0.w),
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius:   BorderRadius.only(
                                      topRight: Radius.circular(AppConstants.defaultBorderRadius.w),
                                      topLeft: Radius.circular(AppConstants.defaultBorderRadius.w)
                                  )
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [

                                  /// current password
                                  TextFormFieldWithName(
                                    controller: currentPasswordController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    hintTextFormField:  allTranslations.text("currentPassword"),
                                    fieldName: allTranslations.text("enterCurrentPassword"),
                                    obscureText: _isHidden,
                                    suffixIcon: InkWell(
                                      onTap: _toggleCurrentPasswordView,
                                      child: Icon(
                                        _isHidden
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        size: 20,
                                        color: Theme.of(context).secondaryHeaderColor, // black color
                                      ),
                                    ),

                                    validator: (value){
                                      if (model.errors.containsKey('old_password')) {
                                        return model.errors['old_password'][0];
                                      }
                                      if (value.length == 0) {
                                        return allTranslations.text('enterNewPassword');
                                      }

                                      return null;
                                    },
                                    onFieldSubmitted: (){
                                      FocusScope.of(context).nextFocus();
                                    },
                                  ),
                                  20.ph,

                                  /// new password
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


                                  /// confirm password
                                  TextFormFieldWithName(
                                    controller: confirmPasswordController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    hintTextFormField:  allTranslations.text("currentPassword"),
                                    fieldName: allTranslations.text("enterCurrentPassword"),
                                    obscureText: _isHidden3,
                                    suffixIcon: InkWell(
                                      onTap: _toggleConfirmPasswordView,
                                      child: Icon(
                                        _isHidden3
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
                                        return allTranslations.text('enterConfirmPassword');
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

                                  40.ph,

                                  CustomButtons(
                                    width: 100.w,
                                    height: 45.h,
                                    text: allTranslations.text("save"),
                                    isLoading : model.changePasswordLoading,
                                    buttonColor: Theme.of(context).secondaryHeaderColor,
                                    onTap: () async{

                                      if(connection.hasConnection){
                                        model.errors.clear();

                                         model.changePasswordLoading  = true;

                                        if (formKey.currentState!.validate()) {

                                          await model.editUserPassword(
                                              model.user,
                                              oldPass: currentPasswordController.text,
                                              newPass: newPasswordController.text,
                                              confirmPass: confirmPasswordController.text
                                          );


                                          if (model.isLoaded) {
                                            CustomDialog.showCustomDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                title: allTranslations.text("editUserInfoSuccessfully"),
                                                icon: Lottie.asset(
                                                  AppLottie.checkMark,
                                                  width: 100.w,
                                                  height: 100.h,
                                                  repeat: false,
                                                ),
                                                withYesButton: true,
                                                withActions: true,
                                                onPressed: () async{
                                                  await model.logout();
                                                  pushScreenRemoveUntil(context, const AuthTabsScreen());
                                                  CustomDialog.hideCustomDialog(context);
                                                }
                                            );
                                          }
                                          else {
                                            model.changePasswordLoading = false;
                                            CustomDialog.showCustomDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              title: allTranslations.text("wrongOldPassword"),
                                              icon: Lottie.asset(
                                                AppLottie.error,
                                                width: 100.w,
                                                height: 100.h,
                                                repeat: false,
                                              ),
                                              withActions: true,
                                              withYesButton: true,
                                              onPressed: () {
                                                CustomDialog.hideCustomDialog(context);
                                              }
                                            );
                                          }
                                        }else {
                                          model.changePasswordLoading = false;
                                          formKey.currentState!.validate();
                                        }

                                      }else {
                                        model.changePasswordLoading = false;
                                        CustomToast.showFlutterToast(
                                          context: context,
                                          message: allTranslations.text("networkConnection"),
                                          toastLength: Toast.LENGTH_LONG,
                                        );
                                      }




                                    },

                                  ),



                                ],
                              )
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _toggleCurrentPasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }


  void _toggleNewPasswordView() {
    setState(() {
      _isHidden2 = !_isHidden2;
    });
  }

  void _toggleConfirmPasswordView() {
    setState(() {
      _isHidden3 = !_isHidden3;
    });
  }


}
