
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../core/values/app_lottie.dart';


class CustomMessage extends StatelessWidget {
  final String? appLottieIcon;
  final String message;
  final TextStyle? messageStyle;
  final bool? repeat;
  final Widget?  customWidget;
  final Color?  containerColor;
  const CustomMessage({
    Key? key,
    required this.message,
    this.appLottieIcon,
    this.repeat,
    this.messageStyle,
    this.customWidget,
    this.containerColor
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      height: 300.h,
      color: containerColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customWidget == null
            ? Lottie.asset(
              appLottieIcon!,
              width: 200.w,
              height: 200.h,
              repeat: repeat ?? false
          )
            : customWidget!,



          20.ph,
          Text(
            message,
            textAlign: TextAlign.center,
            style: messageStyle ??  Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    );
  }
}

