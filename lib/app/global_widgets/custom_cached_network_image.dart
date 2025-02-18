
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/values/app_images.dart';


class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final double? errorImageHeight;
  final double? errorImageWidth;
  final BoxFit? fit;
  const CustomCachedNetworkImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.errorImageHeight,
    this.errorImageWidth
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: fit,
      imageUrl: imageUrl,
      width: width,
      height: height,
      placeholder: (context, url) => SizedBox(
        height: errorImageHeight ??  70.h,
        width: errorImageWidth ?? 70.w,
        child: Padding(
            padding: EdgeInsets.all(10.0.w),
            child: Image.asset(
              AppImages.logo,
            )),
      ),
      errorWidget: (context, url, error) => SizedBox(
        height: errorImageHeight ??  70.h,
        width: errorImageWidth ?? 70.w,
        child: Padding(
            padding: EdgeInsets.all(10.0.w),
            child: Image.asset(
              AppImages.logo,

            )),
      ),
    );
  }
}
