// import 'package:alalamia_spices/app/core/utils/constants.dart';
// import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
// import 'package:alalamia_spices/app/core/values/app_images.dart';
// import 'package:alalamia_spices/app/exports/widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import '../../../core/utils/card_utils.dart';
// import '../../../data/providers/payment/tap_model.dart';
// import '../../../data/providers/translations.dart';
// import '../provider/form_provider.dart';
//
// class TapPayBottomSheetForm extends StatelessWidget {
//    TapPayBottomSheetForm({super.key});
//   bool _isChecked = false;
//   @override
//   Widget build(BuildContext context) {
//     final tapPaymentModel = Provider.of<TapPaymentProvider>(context);
//     return ChangeNotifierProvider<FormProvider>(
//       create: (context) => FormProvider(),
//       child: Consumer<FormProvider>(
//         builder: (context , formProvider , child){
//           return WillPopScope(
//             onWillPop: () async {
//               formProvider.disposeControllers();
//               return true;
//             },
//             child: Form(
//               key: formProvider.formKey,
//               child: SingleChildScrollView(
//                 child: StatefulBuilder(
//                   builder: (context , mySetState){
//                     return Column(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.all(10.0.w),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             // mainAxisSize: MainAxisSize.min,
//                             children: [
//
//                               BottomSheetHeader(title: allTranslations.text("paymentByCard")),
//
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     allTranslations.text('acceptPaymentVia'),
//                                     style: Theme.of(context).textTheme.bodyMedium!!.copyWith(
//                                         fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     children: [
//                                       Image.asset(
//                                         AppImages.masterCard,
//                                         width: 35.w,
//                                         height: 35.h,
//                                       ),
//                                       6.pw,
//                                       Image.asset(
//                                         AppImages.visaCard,
//                                         width: 35.w,
//                                         height: 35.h,
//                                       ),
//                                       6.pw,
//                                       Image.asset(
//                                         AppImages.madaPay,
//                                         width: 35.w,
//                                         height: 35.h,
//                                       ),
//                                     ],
//                                   )
//
//                                 ],
//                               ),
//
//                               16.ph,
//                               /// name
//                               CustomTextFormField(
//                                 controller: formProvider.nameHolderController,
//                                 keyboardType: TextInputType.text,
//                                 textInputAction: TextInputAction.next,
//                                 hintText: allTranslations.text("holderName"),
//                                 labelText: allTranslations.text("holderName"),
//                                 contentPadding: EdgeInsets.symmetric(horizontal: 10.w , vertical: 15.h),
//                                 suffixIcon: Icon(Icons.person , color: Colors.grey[400], size: 20.r,),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return allTranslations.text("fieldRequired");
//                                   }
//                                   return null;
//                                 },
//                               ),
//
//                               16.ph,
//
//                               /// card number
//                               CustomTextFormField(
//                                 controller: formProvider.cardNumberController,
//                                 keyboardType: TextInputType.number,
//                                 textInputAction: TextInputAction.next,
//                                 hintText: allTranslations.text("cardNumber"),
//                                 labelText: allTranslations.text("cardNumber"),
//                                 suffixIcon: Icon(Icons.credit_card , color: Colors.grey[400], size: 20.r,),
//                                 textDirection: TextDirection.ltr,
//                                 contentPadding: EdgeInsets.symmetric(horizontal: 10.w , vertical: 15.h),
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(AppConstants.defaultBorderRadius.w),
//                                   topRight: Radius.circular(AppConstants.defaultBorderRadius.w)
//                                 ),
//                                 inputFormatters: CardUtils.cardInputFormatters,
//                                 validator: (value) => CardUtils.cardValidator(value),
//                               ),
//
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     flex : 2,
//                                     child: CustomTextFormField(
//                                       controller: formProvider.expDateController,
//                                       keyboardType: TextInputType.datetime,
//                                       textInputAction: TextInputAction.next,
//                                       hintText: allTranslations.text("expireDate"),
//                                       labelText: allTranslations.text("expireDate"),
//                                       suffixIcon: Icon(Icons.date_range , color: Colors.grey[400], size: 20.r,),
//                                       contentPadding: EdgeInsets.symmetric(horizontal: 10.w , vertical: 15.h),
//                                       borderRadius: allTranslations.currentLanguage == "ar"
//                                          ? BorderRadius.only(
//                                           bottomRight: Radius.circular(AppConstants.defaultBorderRadius.w)
//                                       )
//                                          : BorderRadius.only(
//                                             bottomLeft: Radius.circular(AppConstants.defaultBorderRadius.w)
//                                       ),
//                                       inputFormatters: CardUtils.dateFormatters,
//                                       validator: (value) => CardUtils.validateDate(value),
//                                     ),
//                                   ),
//
//                                   Expanded(
//                                     child: CustomTextFormField(
//                                       controller: formProvider.cvvController,
//                                       keyboardType: TextInputType.number,
//                                       textInputAction: TextInputAction.done,
//                                       hintText: allTranslations.text("cvv"),
//                                       labelText: allTranslations.text("cvv"),
//                                       contentPadding: EdgeInsets.symmetric(horizontal: 10.w , vertical: 15.h),
//                                       obscureText: false,
//                                       suffixIcon: Icon(Icons.credit_card , color: Colors.grey[400], size: 20.r,),
//                                       borderRadius: allTranslations.currentLanguage == "ar"
//                                          ? BorderRadius.only(
//                                           bottomLeft: Radius.circular(AppConstants.defaultBorderRadius.w),
//                                       )
//                                          : BorderRadius.only(
//                                           bottomRight: Radius.circular(AppConstants.defaultBorderRadius.w)
//                                       ),
//                                       inputFormatters: CardUtils.cvvFormatters,
//                                       validator: (value) => CardUtils.validateCVV(value),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Checkbox(
//                               value: _isChecked,
//                               onChanged: (bool? value) {
//                                 mySetState(() {
//                                   _isChecked = value ?? false;
//                                 });
//                               },
//                             ),
//                             Text(
//                               allTranslations.text("saveCardData"),
//                               style: Theme.of(context).textTheme.bodyMedium!!.copyWith(
//                                   fontWeight: FontWeight.bold
//                               ),
//                             ),
//                           ],
//                         ),
//                         20.ph,
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 10.0.w),
//                           child: CustomButtons(
//                             height: 45.h,
//                             text: allTranslations.text("save"),
//                             isLoading: tapPaymentModel.isLoading,
//                             buttonColor: Theme.of(context).secondaryHeaderColor,
//                             onTap: (){
//                               if (formProvider.validateForm()) {
//                                 final expiryDate = formProvider.expDateController.text.trim();
//                                 final expiryParts = expiryDate.split('/');
//
//                                 if (expiryParts.length != 2) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text("Invalid expiry date format. Use MM/YY."),
//                                     ),
//                                   );
//                                   return;
//                                 }
//                                 final expiryMonth = expiryParts[0];
//                                 final expiryYear = "20${expiryParts[1]}";
//                                 final cardData = {
//                                   "number": formProvider.cardNumberController,
//                                   "exp_month": expiryMonth,
//                                   "exp_year": expiryYear,
//                                   "cvc": formProvider.cvvController,
//                                   "name": formProvider.nameHolderController,
//                                   "save_card": _isChecked,
//                                 };
//
//                                 tapPaymentModel.makePayment(cardData, 1 , "USD");
//                               }
//                             },
//                           ),
//                         )
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }