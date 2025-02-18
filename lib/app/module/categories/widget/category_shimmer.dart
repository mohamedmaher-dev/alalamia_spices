
import 'package:alalamia_spices/app/global_widgets/skeleton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/utils/constants.dart';
import '../../../core/values/app_images.dart';


class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({Key? key}) : super(key: key);

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
          // childAspectRatio: 3 / 6,
          // crossAxisSpacing: 3, // the space between them horizontally
          // mainAxisSpacing: 3
        ),
        itemCount: 10,
        itemBuilder: (context , index){
          return Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.w , vertical: 3.h),
            child: Column(
              children: [
                Container(
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
                  height: 40.h,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: Skeleton()
                  ),
                ),

                SizedBox(
                  height: 200.h,
                  width: 220.w,
                  child: ClipRRect(
                    borderRadius:  BorderRadius.only(
                      bottomLeft: Radius.circular(AppConstants.defaultBorderRadius.w),
                      bottomRight: Radius.circular(AppConstants.defaultBorderRadius.w),
                    ),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: "",
                      placeholder: (context, url) => Container(
                        width: 70,
                        height: 70,
                        child: Padding(
                            padding: EdgeInsets.all(10.0.w),
                            child: Image.asset(
                              AppImages.logo,
                            )),
                      ),
                      errorWidget: (context, url, error) => Container(
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

              ],
            ),
          );
        },
      )
    );
  }
}
