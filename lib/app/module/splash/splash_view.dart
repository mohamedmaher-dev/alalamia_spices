// ignore_for_file: use_build_context_synchronously

import 'package:alalamia_spices/app/data/providers/appModel.dart';
import 'package:alalamia_spices/app/module/app_config/app_config_screen.dart';
import 'package:alalamia_spices/app/module/app_config/provider/app_config_provider.dart';
import 'package:alalamia_spices/app/module/intro_screen/intro_screen.dart';
import 'package:alalamia_spices/app/module/splash/models/check_maintenance.dart';
import 'package:alalamia_spices/app/module/splash/models/check_update.dart';
import 'package:alalamia_spices/app/module/start/start.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    Widget nextScreen = _getNextScreen();
    await Future.delayed(const Duration(seconds: 4));
    await _checkMaintenance(nextScreen);
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => nextScreen),
    // );
  }

  Future<void> _checkMaintenance(Widget nextScreen) async {
    try {
      final maintenanceResponse = await _dio.get(
        "https://api.alalamiastore.com/api/v1/user/check-maintenance",
      );

      final maintenanceData =
          CheckMaintenance.fromJson(maintenanceResponse.data);

      if (maintenanceData.maintenanceMode == 0) {
        await _checkForUpdates(nextScreen);
      } else {
        _showDialog(
          title: 'التطبيق قيد الصيانة',
          content: 'التطبيق قيد الصيانة ، يرجى المحاولة لاحقاً',
        );
      }
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.other) {
        _showDialog(
          title: 'الاتصال بالانترنت',
          content: 'يرجى التحقق من الاتصال بالانترنت و المحاولة لاحقاً',
        );
      } else {
        _showDialog(
          title: 'خطاء',
          content: 'حدث خطاء اثناء التحقق من الصيانة',
        );
      }
    }
  }

  Future<void> _checkForUpdates(Widget nextScreen) async {
    try {
      final updateResponse = await _dio.get(
        'https://api.alalamiastore.com/api/v1/user/check-update',
      );

      final updateData = CheckUpdate.fromMap(updateResponse.data);

      if (updateData.forceUpdate == 0) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => nextScreen),
          );
        }
      } else {
        _showDialog(
          title: 'تحديث جديد',
          content: 'يرجى التحديث للحصول على المزيد من الميزات.',
          actions: [
            if (updateData.url != null)
              TextButton(
                  onPressed: () {
                    launchUrl(
                        mode: LaunchMode.externalApplication,
                        Uri.parse(updateData.url!));
                  },
                  child: Text('تحديث'))
          ],
        );
      }
    } catch (e) {
      _showDialog(title: 'خطأ', content: 'حدث خطأ أثناء التحقق من التحديثات.');
    }
  }

  Widget _getNextScreen() {
    var appConfigProvider =
        Provider.of<AppConfigProvider>(context, listen: false);

    if (appModel.token.isEmpty && !appConfigProvider.splashFirstSeen) {
      return const IntroScreen();
    } else if (appModel.token.isEmpty) {
      return const AppConfigScreen();
    } else {
      return const StartScreen();
    }
  }

  void _showDialog(
      {required String title, required String content, List<Widget>? actions}) {
    if (!mounted) return;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: 'cairo',
                color: Colors.black,
              ),
        ),
        content: Text(
          content,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontFamily: 'cairo',
                color: Colors.black,
              ),
        ),
        actions: actions,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Image(
            image: AssetImage("assets/images/splash.gif"),
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
