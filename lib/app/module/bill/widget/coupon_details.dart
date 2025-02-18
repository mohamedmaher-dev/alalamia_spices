// import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
// import 'package:alalamia_spices/app/data/model/coupon_model.dart';
// import 'package:alalamia_spices/app/exports/provider.dart';
// import 'package:alalamia_spices/app/global_widgets/custom_buttons.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../data/model/cartModel.dart';
// import '../../../data/model/translations.dart';
// import '../../../services/custom_dialog.dart';
// import '../../user/personal_info/widget/text_form_field_with_name.dart';
//
// Widget? text;
// bool? checkState;
// String? coupon;
// class CouponDetails extends StatefulWidget {
//   final String? couponPrice;
//   const CouponDetails({
//     Key? key,
//     this.couponPrice
//   }) : super(key: key);
//
//   @override
//   State<CouponDetails> createState() => _CouponDetailsState();
// }
//
// class _CouponDetailsState extends State<CouponDetails> {
//   late TextEditingController couponController;
//   double? couponPrice;
//   String? couponType;
//   String? couponText;
//   String? error;
//   String? status;
//
//   @override
//   void initState() {
//     super.initState();
//     couponController = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     couponController.dispose();
//   }
//
//   // Future checkCoupon (BuildContext context) async{
//   //   var couponModel = Provider.of<CouponModel>(context , listen: false);
//   //   var newArrivalModel = Provider.of<NewArrivalModel>(context , listen: false);
//   //   if(couponController.text.isNotEmpty){
//   //     // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//   //     // final SharedPreferences prefs = await _prefs;
//   //
//   //
//   //
//   //     if (await couponModel.checkCoupon(
//   //         number: couponController.text,
//   //         productId: "1"
//   //     )) {
//   //       setState(() {
//   //         couponPrice = double.parse(couponModel.coupon.price.toString());
//   //         couponType = couponModel.coupon.valueType;
//   //         couponText = couponController.text;
//   //       });
//   //       if (couponType == "price") {
//   //         text=  Row(
//   //          mainAxisAlignment: MainAxisAlignment.start,
//   //          children: <Widget>[
//   //            Text(
//   //              "${couponModel.coupon.price}"),
//   //            5.pw,
//   //            const Icon(
//   //                Icons.check_circle,
//   //                size: 17.0, color: Colors.green
//   //            ),
//   //          ],
//   //        );
//   //       } else {
//   //         text =  Row(
//   //           mainAxisAlignment:
//   //           MainAxisAlignment.start,
//   //           children: <Widget>[
//   //             Text(
//   //                 "${double.parse(couponModel.coupon.price.toString()).round()}" "%"),
//   //             5.pw,
//   //             const Icon(
//   //                 Icons.check_circle,
//   //                 size: 17.0, color: Colors.green),
//   //           ],
//   //         );
//   //       }
//   //       CustomDialog().showCustomDialog(
//   //           context: context,
//   //           title: Text(
//   //             allTranslations.text("correctCoupon"),
//   //             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//   //                 fontWeight: FontWeight.bold
//   //             ),
//   //           ),
//   //         content: Text(
//   //           "${double.parse(couponModel.coupon.price.toString()).round()}" "%",
//   //           style: Theme.of(context).textTheme.bodyMedium!!.copyWith(
//   //               fontWeight: FontWeight.bold
//   //           ),
//   //         ),
//   //         withActions: true,
//   //         withYesButton: true
//   //       );
//   //     } else {
//   //       setState(() {
//   //         couponText = "";
//   //         //couponcontroller.text = "";
//   //         couponPrice = 0.0;
//   //         couponType = "price";
//   //       });
//   //       text = Column(
//   //         mainAxisAlignment: MainAxisAlignment.start,
//   //         children: [
//   //           Text(
//   //             allTranslations.text("errorCoupon"),
//   //             style: Theme.of(context).textTheme.caption!.copyWith(
//   //               color: Colors.red
//   //             ),
//   //           ),
//   //         ],
//   //       );
//   //     }
//   //     setState(() {
//   //       checkState = true;
//   //     });
//   //
//   //   }
//   //
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return ChangeNotifierProvider(
//       create: (context) => CouponModel(context),
//       child: Consumer<CouponModel>(
//         builder: (context, model, child) {
//           return Container(
//             padding: EdgeInsets.all(10.0.w),
//             decoration: BoxDecoration(
//               color: Theme.of(context).primaryColor,
//               borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//             ),
//             child: TextFormFieldWithName(
//               controller: couponController,
//               keyboardType: TextInputType.text,
//               textInputAction: TextInputAction.done,
//               hintTextFormField: allTranslations.text("couponHint"),
//               fieldName: allTranslations.text("couponDetails"),
//               textStyle: Theme.of(context).textTheme.bodyMedium!!.copyWith(
//                   fontFamily: "cairo"
//               ),
//               fieldNameStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
//               suffixIcon: couponController.text.isEmpty
//                   ? 0.ph
//                   : Padding(
//                       padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 5.w),
//                       child: InkWell(
//                         onTap: () async {
//                           if (couponController.text.isNotEmpty) {
//
//                             if (await model.checkCoupon(
//                                 number: couponController.text,
//                                 productId: "1"
//                             )) {
//                               setState(() {
//                                 couponPrice = double.parse(model.coupon.price.toString());
//                                 coupon = couponPrice.toString();
//                                 couponType = model.coupon.valueType;
//                                 couponText = couponController.text;
//                               });
//
//                               CustomDialog().showCustomDialog(
//                                   context: context,
//                                   title: Text(
//                                     allTranslations.text("correctCoupon"),
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyLarge!
//                                         .copyWith(fontWeight: FontWeight.bold),
//                                   ),
//                                   content: Text(
//                                     "${double.parse(model.coupon.price.toString()).round()}"
//                                     "%",
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyMedium!!
//                                         .copyWith(fontWeight: FontWeight.bold),
//                                   ),
//                                   withActions: true,
//                                   withYesButton: true);
//                             } else {
//                               setState(() {
//                                 couponText = "";
//                                 //couponcontroller.text = "";
//                                 couponPrice = 0.0;
//                                 couponType = "price";
//                               });
//                               text = Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     allTranslations.text("errorCoupon"),
//                                     style: const TextStyle(
//                                         color: Colors.red,
//                                         fontSize: 12,
//                                         fontFamily: "cairo",
//                                         fontWeight: FontWeight.normal),
//                                   ),
//                                 ],
//                               );
//                             }
//                             setState(() {
//                               checkState = true;
//                             });
//                           }
//                         },
//                         child: Text(
//                           allTranslations.text("checkCoupon"),
//                           textAlign: TextAlign.center,
//                           style: Theme.of(context).textTheme.caption!.copyWith(
//                               color: Theme.of(context).secondaryHeaderColor),
//                         ),
//                       ),
//                     ),
//               contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
//               onFieldSubmitted: () {
//                 FocusScope.of(context).unfocus();
//               },
//               onChanged: (value) {
//                 setState(() {
//                   couponController.text = value;
//                 });
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
