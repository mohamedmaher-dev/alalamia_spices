

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomVerticalDivider extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  const CustomVerticalDivider({
    Key? key,
    this.height,
    this.width,
    this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 40.h,
      width: width ??  2.w,
      color: color ?? Theme.of(context).colorScheme.secondary,
    );
  }
}
