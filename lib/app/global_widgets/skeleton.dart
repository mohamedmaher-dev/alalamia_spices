import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utils/constants.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({
    Key? key,
    this.height,
    this.width
  }) : super(key: key);

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding:  EdgeInsets.all(8.0.w),
      decoration: BoxDecoration(
          color: Theme.of(context).selectedRowColor,
          borderRadius:  BorderRadius.all(Radius.circular(AppConstants.defaultBorderRadius.w))),
    );
  }
}

extension on ThemeData {
  get selectedRowColor => null;
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({
    Key? key,
    this.size = 24
  }) : super(key: key);

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.04),
        shape: BoxShape.circle,
      ),
    );
  }
}