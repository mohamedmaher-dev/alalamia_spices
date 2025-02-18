

import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/constants.dart';
import 'package:alalamia_spices/app/exports/model.dart';


class NotificationCard extends StatelessWidget {
  final Alert alert ;
  const NotificationCard({
    Key? key,
    required this.alert
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(8.w),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 70.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
          color: Theme.of(context).primaryColor,
        ),
        child: ListTile(
          title: SizedBox(
            width: 150.w,
            child: Text(
              alert.title.toString(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal :10.w , vertical: 5.h),
          subtitle: SizedBox(
            width: 150.w,
            child: Text(
              alert.content.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          leading: ClipRRect(
              borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
              child: CustomCachedNetworkImage(
                imageUrl: alert.imagePath.toString(),
                fit: BoxFit.contain,
                height: 60.h,
                width: 60.w,
              )
          ),
          trailing: Container(
            height: 30.h,
            width: 80.w,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
            ),
            child: Center(
              child: Text(
                allTranslations.text("detail"),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
}
