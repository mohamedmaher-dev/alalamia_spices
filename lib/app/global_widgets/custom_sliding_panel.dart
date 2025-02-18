
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/utils/constants.dart';
import '../core/values/app_icons.dart';
import 'package:alalamia_spices/app/exports/provider.dart';

class CustomSlidingPanel extends StatelessWidget {
  final GestureTapCallback? onTapGallery;
  final GestureTapCallback? onTapCamera;
  // final Widget galleryWidget;
  // final Widget cameraWidget;
  // final String cameraText;
  // final String galleryText;
  const CustomSlidingPanel({
    Key? key,
    required this.onTapGallery,
    required this.onTapCamera,
    // required this.galleryWidget,
    // required this.cameraWidget,
    // required this.cameraText,
    // required this.galleryText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Material(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).colorScheme.background),
              borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w)),
          child: Container(
            width: 100.0.w,
            padding: EdgeInsets.all(5.w),
            child: InkWell(
              onTap: onTapGallery,
              child: Padding(
                padding:  EdgeInsets.all(6.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppIcons.gallery,
                      fit: BoxFit.cover,
                      color: Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
                    ),

                    Text(
                      allTranslations.text("gallery"),
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Material(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).colorScheme.background),
              borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w)),
          child: Container(
            width: 100.0.w,
            padding: EdgeInsets.all(5.w),
            child: InkWell(
              onTap: onTapCamera,
              child: Padding(
                padding:  EdgeInsets.all(6.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppIcons.camera,
                      color: Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
                    ),

                    Text(
                      allTranslations.text("camera"),
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
