
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/utils/constants.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'custom_cached_network_image.dart';

class CountryBody extends StatelessWidget {
  final Countries countries;
  final bool selectedCountry;
  const CountryBody({super.key, required this.countries, required this.selectedCountry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(10.0.w),
      child: Container(
        width: 140.w,
        height: 140.h,
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
            border: selectedCountry
                ? Border.all(color: Theme.of(context).colorScheme.secondary , width: 2.w)
                : Border.all(color: Colors.grey[400]!)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomCachedNetworkImage(
              imageUrl: countries.imagePath.toString(),
              width: 70.w,
              height: 70.h,
              errorImageHeight: 30.h,
              errorImageWidth: 30.w,
            ),

            10.ph,
            Text(
              countries.name.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
    );
  }
}
