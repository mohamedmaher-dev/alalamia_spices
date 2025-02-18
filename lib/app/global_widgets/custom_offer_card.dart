
import 'package:alalamia_spices/app/global_widgets/custom_cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utils/constants.dart';

class CustomOfferCard extends StatelessWidget {
  final GestureTapCallback onTap;
  final String image;
  final String name;
  const CustomOfferCard({super.key,
    required this.onTap,
    required this.image,
    required this.name
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Column(
          children: [
            SizedBox(
              height: 200.w,
              width: 200.w,
              child: ClipRRect(
                borderRadius:  BorderRadius.only(
                    topRight: Radius.circular(AppConstants.defaultBorderRadius.w),
                    topLeft: Radius.circular(AppConstants.defaultBorderRadius.w)
                ),
                child: CustomCachedNetworkImage(
                  height: 200.h,
                  width: 200.w,
                  fit: BoxFit.contain,
                  imageUrl: image,
                )
              ),
            ),

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 1.5.w),
              child: Container(
                height: 40.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                    borderRadius:  BorderRadius.only(
                        bottomRight: Radius.circular(AppConstants.defaultBorderRadius.w),
                        bottomLeft: Radius.circular(AppConstants.defaultBorderRadius.w)
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).focusColor.withOpacity(0.05),
                          offset: const Offset(0, 5),
                          blurRadius: 5)
                    ]),

                child: Center(
                  child: Text(
                      name,
                      style: Theme.of(context).textTheme.displayLarge
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}
