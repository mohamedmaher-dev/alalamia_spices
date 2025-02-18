

import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/constants.dart';

class FilterShimmer extends StatelessWidget {
  const FilterShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.25),
      highlightColor: Colors.white.withOpacity(0.6),
      child:  Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 40.h,
            width: 110.w,
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                color: Theme.of(context).colorScheme.surface
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "",
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                  Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 20,
                    color: Theme.of(context).secondaryHeaderColor,
                  )
                ],
              ),
            ),
          ),
          10.pw,
          Container(
            height: 40.h,
            width: 110.w,
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                color: Theme.of(context).colorScheme.surface
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "",
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                  Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 20,
                    color: Theme.of(context).secondaryHeaderColor,
                  )
                ],
              ),
            ),
          ),
          10.pw,
          Container(
            height: 40.h,
            width: 110.w,
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                color: Theme.of(context).colorScheme.surface
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "",
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                  Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 20,
                    color: Theme.of(context).secondaryHeaderColor,
                  )
                ],
              ),
            ),
          ),
          10.pw,
          Container(
            height: 40.h,
            width: 110.w,
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                color: Theme.of(context).colorScheme.surface
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "",
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                  Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 20,
                    color: Theme.of(context).secondaryHeaderColor,
                  )
                ],
              ),
            ),
          ),
          10.pw,
          Container(
            height: 40.h,
            width: 110.w,
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                color: Theme.of(context).colorScheme.surface
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "",
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                  Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 20,
                    color: Theme.of(context).secondaryHeaderColor,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
