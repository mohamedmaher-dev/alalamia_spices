
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../core/values/app_images.dart';


class CarouseSliderShimmer extends StatelessWidget {
  const CarouseSliderShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.25),
      highlightColor: Colors.white.withOpacity(0.6),
      child:  CarouselSlider.builder(
        itemCount: 2,
        options: CarouselOptions(
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          viewportFraction: 1.0,
          height: 250.h,
        ),
        itemBuilder: (context, index, realIdx) {

          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CachedNetworkImage(
              width: double.infinity,
              fit: BoxFit.fill,
              imageUrl: "",
              placeholder: (context, url) => SizedBox(
                width: 100,
                height: 100,
                child: Padding(
                    padding: EdgeInsets.all(10.0.w),
                    child: Image.asset(
                      AppImages.logo,
                      width: 100,
                      height: 100,
                    )),
              ),
              errorWidget: (context, url, error) => SizedBox(
                width: 100,
                height: 100,
                child: Padding(
                    padding: EdgeInsets.all(10.0.w),
                    child: Image.asset(
                      AppImages.logo,
                      width: 100,
                      height: 100,
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}
