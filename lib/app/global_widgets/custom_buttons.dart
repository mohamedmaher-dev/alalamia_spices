

import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/utils/constants.dart';
import 'circular_loading.dart';


class CustomButtons extends StatelessWidget {
  final double? width;
  final double? height;
  final Color buttonColor;
  final TextStyle? textStyle;
  final String text;
  final Widget? textWidget;
  final GestureTapCallback? onTap;
  final bool isLoading;
  final Widget? customWidget;
  // final GestureTapCallback? onTapCustomWidget;
  const CustomButtons({
    Key? key,
    required this.text,
    required this.buttonColor,
    this.textStyle,
    this.width,
    this.height,
    this.onTap,
    this.textWidget,
    this.isLoading = false,
    this.customWidget,
    // this.onTapCustomWidget
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: isLoading == true
          ? Container(
        width: width,
        height: height ?? 40.h ,
        alignment: Alignment.center,
        padding:  EdgeInsets.all(5.w),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w)
        ),

        child: const Center(
            child:  CircularLoading()
        ),
      )

          : Container(
        width: width,
        height: height ?? 40.h ,
        alignment: Alignment.center,
        padding:  EdgeInsets.all(5.w),
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w)
        ),

        child: Row(
          mainAxisAlignment: customWidget != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
          children: [
            Center(
              child: textWidget ?? Text(
                text,
                style: textStyle ?? Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp
                ),
              ),
            ),

            customWidget != null
                ? customWidget!
                : 0.ph

          ],
        ),
      ),
    );
  }
}
