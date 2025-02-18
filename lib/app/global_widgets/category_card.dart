

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class CategoryCard extends StatelessWidget {
  final String categoryName;
  final String? categoryId;


  const CategoryCard({
    Key? key,
    required this.categoryName,
    this.categoryId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0.w,vertical: 10.h),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(3, 3, 2, 2),
            child: Container(
              height: 40.h,
              padding: EdgeInsets.all(5.0.w),
              decoration: boxDecoration(
                radius: 8,
                showShadow: true,
                bgColor: Theme.of(context).colorScheme.background,
              ),
              child: Center(
                child: Text(
                  categoryName,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight : FontWeight.bold
                ),
                ),
              ),
            ),
          ),
          Container(
            width: 4,
            height: 20,
            margin: const EdgeInsets.only(top: 10),
            color: Theme.of(context).colorScheme.secondary ,
          )
        ],
      ),
    );
  }
  BoxDecoration boxDecoration(
      {double radius = 2,
        Color color = Colors.transparent,
        Color bgColor = Colors.white,
        var showShadow = false}) {
    return BoxDecoration(
        color: bgColor,
        //gradient: LinearGradient(colors: [bgColor, whiteColor]),
        boxShadow: showShadow
            ? [BoxShadow(color: Colors.grey[200]!, blurRadius:4, spreadRadius: 1)]
            : [BoxShadow(color: Colors.transparent)],
        border: Border.all(color: color),
        borderRadius: BorderRadius.all(Radius.circular(radius)));
  }

}
