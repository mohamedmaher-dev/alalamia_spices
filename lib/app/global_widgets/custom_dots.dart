
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomDots extends StatelessWidget {
  final double dotHeight;
  final double dotWidth;
  final BorderRadiusGeometry? borderRadius;
  final Color dotColor;
  const CustomDots({
    super.key,
    required this.dotHeight,
    required this.dotWidth,
    this.borderRadius,
    required this.dotColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dotHeight,
      width: dotWidth,
      margin:  EdgeInsets.only(right: 5.w),
      decoration: BoxDecoration(
        borderRadius: borderRadius ??  BorderRadius.circular(20),
        color: dotColor,
      ),
    );
  }
}
