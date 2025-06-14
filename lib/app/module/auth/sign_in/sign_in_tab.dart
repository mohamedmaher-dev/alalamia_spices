// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:io';

import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/core/utils/route.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import '../../../alalamiah_app.dart';
import 'package:alalamia_spices/app/exports/model.dart';

class SignInTab extends StatefulWidget {
  const SignInTab({super.key});

  @override
  State<SignInTab> createState() => _SignInTabState();
}

class _SignInTabState extends State<SignInTab> {
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;
  var userStatus;
  // String? initialCountry;
  // String? dialCode;
  String? numberCode;
  bool _isHidden2 = true;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var countriesModel = Provider.of<CountriesModel>(context);
    countriesModel.getCountryCode();
    // initialCountry = countriesModel.initialCountry;
    // dialCode = countriesModel.dialCode;
    // print("initialCountry  ++ dialCode == $initialCountry + $dialCode");

    return ChangeNotifierProvider<UserModel>(
      create: (context) => UserModel(context),
      child: Consumer<UserModel>(
        builder: (context, model, child) {
          return Container(
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: EdgeInsets.all(10.0.w),
              child: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: <Widget>[
                      /// user phone

                      CustomInternationalPhoneNumber(
                          textInputAction: TextInputAction.next,
                          fieldName: true,
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
                            countriesModel.chosenInitialCountry =
                                number.isoCode!;
                          },
                          textEditingController: phoneController),

                      20.ph,

                      /// password

                      TextFormFieldWithName(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        hintTextFormField:
                            allTranslations.text("enterUserPassword"),
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontFamily: "cairo"),
                        obscureText: _isHidden2,
                        fieldName: allTranslations.text("enterConfirmPassword"),
                        suffixIcon: InkWell(
                          onTap: _toggleNewPasswordView,
                          child: Icon(
                            _isHidden2
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 20,
                            color: Colors.grey, // black color
                          ),
                        ),
                        validator: (value) {
                          if (value.length == 0) {
                            return allTranslations.text('mostEnterPassword');
                          }
                          return null;
                        },
                        onFieldSubmitted: () {
                          FocusScope.of(context).unfocus();
                        },
                      ),

                      20.ph,

                      /// login button
                      CustomButtons(
                        height: 45.h,
                        text: allTranslations.text("login"),
                        textWidget: _isLoading == false
                            ? null
                            : const CircularLoading(),
                        textStyle: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(fontSize: 16.sp),
                        buttonColor: _isLoading == true
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).secondaryHeaderColor,
                        onTap: () async {
                          model.errors.clear();
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });

                            ///object from User save user phone number just
                            if (Platform.isIOS) {
                              await _LoginMethodIos(model, context);
                            } else {
                              await _LoginMethodAndroid(model, context);
                            }
                          } else {
                            setState(() {
                              _isLoading = false;
                            });
                            _formKey.currentState!.validate();
                          }
                        },
                      ),

                      40.ph,

                      /// forgot password & skip
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CustomButtons(
                            text: allTranslations.text("forgotPassword"),
                            textStyle: Theme.of(context).textTheme.bodyLarge,
                            buttonColor: Colors.transparent,
                            onTap: () {
                              pushNamedScreen(context, Routes.phoneScreen,
                                  arguments: true);
                            },
                          ),
                          CustomButtons(
                            text: allTranslations.text("skip"),
                            textStyle:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                            buttonColor: Colors.transparent,
                            onTap: () async {
                              model.visit();

                              ///function restartApp for restart app to save user data info for load app data second to this user
                              await MaterialAppWithTheme.restartApp(context);
                              // Navigator.of(context).pushAndRemoveUntil(
                              //     MaterialPageRoute(builder: (context) =>
                              //     Start()), (Route<dynamic> route) => false);
                            },
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }

  Future<void> _LoginMethodAndroid(
      UserModel model, BuildContext context) async {
    User user = User(phone: "$numberCode");
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    final fcm = await firebaseMessaging.getToken();
    await FCMService.instance.subscribe();
    userStatus = await model.login(user, passwordController.text, fcm!);
    if (model.isLoaded) {
      await _ifLoginIsLoadedMethod(model, context);
    } else {
      return _ifLoginNotLoadedMethod(context);
    }
  }

  Future<void> _LoginMethodIos(UserModel model, BuildContext context) async {
    User user = User(phone: "$numberCode");
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? apnsToken = await firebaseMessaging.getAPNSToken();
    String? fcm;
    if (apnsToken != null) {
      fcm = await firebaseMessaging.getToken();
      await FCMService.instance.subscribe();
      userStatus = await model.login(user, passwordController.text, fcm!);
    } else {
      await Future<void>.delayed(
        const Duration(seconds: 3),
      );
      apnsToken = await firebaseMessaging.getAPNSToken();
      if (apnsToken != null) {
        fcm = await firebaseMessaging.getToken();
        await FCMService.instance.subscribe();
        userStatus = await model.login(user, passwordController.text, fcm!);
      } else {
        userStatus = await model.login(user, passwordController.text, '');
      }
    }
    if (model.isLoaded) {
      /// Subscribe the user to a topic for notifications
      await _ifLoginIsLoadedMethod(model, context);
    } else {
      _ifLoginNotLoadedMethod(context);
    }
  }

  Future<void> _ifLoginIsLoadedMethod(
      UserModel model, BuildContext context) async {
    /// Subscribe the user to a topic for notifications
    // prefs.remove("USER_STATUS");
    setState(() {
      model.newUserCountryId = model.user.countryId.toString();
      model.newUserCountryName = model.user.countryName.toString();
    });

    if (kDebugMode) {
      print("Selected userCountryId = ${model.userCountryId}");
      print("userChosenCountry = ${model.userCountryName}");
    }

    await MaterialAppWithTheme.restartApp(context);
  }

  _ifLoginNotLoadedMethod(BuildContext context) {
    if (userStatus["status_message"] == "attitude") {
      setState(() {
        _isLoading = false;
      });
      return CustomToast.showFlutterToast(
        context: context,
        message: allTranslations.text("accountStopped"),
      );
    }

    ///test if user is deleted
    else if (userStatus["status_message"] == "deleted") {
      setState(() {
        _isLoading = false;
      });
      return CustomToast.showFlutterToast(
        context: context,
        message: allTranslations.text("accountDeleted"),
      );
    } else if (userStatus["status_message"] == "blacklist") {
      setState(() {
        _isLoading = false;
      });
      return CustomToast.showFlutterToast(
        context: context,
        message: allTranslations.text("accountBlackList"),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      return CustomToast.showFlutterToast(
        context: context,
        message: allTranslations.text("incorrectUserData"),
      );
    }
  }

  void _toggleNewPasswordView() {
    setState(() {
      _isHidden2 = !_isHidden2;
    });
  }

  /// Subscribe the user to a topic for notifications
  // final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  // _subscribeToTopic() async {
  //   _fcm.subscribeToTopic('MatjerAlalmia');
  // }
}
