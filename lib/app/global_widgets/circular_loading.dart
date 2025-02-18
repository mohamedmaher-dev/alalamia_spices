import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../core/values/app_lottie.dart';


class CircularLoading extends StatelessWidget {
  const CircularLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
          AppLottie.loading,
          width: 40.w,
          height: 40.h
      ),
    );
  }
}
