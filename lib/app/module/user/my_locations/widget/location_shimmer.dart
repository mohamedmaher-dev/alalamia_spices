

import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/global_widgets/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/constants.dart';


class LocationShimmer extends StatelessWidget {
  const LocationShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.w , vertical: 10.h),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 80.h,
            padding: const  EdgeInsets.all( 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Skeleton(
                  width: 80.w,
                ),

                10.ph,
                Skeleton(
                  width: 80.w,
                ),

              ],
            ),
          ),
        ),

        Positioned(
          top: 10,
          left: 3,
          child: Card(
            elevation: 0.5,
            child: Container(
              height: 30.h,
              width: 30.w,
              padding:  EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                color: Theme.of(context).primaryColor,
              ),
              child: Container(
                height: 10.h,
                width: 10.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                  size: 15,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 60,
          left: 3,
          child: Card(
            elevation: 0.5,
            child: Container(
              height: 30.h,
              width: 30.w,
              padding:  EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                color: Theme.of(context).primaryColor,
              ),
              child: Container(
                height: 10.h,
                width: 10.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Icon(
                  Icons.delete,
                  color: Theme.of(context).primaryColor,
                  size: 15,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
