
import 'package:alalamia_spices/app/core/utils/constants.dart';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class RatingCard extends StatelessWidget {
  String ratingType;
  ValueChanged<double> onRatingUpdate;
  double initialRating;
   RatingCard({
    required this.ratingType,
    required this.initialRating,
    required this.onRatingUpdate,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
        color: Theme.of(context).primaryColor
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
           ratingType,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold
            ),
          ),

          15.ph,

          RatingBar.builder(
            initialRating: initialRating,
            unratedColor: Theme.of(context).colorScheme.surface,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 30,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0.w),
            itemBuilder: (context, _) =>  Icon(
               Icons.star,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onRatingUpdate: onRatingUpdate,
          )
        ],

      ),
    );
  }
}
