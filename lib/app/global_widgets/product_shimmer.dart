
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/global_widgets/skeleton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../core/utils/constants.dart';
import '../core/values/app_images.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'custom_rotated_box.dart';


class ProductShimmer extends StatelessWidget {
  final String? rotatedBoxName;


  const ProductShimmer({
    Key? key,
    this.rotatedBoxName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.25),
      highlightColor: Colors.white.withOpacity(0.6),
      child:  SizedBox(
        height: 310.h,
        width: 400.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            rotatedBoxName != null
            ? SizedBox(
                height: 300.h,
                width: 20.w,
                child: CustomRotatedBox(
                  text: rotatedBoxName!,
                )
            )
            : const SizedBox.shrink(),

            Flexible(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context , index){
                  return Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.w , vertical: 5.h),
                    child: Container(
                      height: 300.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25 , bottom: 5 , left : 10 , right: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                              child: SizedBox(
                                height: 155.h,
                                width: 150.w,
                                child: const CustomCachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: "",
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 150.w,
                            height: 80.h,
                            padding: const EdgeInsets.only(left: 5 , right: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Skeleton(),

                                const Spacer(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children:   [
                                    Skeleton(
                                      width: 40.w,
                                    ),
                                    10.pw,
                                    Skeleton(
                                      width: 40.w,
                                    ),
                                  ],
                                ),
                                5.ph,

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children:  [
                                    Skeleton(
                                      width: 40.w,
                                    ),
                                    10.pw,
                                    Skeleton(
                                      width: 40.w,
                                    ),
                                  ],
                                ),
                                5.ph,

                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5 , right: 5 , top: 10 , bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Skeleton(
                                  height: 20.h,
                                  width: 80.w,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 7),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.star ,
                                        size: 12,
                                      ),
                                      3.pw,
                                      const Skeleton(),
                                      2.pw,


                                      const Skeleton(),

                                    ],
                                  ),
                                )

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],

        ),
      ),
    );
  }
}
