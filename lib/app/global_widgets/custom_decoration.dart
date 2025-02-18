

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utils/constants.dart';


class CustomDecoration extends StatelessWidget {

  // final double borderRadius;
  // final Color color;
  //

  const CustomDecoration({
    Key? key,
    // required this.borderRadius,
    // required this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
       borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w)
      ),
    );
  }
}
