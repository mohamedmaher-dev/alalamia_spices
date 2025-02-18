
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utils/constants.dart';
import 'custom_cached_network_image.dart';

class CustomCategoryCard extends StatelessWidget {
  final GestureTapCallback onTap;
  final String image;
  final String name;
  final bool? categoryTap;
  final Color? containerNameColor;
  final TextStyle? textStyle;
  const CustomCategoryCard({super.key,
    required this.onTap,
    required this.image,
    required this.name,
    this.containerNameColor,
    this.textStyle,
    this.categoryTap = false
  });

  @override
  Widget build(BuildContext context) {
    return categoryTap == false
      ? InkWell(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 5.w , vertical: 3.h),
        child: Container(
          height: 40.h,
          width: 167.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              /// name
              Container(
                decoration: BoxDecoration(
                    color: containerNameColor ??  Theme.of(context).primaryColor,
                    borderRadius:  BorderRadius.only(
                      topRight: Radius.circular(AppConstants.defaultBorderRadius.w),
                      topLeft: Radius.circular(AppConstants.defaultBorderRadius.w),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).focusColor.withOpacity(0.05),
                          offset: const Offset(0, 5),
                          blurRadius: 5
                      )
                    ]),
                height: 40.h,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: textStyle ?? Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontFamily: 'cairo',
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),

              /// image
              ClipRRect(
                borderRadius:  BorderRadius.only(
                  bottomRight: Radius.circular(AppConstants.defaultBorderRadius.w),
                  bottomLeft: Radius.circular(AppConstants.defaultBorderRadius.w),
                ),
                child: CustomCachedNetworkImage(
                  imageUrl:  image,
                  fit: BoxFit.cover,
                  height: 220.h,
                  width: 167.w,
                  errorImageHeight: 180.h,
                  errorImageWidth: 130.w,

                ),
              ),






            ],
          ),
        ),
      ),
    )
      : InkWell(
        onTap: onTap,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 5.w , vertical: 3.h),
          child: Column(
            children: [
              /// name
              Container(
                height: 40.h,
                width: 167.w,
                decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                    borderRadius:  BorderRadius.only(
                      topRight: Radius.circular(AppConstants.defaultBorderRadius.w),
                      topLeft: Radius.circular(AppConstants.defaultBorderRadius.w),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).focusColor.withOpacity(0.05),
                          offset: const Offset(0, 5),
                          blurRadius: 5
                      )
                    ]),
                child: Center(
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ),

              SizedBox(
                height: 220.h,
                width: 167.w,
                child: ClipRRect(
                  borderRadius:  BorderRadius.only(
                    bottomLeft: Radius.circular(AppConstants.defaultBorderRadius.w),
                    bottomRight: Radius.circular(AppConstants.defaultBorderRadius.w),
                  ),
                  child: CustomCachedNetworkImage(
                    fit: BoxFit.fill,
                    height: 220.h,
                    width: 152.w,
                    imageUrl: image,
                  ),
                ),
              ),

            ],
          ),
        ));
  }
}
