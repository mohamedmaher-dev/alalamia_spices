
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_two_text.dart';
import 'package:alalamia_spices/app/exports/widget.dart';

class BottomSheetHeader extends StatelessWidget {
  final String title;
  final String? subTitle;
  const BottomSheetHeader({
    super.key,
    required this.title,
    this.subTitle
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.only(top: 10.0.w),
          child: CustomTowText(
            title: title,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            titleStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 22.sp

            ),
            subWidget: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5.0.w),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.close,
                  size: 30,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ),
            ),
          ),
        ),
        3.ph,
        if(subTitle != null)
        Text(
          subTitle!,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.bold
          ),
        ),
        20.ph,
      ],
    );
  }
}
