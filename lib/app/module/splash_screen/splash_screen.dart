import 'dart:async';
import 'dart:io';
import 'package:alalamia_spices/app/module/app_config/app_config_screen.dart';
import 'package:alalamia_spices/app/module/start/start.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alalamia_spices/app/exports/provider.dart';

class SplashScreen extends StatefulWidget {
  final Widget? stateful;
  const SplashScreen({super.key, this.stateful});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
    // Future.delayed(const Duration(milliseconds: 8200) , (){
    //   // Provider.of<AppConfigProvider>(context , listen: false).splashFirstSeen = true;
    //
    // } );
  }

  startTime() async {
    var duration = Platform.isIOS
        ? const Duration(seconds: 8)
        : const Duration(seconds: 8);
    return Timer(
        duration, appModel.token == "" ? navigationPage : navigationPage2);
  }

  void navigationPage() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const AppConfigScreen()));
  }

  void navigationPage2() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const AppConfigScreen()));
  }

  @override
  Widget build(BuildContext context) {
    var countriesModel = Provider.of<CountriesModel>(context);
    countriesModel.getCountriesList();
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: SizedBox(
            height: double.infinity,
            child: Image.asset(
              "assets/images/intro.gif",
              fit: BoxFit.fitHeight,
            ),
          )),
    );
  }
}
