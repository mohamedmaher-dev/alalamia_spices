

import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/constants.dart';
import 'package:alalamia_spices/app/exports/provider.dart';


class IncDecButtons extends StatelessWidget {
  final GestureTapCallback  onTapInc;
  final GestureTapCallback onTapDec;
  final GestureTapCallback onTapDelete;
  final String quantity;
  const IncDecButtons({
    Key? key,
    required this.onTapInc,
    required this.onTapDec,
    required this.onTapDelete,
    required this.quantity,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(

      children: [

        /// increment & decrement
        Container(
          padding: const EdgeInsets.all(3.0),
          width: 100.w,
          height: 30.h,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: onTapInc,
                child: Container(
                  width: 25.w,
                  height : 25.h,
                  decoration:   BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor
                  ),
                  child:  Icon(
                    Icons.arrow_drop_up,
                    color: Theme.of(context).secondaryHeaderColor,
                    size: 25.0,
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child:  Text(
                    quantity,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                        fontFamily: "cairo"
                    ),
                  )),
              InkWell(
                onTap: onTapDec,
                child: Container(
                  width: 25.w,
                  height : 25.h,
                  decoration:   BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor
                  ),
                  child:  Icon(
                    Icons.arrow_drop_down,
                    color: Theme.of(context).secondaryHeaderColor,
                    size: 25.0,
                  ),
                ),
              ),
            ],
          ),
        ),

        20.pw,

        InkWell(
          onTap: onTapDelete,
          child: Row(
            children: [
              const Icon(
                Icons.delete,
                color: Colors.red,
                size: 20,
              ),
              3.pw,
              Text(
                  allTranslations.text("delete"),
                  style: Theme.of(context).textTheme.bodySmall
              )
            ],
          ),
        )
      ],
    );
  }
}
