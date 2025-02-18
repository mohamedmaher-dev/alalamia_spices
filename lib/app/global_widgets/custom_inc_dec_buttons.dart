

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/utils/constants.dart';
class CustomIncDecButtons extends StatelessWidget {
  final GestureTapCallback? onIncTap;
  final GestureTapCallback? onDecTap;
  final GestureTapCallback? onDeleteTap;
  final IconData? arrowIncIcon;
  final IconData? arrowDecIcon;
  final Color? arrowsIconColor;
  final String? quantity;
  final double? borderRadius;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? backgroundIconColor;
  final double? iconSize;

  const CustomIncDecButtons({
    Key? key,
    this.onDecTap,
    this.onDeleteTap,
    this.onIncTap,
    this.arrowIncIcon,
    this.arrowDecIcon,
    this.arrowsIconColor,
    this.quantity,
    this.borderRadius,
    this.borderColor,
    this.backgroundColor,
    this.backgroundIconColor,
    this.iconSize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.0),
      width: 100.w,
      height: 30.h,
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: onIncTap,
            child: Container(
              width: 25.w,
              height : 25.h,
              decoration:   BoxDecoration(
                  shape: BoxShape.circle,
                  color: backgroundIconColor ?? Theme.of(context).colorScheme.background
              ),
              child:  Icon(
                arrowIncIcon,
                color: arrowsIconColor ?? Theme.of(context).secondaryHeaderColor,
                size: iconSize ?? 25.0,
              ),
            ),
          ),
          Text(
            quantity.toString(),
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
                fontFamily: "cairo",
              fontSize: 10.sp
            ),
          ),
          InkWell(
            onTap: onDecTap,
            child: Container(
              width: 25.w,
              height : 25.h,
              decoration:   BoxDecoration(
                  shape: BoxShape.circle,
                  color: backgroundIconColor ?? Theme.of(context).colorScheme.background
              ),
              child:  Icon(
                arrowDecIcon,
                color: arrowsIconColor ?? Theme.of(context).secondaryHeaderColor,
                size: iconSize ?? 25.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
