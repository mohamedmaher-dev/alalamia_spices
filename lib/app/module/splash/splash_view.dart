import 'package:alalamia_spices/app/data/providers/appModel.dart';
import 'package:alalamia_spices/app/module/app_config/app_config_screen.dart';
import 'package:alalamia_spices/app/module/app_config/provider/app_config_provider.dart';
import 'package:alalamia_spices/app/module/intro_screen/intro_screen.dart';
import 'package:alalamia_spices/app/module/start/start.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    var appConfigProvider =
        Provider.of<AppConfigProvider>(context, listen: false);
    late Widget nextScreen;
    if (appModel.token == '' && appConfigProvider.splashFirstSeen == false) {
      nextScreen = const IntroScreen();
    } else if (appModel.token == '' &&
        appConfigProvider.splashFirstSeen == true) {
      nextScreen = const AppConfigScreen();
    } else {
      nextScreen = const StartScreen();
    }

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => nextScreen));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          height: double.infinity,
          child: Image.asset(
            "assets/images/splash.gif",
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
