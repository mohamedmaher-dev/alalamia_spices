

import 'package:alalamia_spices/app/core/utils/constants.dart';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ContinuePurchasingButton extends StatelessWidget {

  final GestureTapCallback? onTapPurchasing;
  final GestureTapCallback? onTapShopping;
  final Widget? childShopping;
  final Widget? childPurchasing;
  final bool ceilingPrice;
  const ContinuePurchasingButton({
    Key? key,
    this.onTapShopping,
    this.onTapPurchasing,
    this.childPurchasing,
    this.childShopping,
    this.ceilingPrice = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 5.0.h , vertical: 5.h),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: InkWell(
              onTap: onTapPurchasing,
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                  borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w)
                ),


                child: childPurchasing
              ),
            ),
          ),


          // const CustomVerticalDivider(),

          10.pw,

          childShopping != null
          ? InkWell(
            onTap: ceilingPrice == true ? null : onTapShopping,
            child: Container(
              height: 50.h,
              width: 120.w,
              decoration: BoxDecoration(
                  color: ceilingPrice == true
                      ? Colors.grey
                      : Theme.of(context).secondaryHeaderColor,
                  borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w)
              ),
              child: childShopping,
            ),
          )
          : 0.ph,
        ],
      ),
    );
  }
}
