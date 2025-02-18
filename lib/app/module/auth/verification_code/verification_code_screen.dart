

import 'package:alalamia_spices/app/core/utils/constants.dart';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/global_widgets/circular_loading.dart';
import 'package:alalamia_spices/app/global_widgets/custom_buttons.dart';
import 'package:alalamia_spices/app/module/auth/forgot_password/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../../../core/values/app_images.dart';
import '../provider/firebase_configration.dart';
import '../sign_up/sign_up_tab.dart';


class VerificationCodeScreen extends StatefulWidget {
  final String? phoneNumber;
  final bool? isResetPassword;
  final bool? isSignIn;
  bool?  error;
   VerificationCodeScreen({
     Key? key,
     this.phoneNumber ,
     this.isResetPassword,
     this.isSignIn,
     this.error
   }) : super(key: key);

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> with TickerProviderStateMixin {

  TextEditingController codeController = TextEditingController();
   bool isLoading = false;
   late final AnimationController _controller;
   String? phone;
   String? currentText = "";

   @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    FirebasePhoneAuth.phoneAuthState.stream.listen((PhoneAuthState state) {
      if (state == PhoneAuthState.Verified) {
        widget.isSignIn!
            ? widget.isResetPassword!
            ? Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ForgotPasswordScreen(
                  phoneNumber: phone!,

                )))
            : Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SignUpTab(phoneNumber: phone!)))
            : null;
      }
    });
    FirebasePhoneAuth.phoneAuthState.stream
        .listen((PhoneAuthState state) => debugPrint(state.toString()));
    FirebasePhoneAuth.actualCode.toString();
    phone = widget.phoneNumber;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
     var userModel = Provider.of<UserModel>(context);
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.h,
      textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
        fontWeight: FontWeight.bold,
        fontFamily: "cairo"
      ),
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
          color: Theme.of(context).primaryColor
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Theme.of(context).colorScheme.secondary),
      borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Theme.of(context).primaryColor,
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: ListView(
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
                    Navigator.pop(context);
                    userModel.isVerification = false;
                  },
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).secondaryHeaderColor,
                      size: 28.r,
                    )
                ),
              ),
              20.ph,
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

              Container(
                padding: EdgeInsets.all(10.0.w),
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    Text(
                      allTranslations.text("verificationCodeSubTitle"),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        fontSize: 16.sp
                      ),
                    ),
                    20.ph,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          allTranslations.text("toYourPhone"),
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            fontSize: 14.sp
                          ),
                        ),
                        10.pw,
                        Text(
                          phone.toString(),
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            fontSize: 14.sp,
                            fontFamily: "cairo"
                          ),
                        ),
                      ],
                    ),

                    30.ph,
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Container(
                        alignment: Alignment.center,
                        child: Pinput(
                          length: 6,
                          controller: codeController,
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: focusedPinTheme,
                          submittedPinTheme: submittedPinTheme,
                          validator: (s) {
                            // return s == '222222' ? null : 'Pin is incorrect';
                          },
                          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                          showCursor: true,
                          onCompleted: (pin) => debugPrint(pin.toString()),
                          onChanged: (value){
                            setState(() {
                              currentText = value;
                            });
                          },
                        ),
                      ),
                    ),

                    40.ph,

                    StatefulBuilder(
                      builder: (context, mySetState) {
                        return CustomButtons(
                          height: 45.h,
                          text: isLoading == false ? allTranslations.text("verification") : "",
                          buttonColor: Theme.of(context).secondaryHeaderColor,
                          isLoading: isLoading,
                          onTap: isLoading == true
                              ? null
                              : () async {
                            if (codeController.text.length == 6) {
                              mySetState(() {
                                isLoading = true; // Start loading
                              });

                              try {
                                await FirebasePhoneAuth.signInWithPhoneNumber(
                                  smsCode: codeController.text,
                                  context: context,
                                  phoneNumber: phone.toString(),
                                  isSignIn: widget.isSignIn!,
                                  isRestPassword: widget.isResetPassword!,
                                );
                              } catch (error) {
                                // Handle error and stop loading
                                mySetState(() {
                                  isLoading = false;
                                });

                                // Show error message to the user
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Verification failed: ${error.toString()}",
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } finally {
                                // Ensure loading is stopped even if the process completes successfully
                                mySetState(() {
                                  isLoading = false;
                                });
                              }
                            } else {
                              // Show error if the code is not 6 digits
                              ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(
                                  content: Text(
                                    allTranslations.text("authCodeLength"),
                                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                                      fontFamily: 'cairo'
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),

                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
