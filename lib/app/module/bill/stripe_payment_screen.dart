//
//
// import 'package:alalamia_spices/app/core/utils/constants.dart';
// import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
// import 'package:alalamia_spices/app/exports/provider.dart';
// import 'package:alalamia_spices/app/exports/widget.dart';
// import 'package:alalamia_spices/app/exports/services.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import '../../core/utils/card_number_input_formater.dart';
// import '../../core/values/app_images.dart';
//
//
//
// class StripePaymentScreen extends StatefulWidget {
//   final String orderTotal;
//   final String currency;
//   const StripePaymentScreen({
//     Key? key,
//     required this.orderTotal, required this.currency,
//   }) : super(key: key);
//
//   @override
//   State<StripePaymentScreen> createState() => _StripePaymentScreenState();
// }
//
// class _StripePaymentScreenState extends State<StripePaymentScreen> {
//
//   TextEditingController cardNumberController = TextEditingController();
//   TextEditingController expMonthController = TextEditingController();
//   TextEditingController expYearController = TextEditingController();
//   TextEditingController cvcController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey();
//   int? month ;
//   bool isLoading = false;
//   String? currentCurrency;
//
//
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     if(allTranslations.currentLanguage == "ar" && widget.currency == "درهم اماراتي"){
//       setState(() {
//         currentCurrency = "AED";
//       });
//     }else if(allTranslations.currentLanguage == "ar" && widget.currency == "دولار إمريكي"){
//       setState(() {
//         currentCurrency = "USD";
//       });
//     }else {
//       setState(() {
//         currentCurrency = widget.currency;
//       });
//     }
//   }
//
//
//   @override
//   void dispose() {
//     cardNumberController.dispose();
//     expMonthController.dispose();
//     expYearController.dispose();
//     cvcController.dispose();
//     descriptionController.dispose();
//     super.dispose();
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     var stripeModel = Provider.of<StripePaymentModel>(context);
//
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Theme.of(context).backgroundColor,
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
//           child: const CustomAppBar(),
//         ),
//         body: Padding(
//             padding:  EdgeInsets.all(10.0.w),
//             child: Form(
//               key: _formKey,
//               child: ListView(
//                 children: [
//                   10.ph,
//                   CustomTowText(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     title: allTranslations.text("cardDetails"),
//                     titleStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                       fontWeight: FontWeight.bold
//                     ),
//                     subWidget: Image.asset(
//                       AppImages.masterCard,
//                       width: 80.w,
//                       height: 80.h,
//                     ),
//                   ),
//
//
//                   /// card number
//                   Directionality(
//                     textDirection: TextDirection.ltr,
//                     child: CustomTextFormField(
//                       controller: cardNumberController,
//                       textInputAction: TextInputAction.next,
//                       keyboardType: TextInputType.number,
//                       textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                           fontFamily: "cairo"
//                       ),
//                       hintText: "3782 8224 6310 0050",
//                       hintStyle: Theme.of(context).textTheme.caption!.copyWith(
//                           fontFamily: "cairo",
//                       ),
//                       label: allTranslations.text("cardNumber"),
//                       contentPadding: EdgeInsets.all(10.0.w),
//                       obscureText: false,
//                       prefixIcon: const Icon(
//                         CupertinoIcons.creditcard,
//                         size: 20,
//                         color: Colors.grey,
//                       ),
//                       inputFormatters: [
//                         FilteringTextInputFormatter.digitsOnly,
//                         LengthLimitingTextInputFormatter(19),
//                         CardNumberInputFormatter()
//                       ],
//                       validator: (value){
//                         if (value.isEmpty) {
//                           return allTranslations.text("fieldRequired");
//                         }
//                         if ( value.length <= 16) {
//                           return allTranslations.text("cardFieldsNumber");
//                         }
//
//                         return null;
//                       },
//
//                     ),
//                   ),
//
//                   20.ph,
//
//                   /// exp date
//                   Directionality(
//                     textDirection: TextDirection.ltr,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//
//                         /// exp month
//                         Expanded(
//                           child: CustomTextFormField(
//                             controller: expMonthController,
//                             textInputAction: TextInputAction.next,
//                             keyboardType: TextInputType.number,
//                             textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                                 fontFamily: "cairo"
//                             ),
//                             hintText: "05",
//                             hintStyle: Theme.of(context).textTheme.caption!.copyWith(
//                                 fontFamily: "cairo"
//                             ),
//                             label: allTranslations.text("expMonth"),
//                             contentPadding: EdgeInsets.all(10.0.w),
//                             obscureText: false,
//                             prefixIcon: const Icon(
//                               Icons.date_range,
//                               size: 20,
//                               color: Colors.grey,
//                             ),
//                             inputFormatters: [
//                               FilteringTextInputFormatter.digitsOnly,
//                               LengthLimitingTextInputFormatter(2),
//
//                             ],
//                             validator: (value){
//
//                               if (value.isEmpty) {
//                                 return allTranslations.text("fieldRequired");
//                               }
//                               month = int.parse(value);
//                               if ((month! < 1) || (month! > 12)) {
//                                 // A valid month is between 1 (January) and 12 (December)
//                                 return allTranslations.text("expMonthInvalid");
//                               }
//                             },
//
//                           ),
//                         ),
//                         10.pw,
//
//                         /// exp year
//                         Expanded(
//                           child: CustomTextFormField(
//                             controller: expYearController,
//                             textInputAction: TextInputAction.next,
//                             keyboardType: TextInputType.number,
//                             textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                                 fontFamily: "cairo"
//                             ),
//                             hintText: "2023",
//                             hintStyle: Theme.of(context).textTheme.caption!.copyWith(
//                                 fontFamily: "cairo"
//                             ),
//                             label: allTranslations.text("expYear"),
//                             contentPadding: EdgeInsets.all(10.0.w),
//                             obscureText: false,
//                             prefixIcon: const Icon(
//                               Icons.date_range,
//                               size: 20,
//                               color: Colors.grey,
//                             ),
//                             inputFormatters: [
//                               FilteringTextInputFormatter.digitsOnly,
//                               LengthLimitingTextInputFormatter(4),
//
//                             ],
//                             validator: (value){
//                               if (value.isEmpty) {
//                                 return allTranslations.text("fieldRequired");
//                               }
//
//                             },
//
//                           ),
//                         ),
//
//                       ],
//                     ),
//                   ),
//
//                   /// new
//
//
//
//                   20.ph,
//
//                   /// cvc
//                   Directionality(
//                     textDirection: TextDirection.ltr,
//                     child: CustomTextFormField(
//                       controller: cvcController,
//                       textInputAction: TextInputAction.done,
//                       keyboardType: TextInputType.number,
//                       textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                           fontFamily: "cairo"
//                       ),
//                       hintText: "313",
//                       hintStyle: Theme.of(context).textTheme.caption!.copyWith(
//                           fontFamily: "cairo"
//                       ),
//                       label: allTranslations.text("cvv"),
//                       contentPadding: EdgeInsets.all(10.0.w),
//                       obscureText: false,
//                       prefixIcon: Padding(
//                         padding:  EdgeInsets.all(8.0.w),
//                         child: Container(
//                           width: 50.w,
//                           height: 10.h,
//                           padding: EdgeInsets.all(3.h),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                               border: Border.all(color: Colors.grey[300]!),
//                               color: Colors.grey[300]
//                           ),
//                           child: Center(
//                             child: Text(
//                               allTranslations.text("cvv"),
//                               textAlign: TextAlign.center,
//                               style: Theme.of(context).textTheme.caption,
//                             ),
//                           ),
//                         ),
//                       ),
//                       inputFormatters: [
//                         FilteringTextInputFormatter.digitsOnly,
//                         LengthLimitingTextInputFormatter(4),
//                       ],
//                       validator: (value) {
//                         if (value.isEmpty) {
//                           return allTranslations.text("fieldRequired");
//                         }
//                         if (value.length < 3 || value.length > 4) {
//                           return "CVV is invalid";
//                         }
//                         return null;
//                       },
//
//                     ),
//                   ),
//
//
//                   20.ph,
//                   StatefulBuilder(
//                     builder: (context , mySetState) {
//                       return CustomButtons(
//                         height: 45.h,
//                         text: "${allTranslations.text("payNow")} " " ${double.parse(widget.orderTotal.toString()).round()}  ${currentCurrency}",
//                         textStyle: Theme.of(context).textTheme.headline1!.copyWith(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12.sp,
//                           fontFamily: "cairo"
//                         ),
//                         textWidget: isLoading == false
//                             ? null
//                             : const CircularLoading(),
//                         buttonColor: isLoading == false
//                             ? Theme.of(context).secondaryHeaderColor
//                             : Theme.of(context).backgroundColor,
//                         onTap: () async{
//                           if(_formKey.currentState!.validate()){
//
//                               setState((){
//                                 isLoading = true;
//                               });
//                               await stripeModel.stripeToken(
//                                 cardNumber:  cardNumberController.text,
//                                 expireMonth : expMonthController.text,
//                                 expireYear : expYearController.text ,
//                                 cvcNumber : cvcController.text ,
//                               );
//
//                               if(stripeModel.message == "" && stripeModel.id != ""){
//                                 await stripeModel.stripe(
//                                   totalAmount : double.parse(widget.orderTotal.toString()).round().toString(),
//                                   currency : currentCurrency.toString(),
//                                   description : "alalmiah" ,
//                                 );
//                                 if(stripeModel.message == "" && stripeModel.captured == true && stripeModel.paid == true){
//                                   await showDialog(
//                                       context: context,
//                                       barrierDismissible: false,
//                                       builder: (BuildContext context){
//
//                                         return CustomDialogWidget(
//                                           title: Text(
//                                             allTranslations.text("paymentCompletedSuccessfully"),
//                                             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                                                 fontWeight: FontWeight.bold
//                                             ),
//                                           ),
//                                           content: Text(
//                                             allTranslations.text("saveCvc"),
//                                             textAlign: TextAlign.center,
//                                             style: Theme.of(context).textTheme.bodyMedium!!.copyWith(
//                                                 fontWeight: FontWeight.bold
//                                             ),
//                                           ),
//                                           withYesButton: true,
//                                           withNoButton: true,
//                                           withActions: true,
//                                           onNoPressed: () {
//                                             Navigator.pop(context);
//                                             Navigator.pop(context);
//                                           },
//                                           onPressed: () async{
//                                             Navigator.pop(context);
//                                             Navigator.pop(context);
//                                           },
//                                         );
//                                       }
//                                   );
//                                 }else {
//                                   setState((){
//                                     isLoading = false;
//                                   });
//
//                                   await showDialog(
//                                       context: context,
//                                       barrierDismissible: false,
//                                       builder: (BuildContext context){
//
//                                         return CustomDialogWidget(
//                                           title: Text(
//                                             allTranslations.text("alert"),
//                                             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontFamily: 'cairo'
//                                             ),
//                                           ),
//                                           content: Text(
//                                             stripeModel.message,
//                                             textAlign: TextAlign.center,
//                                             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontFamily: 'cairo'
//                                             ),
//                                           ),
//                                           withYesButton: true,
//                                           withActions: true,
//                                           onPressed: () async{
//                                             Navigator.pop(context);
//
//                                           },
//                                         );
//                                       }
//                                   );
//                                 }
//                               }
//                               else{
//                                 setState((){
//                                   isLoading = false;
//                                 });
//
//                                 await showDialog(
//                                     context: context,
//                                     barrierDismissible: false,
//                                     builder: (BuildContext context){
//
//                                       return CustomDialogWidget(
//                                         title: Text(
//                                           allTranslations.text("alert"),
//                                           style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                                               fontWeight: FontWeight.bold,
//                                               fontFamily: 'cairo'
//                                           ),
//                                         ),
//                                         content: Text(
//                                           stripeModel.message,
//                                           textAlign: TextAlign.center,
//                                           style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                                               fontWeight: FontWeight.bold,
//                                               fontFamily: 'cairo'
//                                           ),
//                                         ),
//                                         withYesButton: true,
//                                         withActions: true,
//                                         onPressed: () async{
//                                           Navigator.pop(context);
//
//                                         },
//                                       );
//                                     }
//                                 );
//                               }
//
//
//
//
//
//                           }else {
//                             setState((){
//                               isLoading = false;
//                             });
//                             _formKey.currentState!.validate();
//                           }
//
//
//
//
//                         },
//                       );
//                     },
//                   )
//
//
//                 ],
//               ),
//             )
//         ),
//       ),
//     );
//   }
// }
