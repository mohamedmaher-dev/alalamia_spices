import 'dart:math';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/core/values/app_lottie.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/module/auth/auth_tabs_screen.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../alalamiah_app.dart';
import '../../../core/utils/constants.dart';
import '../../../core/values/app_images.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import '../../user/contact_us/privacy__return_policy_screen.dart';

String gender = "man";

class SignUpTab extends StatefulWidget {
  final String phoneNumber;
  const SignUpTab({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<SignUpTab> createState() => _SignUpTabState();
}

class _SignUpTabState extends State<SignUpTab> with TickerProviderStateMixin{
  late TextEditingController emailController;
  late TextEditingController userNameController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  final GlobalKey<FormState> _formKey = GlobalKey();
  String? chosenValue;
  String? chosenCountry;
  late String chosenCountryId;
  bool _isHidden = true;
  bool isLoading = false;
  var signUpErrors;
  AnimationController? animationController;
  Animation<double>? animation;
  bool accept = true;


  // _launchURL(url, msg) async {
  //   if (await canLaunchUrl(Uri.parse(url))) {
  //     await launchUrl(Uri.parse(url));
  //   } else {
  //     throw msg;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    userNameController = TextEditingController();
    confirmPasswordController = TextEditingController();
    chosenCountryId = "";


    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() => setState(() {}));

    animation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(animationController!);
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    emailController.dispose();
    userNameController.dispose();
    confirmPasswordController.dispose();
  }

  vector.Vector3 _shake() {
    double progress = animationController!.value;
    double offset = sin(progress * pi * 10.0);
    return vector.Vector3(offset * 2, 0.0, 0.0);
  }

  @override
  Widget build(BuildContext context) {
    var countriesModel = Provider.of<CountriesModel>(context);
    countriesModel.getCountryCode();
    debugPrint("cccccccccc ${countriesModel.selectedCountryId}");
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: ChangeNotifierProvider<UserModel>(
        create: (context) => UserModel(context),
        child: Consumer<UserModel>(
          builder: (context, model, child) {
            countriesModel.getCountriesList();
            return Container(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: EdgeInsets.all(10.0.w),
                child: Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      primary: false,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(
                              margin: EdgeInsets.all(10.0.w),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).colorScheme.surface
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
                              decoration:   BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage(AppImages.login),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(50.w),
                                  bottomLeft: Radius.circular(50.w),
                                ),
                              ),
                            ),

                            /// user name
                            TextFormFieldWithName(
                              controller: userNameController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              hintTextFormField:
                                  allTranslations.text("enterUserName"),
                              fieldName: allTranslations.text("userName"),
                              fieldRequired: const Icon(
                                CupertinoIcons.staroflife_fill,
                                color: Colors.red,
                                size: 10,
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                              onFieldSubmitted: () {
                                FocusScope.of(context).nextFocus();
                              },
                              validator: (v) {
                                if (model.errors.containsKey('name')) {
                                  return model.errors['name'][0];
                                }
                                if (v.length == 0) {
                                  return allTranslations.text('enterUserName');
                                }
                                return null;
                              },
                              // textInputFormatter: [
                              //   // ignore: deprecated_member_use
                              //   FilteringTextInputFormatter.allow(
                              //       RegExp('[a-zA-Z أ-ي  ء]'))
                              // ],
                            ),

                            15.ph,

                            /// email
                            TextFormFieldWithName(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              hintTextFormField:
                                  allTranslations.text("enterUserEmail"),
                              fieldName: allTranslations.text("email"),
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Colors.grey,
                              ),
                              onFieldSubmitted: () {
                                FocusScope.of(context).nextFocus();
                              },
                            ),

                            15.ph,

                            /// country
                            // countriesModel.isLoading || countriesModel.loadingFailed
                            //     ? const CircularLoading()
                            //     : Column(
                            //         mainAxisAlignment: MainAxisAlignment.start,
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           Text(
                            //             allTranslations
                            //                 .text("chooseCountryHintTxt"),
                            //             style:
                            //                 Theme.of(context).textTheme.bodyMedium!,
                            //           ),
                            //           10.ph,
                            //           StatefulBuilder(
                            //             builder: (context, mySetState) {
                            //               return CustomDropDown(
                            //                   listItem: countriesModel.countriesItems,
                            //                   value: chosenCountry == ""
                            //                     ? countriesModel.currentCountry.toString()
                            //                     : chosenCountry.toString(),
                            //                   hintText: allTranslations
                            //                       .text("chooseCountryHintTxt"),
                            //                   fillColor:
                            //                       Theme.of(context).primaryColor,
                            //                   onChanged: (value) {
                            //                     mySetState(() {
                            //                       chosenCountry = value.toString();
                            //                       countriesModel.currentCountry = value.toString();
                            //                     });
                            //
                            //                     for (var i = 0;
                            //                         i < countriesModel.items.length;
                            //                         i++) {
                            //                       if (chosenCountry == countriesModel.items[i].name.toString()) {
                            //                         mySetState(() {
                            //                           chosenCountryId = countriesModel.items[i].id.toString();
                            //                         });
                            //                       }
                            //                     }
                            //
                            //                     if (kDebugMode) {
                            //                       print(
                            //                           "**** chosenCountryId $chosenCountryId");
                            //                     }
                            //                   });
                            //             },
                            //           ),
                            //         ],
                            //       ),

                            15.ph,

                            /// gender
                            Container(
                                padding: EdgeInsets.all(10.0.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                                    color: Theme.of(context).primaryColor,
                                    border: Border.all(
                                        color: Colors.grey[400]!, width: 0)),
                                child: const RadioButton()),

                            15.ph,

                            /// password

                            TextFormFieldWithName(
                              controller: passwordController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              hintTextFormField:
                                  allTranslations.text("enterUserPassword"),
                              fieldName:
                                  allTranslations.text("enterConfirmPassword"),
                              fieldRequired: const Icon(
                                CupertinoIcons.staroflife_fill,
                                color: Colors.red,
                                size: 10,
                              ),
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontFamily: "cairo"),
                              obscureText: _isHidden,
                              suffixIcon: InkWell(
                                onTap: _toggleCurrentPasswordView,
                                child: Icon(
                                  _isHidden
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 20,
                                  color: Colors.grey, // black color
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.grey,
                              ),
                              onFieldSubmitted: () {
                                FocusScope.of(context).nextFocus();
                              },
                              validator: (v) {
                                if (model.errors.containsKey('password')) {
                                  return model.errors['password'][0];
                                }
                                if (v.length == 0) {
                                  return allTranslations.text('enterUserPassword');
                                }
                                if (v.length <= 7) {
                                  return allTranslations
                                      .text("passwordFieldsNumber");
                                }

                                return null;
                              },
                            ),

                            15.ph,

                            /// confirm password
                            TextFormFieldWithName(
                              controller: confirmPasswordController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              hintTextFormField:
                                  allTranslations.text("enterConfirmPassword"),
                              fieldName:
                                  allTranslations.text("confirmCurrentPassword"),
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontFamily: "cairo"),
                              fieldRequired: const Icon(
                                CupertinoIcons.staroflife_fill,
                                color: Colors.red,
                                size: 10,
                              ),
                              obscureText: _isHidden,
                              suffixIcon: InkWell(
                                onTap: _toggleCurrentPasswordView,
                                child: Icon(
                                  _isHidden
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 20,
                                  color: Colors.grey, // black color
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.grey,
                              ),
                              onFieldSubmitted: () {
                                FocusScope.of(context).unfocus();
                              },
                              validator: (v) {
                                if (model.errors.containsKey('c_password')) {
                                  return model.errors['c_password'][0];
                                }
                                if (v.length == 0) {
                                  return allTranslations
                                      .text('enterConfirmPassword');
                                }
                                if (v != passwordController.text) {
                                  return allTranslations.text("passwordNotMatch");
                                }
                                return null;
                              },
                            ),

                            20.ph,

                            /// privacy policy
                            Transform(
                              transform: Matrix4.translation(_shake()),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Row(
                                  children: <Widget>[
                                    Switch(
                                      value: accept,
                                      onChanged: (bool value) {
                                        setState(() {
                                          accept = value;
                                        });
                                      },
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: (){
                                          appModel.token = 'visitor';
                                          pushScreen(context, const PrivacyReturnPolicyScreen(isPrivacyPolicy: true,));
                                          // _launchURL(
                                          //     "https://alalamiastore.com/#/privacyPolicy",
                                          //   "لا يمكن الدخول الى الصفحة"
                                          //
                                          // );
                                        },
                                        child: Container(
                                            width: MediaQuery.of(context).size.width,

                                            padding: EdgeInsets.all(5.w),
                                            child: Center(
                                              child: RichText(
                                                text: TextSpan(
                                                    text: "${allTranslations.text("readTerms")} ",
                                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                        decoration: TextDecoration.underline
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: "${allTranslations.text("termsCondition")} ",
                                                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                            decoration: TextDecoration.underline
                                                          ),
                                                          recognizer:
                                                          TapGestureRecognizer()
                                                            ..onTap =
                                                                () {
//                                                                  Navigator.push(
//                                                                      context, MaterialPageRoute(builder: (context) => PrivacyPolicy()));
//                                                                  // _launchPolicyURL();
                                                            }),
                                                      TextSpan(
                                                        text: "${allTranslations.text("and")} ",
                                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                            decoration: TextDecoration.underline
                                                        ),
                                                      ),
                                                      TextSpan(
                                                          text: "${allTranslations.text("privacyPolicy")} ",
                                                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                              decoration: TextDecoration.underline
                                                          ),
                                                          recognizer:
                                                          TapGestureRecognizer()
                                                            ..onTap =
                                                                () {
//                                                                  Navigator.push(
//                                                                      context, MaterialPageRoute(builder: (context) => PrivacyPolicy()));
//                                                             // _launchPolicyURL();
                                                            })
                                                    ]),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            20.ph,

                            /// create account button
                            StatefulBuilder(
                              builder: (context, mySetState) {
                                return CustomButtons(
                                  height: 45.h,
                                  text: allTranslations.text("createAccount"),
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(fontSize: 16.sp),
                                  textWidget: isLoading == false
                                      ? null
                                      : const CircularLoading(),
                                  buttonColor: isLoading == true
                                      ? Theme.of(context).colorScheme.surface
                                      : Theme.of(context).secondaryHeaderColor,
                                  onTap: countriesModel.selectedCountryId == ""
                                      ? () {
                                          CustomToast.showFlutterToast(
                                              context: context,
                                              message: allTranslations
                                                  .text("chooseCountryHintTxt"));
                                        }
                                      : () async {
                                          if (_formKey.currentState!.validate()) {
                                            final phone = widget.phoneNumber.substring(4);
                                            if (accept == false) {
                                              if (animationController!.isCompleted) {
                                                animationController!.reverse();
                                              } else {
                                                animationController!.forward();
                                              }
                                            }else {
                                              mySetState(() {
                                                isLoading = true;
                                              });
                                              User user = User(
                                                countryId: countriesModel.selectedCountryId,
                                                name: userNameController.text.trim(),
                                                phone: widget.phoneNumber,
                                                email: emailController.text.isEmpty
                                                    ? "${userNameController.text.replaceAll(RegExp(r"\s+"), "")}$phone@gmail.com"
                                                    : emailController.text,
                                                gender: gender,
                                              );

                                              FirebaseMessaging _firebaseMessaging =
                                                  FirebaseMessaging.instance;
                                              _firebaseMessaging
                                                  .getToken()
                                                  .then((fcm) async {
                                                  debugPrint("FCM $fcm");


                                                await model.signUp(
                                                  user,
                                                  passwordController.text,
                                                  fcm.toString(),
                                                );

                                                if (model.isLoaded) {
                                                  /// Subscribe the user to a topic
                                                  FCMService.instance.subscribe();
                                                  CustomDialog.showCustomDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    title: allTranslations.text("createAccountSuccessfully"),
                                                    icon: Lottie.asset(
                                                        AppLottie.checkMark,
                                                        repeat: false),
                                                    withActions: true,
                                                    withYesButton: true,
                                                    onPressed: () async {
                                                      await MaterialAppWithTheme.restartApp(context);
                                                      CustomDialog.hideCustomDialog(context);
                                                    },
                                                  );
                                                } else {
                                                  if (model.errorEmailSignup != null) {
                                                    mySetState(() {
                                                      isLoading = false;
                                                    });

                                                    return CustomToast.showFlutterToast(
                                                      context: context,
                                                      message: model.errorEmailSignup,
                                                    );
                                                  } else if (model.errorMessageSignup != null) {
                                                    mySetState(() {
                                                      isLoading = false;
                                                    });

                                                    return CustomToast.showFlutterToast(
                                                      context: context,
                                                      message:
                                                      model.errorMessageSignup,
                                                    );
                                                  }
                                                }
                                              });
                                            }

                                          } else {
                                            mySetState(() {
                                              isLoading = false;
                                            });
                                            _formKey.currentState!.validate();
                                          }
                                        },
                                );
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
      ),
    );
  }

  void _toggleCurrentPasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  /// Subscribe the user to a topic for notifications
  // final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  // _subscribeToTopic() async {
  //   _fcm.subscribeToTopic('MatjerAlalmia');
  // }
}

class RadioButton extends StatefulWidget {
  const RadioButton({Key? key}) : super(key: key);

  _RadioButtonState createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  int _currentIndex = 1;

  final List<RadioGroup> _radioOptionGroup = [
    RadioGroup(
      text: allTranslations.text('male'),
      index: 1,
    ),
    RadioGroup(
      text: allTranslations.text('female'),
      index: 2,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _radioOptionGroup
          .map((item) => Container(
                width: 150.w,
                alignment: Alignment.center,
                // padding: EdgeInsets.all(5.0.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                    color: item.index == _currentIndex
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.surface),
                child: Row(
                  children: <Widget>[
                    Radio(
                      groupValue: _currentIndex,
                      value: item.index,
                      onChanged: (val) {
                        setState(() {
                          gender = val == 1 ? 'man' : 'woman';
                          _currentIndex = val!;
                        });
                      },
                      activeColor: item.index == _currentIndex
                          ? Theme.of(context).colorScheme.surface
                          : Theme.of(context).secondaryHeaderColor,
                    ),
                    Text(
                      item.text,
                      style: item.index == _currentIndex
                          ? Theme.of(context).textTheme.displayLarge
                          : Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}

class RadioGroup {
  String text;
  int index;
  RadioGroup({required this.text, required this.index});
}
