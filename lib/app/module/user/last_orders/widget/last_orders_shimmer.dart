import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/global_widgets/skeleton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/values/app_images.dart';



class LastOrdersShimmer extends StatelessWidget {
  const LastOrdersShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.25),
      highlightColor: Colors.white.withOpacity(0.6),
      child:  Padding(
        padding:   EdgeInsets.all(5.w),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Flexible(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context , index){
                  return  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.0.w  , vertical: 10.h),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 120.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                              child: CachedNetworkImage(
                                imageUrl: "",
                                fit: BoxFit.fill,
                                height: 80.h,
                                width: 80.w,
                                placeholder: (context, url) =>
                                    Image.asset(AppImages.logo),
                                errorWidget: (context, url, error) =>
                                    Image.asset(AppImages.logo),
                              ),
                            ),

                            10.pw,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Skeleton(
                                  width: 80.w,
                                ),
                                5.ph,
                                Skeleton(
                                  width: 80.w,
                                ),
                                5.ph,
                                Skeleton(
                                  width: 80.w,
                                ),
                                5.ph,
                                Skeleton(
                                  width: 80.w,
                                ),
                              ],
                            ),
                            Container(
                              height: 30.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                              ),
                              child: Center(
                                child: Skeleton(
                                  width: 40.w,
                                ),
                              ),
                            ),
                          ],
                        ),
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
