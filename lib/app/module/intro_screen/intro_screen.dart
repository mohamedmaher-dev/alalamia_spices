import 'dart:async';
import 'dart:io';
import 'package:alalamia_spices/app/module/app_config/app_config_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alalamia_spices/app/exports/provider.dart';

class IntroScreen extends StatefulWidget {
  final Widget? stateful;
  const IntroScreen({super.key, this.stateful});
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
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
        ? const Duration(milliseconds: 8200)
        : const Duration(milliseconds: 8200);
    return Timer(
        duration, appModel.token == null ? navigationPage : navigationPage2);
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
