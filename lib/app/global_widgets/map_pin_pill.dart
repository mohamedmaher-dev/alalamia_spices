import 'package:alalamia_spices/app/core/utils/constants.dart';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alalamia_spices/app/exports/model.dart';


class MapPinPillComponent extends StatefulWidget {
  final double pinPillPosition;
  final Branches branch;
  final GestureTapCallback onTap;

  const MapPinPillComponent({
    super.key,
    required this.pinPillPosition,
    required this.branch,
    required this.onTap
  });

  @override
  State<StatefulWidget> createState() => MapPinPillComponentState();
}

class MapPinPillComponentState extends State<MapPinPillComponent> {

  @override
  Widget build(BuildContext context) {

    return AnimatedPositioned(
      bottom: widget.pinPillPosition,
      right: 0,
      left: 0,
      duration: const Duration(milliseconds: 200),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          // height: 65.h,
          margin: EdgeInsets.all(10.0.w),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
              boxShadow: <BoxShadow>[
                BoxShadow(blurRadius: 20, offset: Offset.zero, color: Colors.grey.withOpacity(0.5))
              ]
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: widget.onTap,
                  child: Container(
                    padding: EdgeInsets.all(8.h),
                    margin: EdgeInsetsDirectional.only(start: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(widget.branch.name!,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'cairo'
                            )
                        ),
                        // Text(widget.branch.address!, style: TextStyle(fontSize: 12, color: Colors.grey)),

                        5.ph,

                        Text(widget.branch.phone!,
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                fontFamily: 'cairo'
                            )
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.h),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 25,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}