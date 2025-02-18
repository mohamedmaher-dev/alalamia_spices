
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/constants.dart';
import '../../../core/values/app_images.dart';
import '../../../global_widgets/skeleton.dart';
class OfferShimmer extends StatelessWidget {
  const OfferShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.25),
      highlightColor: Colors.white.withOpacity(0.6),
      child: GridView.builder(
        shrinkWrap: true,
        primary: false,
        scrollDirection: Axis.vertical,
        gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300.w,
          mainAxisExtent: 260.h, // when it is in vertical this control the space vertically
        ),
        itemCount: 5,
        itemBuilder: (context , index){
          return Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.w , vertical: 3.h),
            child: Column(
              children: [
                SizedBox(
                  height: 200.h,
                  width: 200.w,
                  child: ClipRRect(
                    borderRadius:  BorderRadius.only(
                        topRight: Radius.circular(AppConstants.defaultBorderRadius.w),
                        topLeft: Radius.circular(AppConstants.defaultBorderRadius.w)
                    ),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: "",
                      placeholder: (context, url) => SizedBox(
                        width: 70,
                        height: 70,
                        child: Padding(
                            padding: EdgeInsets.all(10.0.w),
                            child: Image.asset(
                              AppImages.logo,
                            )),
                      ),
                      errorWidget: (context, url, error) => SizedBox(
                        width: 70,
                        height: 70,
                        child: Padding(
                            padding: EdgeInsets.all(10.0.w),
                            child: Image.asset(
                              AppImages.logo,
                            )),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 42.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius:  BorderRadius.only(
                          bottomRight: Radius.circular(AppConstants.defaultBorderRadius.w),
                          bottomLeft: Radius.circular(AppConstants.defaultBorderRadius.w)
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).focusColor.withOpacity(0.05),
                            offset: const Offset(0, 5),
                            blurRadius: 5)
                      ]),

                  child: const Center(
                    child:  Skeleton()
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}