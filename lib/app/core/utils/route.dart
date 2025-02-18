import 'package:alalamia_spices/app/module/app_config/app_config_screen.dart';
import 'package:alalamia_spices/app/module/auth/auth_tabs_screen.dart';
import 'package:alalamia_spices/app/module/auth/forgot_password/forgot_password_screen.dart';
import 'package:alalamia_spices/app/module/auth/phone/phone_screen.dart';
import 'package:alalamia_spices/app/module/auth/sign_up/sign_up_tab.dart';
import 'package:alalamia_spices/app/module/cart/cart_tab.dart';
import 'package:alalamia_spices/app/module/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import '../../data/model/new_arrival.dart';
import '../../module/onboarding/onboarding_screen.dart';
import '../../module/product_details/product_details_screen.dart';
import '../../module/start/start.dart';


class Routes {
  Routes._();
  static const String startScreen = '/startScreen';
  static const String productDetailsScreen = '/productDetailsScreen';
  static const String appConfigScreen = '/appConfigScreen';
  static const String splashScreen = '/splashScreen';
  static const String authTapsScreen = '/authTapScreen';
  static const String forgetPasswordScreen = '/forgetPasswordScreen';
  static const String verificationCodeScreen = '/verificationCodeScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String phoneScreen = '/phoneScreen';
  static const String cartScreen = '/cartScreen';
  static const String onboardingScreen = '/onboardingScreen';


  static final routes = <String, WidgetBuilder>{
    startScreen: (BuildContext context) => const StartScreen(),
    appConfigScreen : (BuildContext context) => const AppConfigScreen(),
    splashScreen : (BuildContext context) => const SplashScreen(),
    authTapsScreen : (BuildContext context) => const AuthTabsScreen(),
    onboardingScreen : (BuildContext context) => const OnBoardingScreen(),



    /// phone screen
    phoneScreen: (BuildContext context) =>
        PhoneScreen(
            isFromForgotPasswordScreen: ModalRoute.of(context)!.settings.arguments as bool),

    /// verification code screen
    // verificationCodeScreen: (BuildContext context) =>
    //     VerificationCodeScreen(
    //       phoneNumber: ModalRoute.of(context)!.settings.arguments as String,
    //       isSignIn: true,
    //       isResetPassword: true,
    //     ),


    /// forget password screen
    forgetPasswordScreen: (BuildContext context) =>
        ForgotPasswordScreen(
            phoneNumber: ModalRoute.of(context)!.settings.arguments as String),


    /// sign up screen
    signUpScreen: (BuildContext context) =>
        SignUpTab(
            phoneNumber: ModalRoute.of(context)!.settings.arguments as String),

    /// product details screen
    productDetailsScreen: (BuildContext context) =>
        ProductDetailsScreen(
            product: ModalRoute.of(context)!.settings.arguments as Product),

    /// cart screen
    cartScreen : (BuildContext context) =>
        CartTab(
            isFromProductDetails: ModalRoute.of(context)!.settings.arguments as bool),


  };
}