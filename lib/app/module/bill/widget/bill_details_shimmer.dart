//
//
// import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shimmer/shimmer.dart';
//
// import '../../../core/utils/constants.dart';
// import '../../../data/model/translations.dart';
// import '../../../global_widgets/custom_two_text.dart';
//
// class BillDetailsShimmer extends StatelessWidget {
//   const BillDetailsShimmer({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//         baseColor: Colors.grey.withOpacity(0.25),
//         highlightColor: Colors.white.withOpacity(0.6),
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         padding: EdgeInsets.all(5.0.w),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//         ),
//
//         child: Padding(
//           padding:  EdgeInsets.all(10.0.w),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 allTranslations.text("billDetails"),
//                 style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                     fontWeight: FontWeight.bold
//                 ),
//               ),
//
//               15.ph,
//
//               /// items count
//               CustomTowText(
//                 title: allTranslations.text("itemsCount"),
//                 titleStyle: Theme.of(context).textTheme.bodyMedium!!.copyWith(
//                     fontWeight: FontWeight.bold
//                 ),
//                 subTitle : "",
//                 subTitleStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
//                     fontFamily: "cairo"
//                 ),
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               ),
//               15.ph,
//
//               const Divider(),
//
//               /// total
//               CustomTowText(
//                 title: allTranslations.text("total"),
//                 titleStyle: Theme.of(context).textTheme.bodyMedium!!.copyWith(
//                     fontWeight: FontWeight.bold
//                 ),
//                 subTitle : "",
//                 subTitleStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
//                     fontFamily: "cairo"
//                 ),
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               ),
//               15.ph,
//               const Divider(),
//
//               /// shipping fee
//
//               CustomTowText(
//                 title: allTranslations.text("shippingFee"),
//                 titleStyle: Theme.of(context).textTheme.bodyMedium!!.copyWith(
//                     fontWeight: FontWeight.bold
//                 ),
//                 subTitle :  allTranslations.text("freeDeliver"),
//                 subTitleStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
//                     fontFamily: "cairo"
//                 ),
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               ),
//               15.ph,
//               const Divider(),
//
//
//
//
//               /// tax fee
//             Padding(
//                 padding:  EdgeInsets.only(bottom: 15.0.h),
//                 child: CustomTowText(
//                   title: allTranslations.text("taxFee"),
//                   titleStyle: Theme.of(context).textTheme.bodyMedium!!.copyWith(
//                       fontWeight: FontWeight.bold,
//                       fontFamily: "cairo"
//                   ),
//
//                   subTitle : "",
//                   subTitleStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
//                       fontFamily: "cairo"
//                   ),
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 ),
//               ),
//
//
//
//
//
//
//
//               /// coupon
//              CustomTowText(
//                 title: allTranslations.text("coupon"),
//                 titleStyle: Theme.of(context).textTheme.bodyMedium!!.copyWith(
//                     fontWeight: FontWeight.bold
//                 ),
//                 subTitle : "",
//                 subTitleStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
//                     fontFamily: "cairo"
//                 ),
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               ),
//
//               15.ph,
//
//
//
//               /// discount
//
//               // if discount from wallet
//             CustomTowText(
//                 title:  "${allTranslations.text("discount")}",
//                 titleStyle: Theme.of(context).textTheme.bodyMedium!!.copyWith(
//                     fontWeight: FontWeight.bold
//                 ),
//                 subTitle : "",
//                 subTitleStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
//                     fontFamily: "cairo"
//                 ),
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               ),
//
//
//               // if discount is not from wallet
//
//               CustomTowText(
//                 title:  "${allTranslations.text("discount")}:",
//                 titleStyle: Theme.of(context).textTheme.bodyMedium!!.copyWith(
//                     fontWeight: FontWeight.bold
//                 ),
//                 subTitle : "",
//                 subTitleStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
//                     fontFamily: "cairo"
//                 ),
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               ),
//
//
//               15.ph,
//
//
//               /// amount to be Paid
//               CustomTowText(
//                 title: allTranslations.text("amountToBePaid"),
//                 titleStyle: Theme.of(context).textTheme.bodyMedium!!.copyWith(
//                     fontWeight: FontWeight.bold
//                 ),
//                 subTitle : "",
//                 subTitleStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
//                     fontFamily: "cairo"
//                 ),
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               ),
//               15.ph,
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
