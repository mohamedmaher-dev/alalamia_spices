
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/constants.dart';
import '../../../../data/model/special_order.dart';

class MySpecialOrdersCard extends StatelessWidget {
  final SpecialOrder specialOrder ;
  const MySpecialOrdersCard({
    Key? key,
    required this.specialOrder
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10.0.w , vertical: 10.h),
      child: Container(
        padding: EdgeInsets.all(10.0.w),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
        ),
        child: Padding(
          padding:  EdgeInsets.all(5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start ,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    specialOrder.name.toString(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  5.ph,
                  Text(
                      specialOrder.desc.toString(),
                      style:  Theme.of(context).textTheme.bodySmall
                  ),
                ],
              ),


              const Spacer(),

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.0.w),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Colors.grey,
                ),
              )



            ],
          ),
        ),
      ),
    );

    //   SizedBox(
    //   width: MediaQuery.of(context).size.width,
    //   height: 80.h,
    //   child: Card(
    //     elevation: 0.2,
    //     color: Theme.of(context).primaryColor,
    //     child: Padding(
    //       padding: EdgeInsets.all(10.0.w),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //
    //
    //           Text(
    //             "عسل يمني بالمكسرات",
    //             style: Theme.of(context).textTheme.bodyMedium!!.copyWith(
    //                 fontWeight: FontWeight.bold
    //             ),
    //           ),
    //
    //           Container(
    //             height: 30.h,
    //             width: 80.w,
    //             decoration: BoxDecoration(
    //               color: Theme.of(context).backgroundColor,
    //               borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
    //             ),
    //             child: Center(
    //               child: Text(
    //                 "تمت الموافقة",
    //                 style: Theme.of(context).textTheme.caption!.copyWith(
    //                     fontWeight: FontWeight.bold
    //                 ),
    //               ),
    //             ),
    //           ),
    //
    //
    //
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
