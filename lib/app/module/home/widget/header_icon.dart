

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HeaderIcon extends StatelessWidget {

  final IconData icon;
  final GestureTapCallback onTap;
  const HeaderIcon({
    Key? key,
    required this.icon,
    required this.onTap

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 50.w,
        height: 40.h,
        padding :  EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white70),
          shape: BoxShape.circle
          // boxShadow: const [
          //   BoxShadow(
          //       color: Color(0xffe8e8e8),
          //       blurRadius: 5,
          //       offset: Offset(0, 5)
          //   ),
          //   BoxShadow(
          //       color: Color(0xffe8e8e8),
          //       offset: Offset(-5, 0)
          //   ),
          //   BoxShadow(
          //       color: Color(0xffe8e8e8),
          //       offset: Offset(5, 0)
          //   ),
          // ]
        ),
        child:  Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
