import 'dart:async';
import 'dart:io';
import 'package:alalamia_spices/app/core/values/app_images.dart';
import 'package:alalamia_spices/app/module/app_config/app_config_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alalamia_spices/app/exports/provider.dart';


class SplashScreen extends StatefulWidget {
  final Widget? stateful;
  const SplashScreen({Key? key, this.stateful}) : super(key: key);
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
    var duration = Platform.isIOS?const Duration(milliseconds: 8200):const Duration(milliseconds: 8200);
    return Timer(duration, appModel.token == null ?navigationPage:navigationPage2);

  }

  void navigationPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const AppConfigScreen()));

  }
  void navigationPage2() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) =>  const AppConfigScreen()));
  }

  @override
  Widget build(BuildContext context) {
    var countriesModel = Provider.of<CountriesModel>(context);
    countriesModel.getCountriesList();
    return  SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body:  SizedBox(
            height: double.infinity,
            child: Image.asset(
              AppImages.intro,
              fit: BoxFit.fitHeight,
            ),
          )

      ),
    );
  }
}
