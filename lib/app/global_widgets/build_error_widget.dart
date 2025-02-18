import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/values/app_lottie.dart';
import '../data/providers/translations.dart';
import 'custom_message.dart';
class BuildErrorWidget extends StatelessWidget {
  final FlutterErrorDetails? error;
  const BuildErrorWidget({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(10.0.w),
      child: Center(
        child: CustomMessage(
            message: allTranslations.text("errorOccurred"),
            appLottieIcon: AppLottie.error
        ),
      ),
    );
  }
}
