//
//
// import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
// import 'package:alalamia_spices/app/exports/provider.dart';special_order.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../core/values/app_colors.dart';
// import '../../../data/model/translations.dart';
// import '../../../global_widgets/continue_purchasing_button.dart';
// import '../../../global_widgets/custom_app_bar.dart';
// import '../../../global_widgets/custom_card_icon_text.dart';
// import '../../../global_widgets/custom_two_text.dart';
// import '../personal_info/widget/text_form_field_with_name.dart';
//
//
// class ContinueSpecialOrder extends StatelessWidget {
//   final String branchName;
//   final String specialOrderName;
//   final String specialOrderDescription;
//   final String date;
//   final String price;
//   final int orderStatus;
//   // final SpecialOrder specialOrder;
//   const ContinueSpecialOrder({
//     Key? key,
//     required this.branchName,
//     required this.specialOrderName,
//     required this.specialOrderDescription,
//     required this.date,
//     required this.price,
//     required this.orderStatus
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Theme.of(context).backgroundColor,
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
//           child: const CustomAppBar(),
//         ),
//         body: Padding(
//           padding: EdgeInsets.all(10.0.w),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               Text(
//                 allTranslations.text("createSpecialOrder"),
//                 style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                     fontSize: 22.sp,
//                     fontWeight: FontWeight.bold
//                 ),
//               ),
//
//               3.ph,
//               Text(
//                   allTranslations.text("specialOrderSubTitle"),
//                   style: Theme.of(context).textTheme.caption!.copyWith(
//                     fontWeight: FontWeight.bold,
//                   )
//               ),
//
//               20.ph,
//
//               Flexible(
//                 child: ListView(
//                   children: [
//
//
//                     /// branch
//                     CustomCardIconText(
//                         color: Theme.of(context).primaryColor,
//                         icon: Icons.language,
//                         iconColor: Colors.grey,
//                         height: 40.h,
//                         width: 45.w,
//                         itemsName: allTranslations.text("theBranch"),
//                         subItemsName: branchName,
//                         itemsNameStyle: Theme.of(context).textTheme.bodyMedium!,
//                         // secondIcon: Icons.arrow_forward_ios,
//                         // secondIconColor: Colors.grey,
//                         onTap: null
//                     ),
//
//
//                     20.ph,
//
//                     /// order name
//                     Container(
//                       padding: EdgeInsets.all(10.0.w),
//                       decoration: BoxDecoration(
//                         color: Theme.of(context).primaryColor,
//                         borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                               allTranslations.text("describeOrder"),
//                               style: Theme.of(context).textTheme.bodyMedium!
//                           ),
//                           5.ph,
//                           Text(
//                               specialOrderName,
//                               style: Theme.of(context).textTheme.caption
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     20.ph,
//
//                     /// description order
//                     Container(
//                       padding: EdgeInsets.all(10.0.w),
//                       decoration: BoxDecoration(
//                         color: Theme.of(context).primaryColor,
//                         borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             allTranslations.text("describeOrder"),
//                             style: Theme.of(context).textTheme.bodyMedium!
//                           ),
//                           5.ph,
//                           Text(
//                               specialOrderDescription,
//                               style: Theme.of(context).textTheme.caption
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     20.ph,
//
//
//                     /// date
//                     CustomCardIconText(
//                         color: Theme.of(context).primaryColor,
//                         icon: Icons.date_range,
//                         iconColor: Colors.grey,
//                         height: 40.h,
//                         width: 45.w,
//                         itemsName: allTranslations.text("deliverTime"),
//                         subItemsName: date,
//                         itemsNameStyle: Theme.of(context).textTheme.bodyMedium!,
//                         // secondIcon: Icons.arrow_forward_ios,
//                         // secondIconColor: Colors.grey,
//                         onTap: null
//                     ),
//
//                     20.ph,
//
//
//                     /// order price
//                     CustomCardIconText(
//                         color: Theme.of(context).primaryColor,
//                         icon: Icons.monetization_on_sharp,
//                         iconColor: Colors.grey,
//                         height: 40.h,
//                         width: 45.w,
//                         itemsName: allTranslations.text("orderPrice"),
//                         subItemsName: "5000",
//                         itemsNameStyle: Theme.of(context).textTheme.bodyMedium!,
//                         // secondIcon: Icons.arrow_forward_ios,
//                         // secondIconColor: Colors.grey,
//                         onTap: null
//                     ),
//
//
//                     20.ph,
//
//
//                     /// order status
//                     CustomCardIconText(
//                         color: Theme.of(context).primaryColor,
//                         icon: Icons.done,
//                         iconColor: Colors.grey,
//                         height: 40.h,
//                         width: 45.w,
//                         itemsName: allTranslations.text("orderStatus"),
//                         itemsNameStyle: Theme.of(context).textTheme.bodyMedium!,
//                         secondWidget: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               height: 30.h,
//                               width: 150.w,
//                               decoration: BoxDecoration(
//                                 color: Colors.red.withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   allTranslations.text("notApprovedYet"),
//                                   style: Theme.of(context).textTheme.caption!.copyWith(
//                                       fontWeight: FontWeight.bold
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         onTap: null
//                     ),
//
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: ContinuePurchasingButton(
//           childPurchasing:  Padding(
//             padding: const EdgeInsets.only(top:  15.0 , bottom:  15 , left: 30 , right: 30),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                     allTranslations.text("addToCart"),
//                     style: Theme.of(context).textTheme.headline1!.copyWith(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16
//                     )
//                 ),
//
//                 Icon(
//                   Icons.add_shopping_cart_outlined,
//                   size: 20,
//                   color: Theme.of(context).colorScheme.secondary,
//                 ),
//
//               ],
//             ),
//           ),
//           childShopping: Center(
//             child: Text(
//                 allTranslations.text("continuePurchasing"),
//                 style: Theme.of(context).textTheme.headline1!.copyWith(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16
//                 )
//             ),
//           ),
//           onTapPurchasing: (){},
//           onTapShopping: (){},
//         ),
//       ),
//     );
//   }
// }
