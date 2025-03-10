// import 'package:alalamia_spices/app/core/utils/constants.dart';
// import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
// import 'package:alalamia_spices/app/data/providers/shipping/aramex_provider.dart';
// import 'package:alalamia_spices/app/exports/provider.dart';
// import 'package:alalamia_spices/app/module/bill/provider/bill_provider.dart';
// import 'package:alalamia_spices/app/module/bill/widget/bill_shimmer.dart';
// import 'package:alalamia_spices/app/module/bill/widget/checkou_bottom_sheet.dart';
// import 'package:alalamia_spices/app/module/check_out/widget/index.dart';
// import 'package:alalamia_spices/app/module/user/last_orders/last_orders_screen.dart';
// import 'package:alalamia_spices/app/exports/services.dart';
// import 'package:alalamia_spices/app/exports/widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../core/values/app_colors.dart';
// import '../../core/values/app_lottie.dart';
// import '../../data/model/request.dart';
// import '../check_out/widget/location_details.dart';
// import 'package:alalamia_spices/app/exports/model.dart';
//
//
// Widget? text;
// bool? checkState;
// class BillScreen extends StatelessWidget {
//   final String? shippingType;
//   const BillScreen({
//     Key? key,
//     this.shippingType
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//         providers: [
//           ChangeNotifierProvider(create: (context) => TaxModel(context)),
//           ChangeNotifierProvider(create: (context) => DiscountModel(context)),
//           ChangeNotifierProvider(create: (context) => FinancialPortfoliosModel(context)),
//           ChangeNotifierProvider(create: (context) => CouponModel(context)),
//           ChangeNotifierProvider(create: (context) => PayPalModel(context)),
//           ChangeNotifierProvider(create: (context) => BillProvider()),
//           ChangeNotifierProvider(create: (context) => TapModel(context)),
//           ChangeNotifierProvider(create: (context) => AramexProvider()),
//         ],
//         child: SubBillScreen(
//           shippingType: shippingType.toString(),
//         )
//
//     );
//   }
// }
//
//
//
// class SubBillScreen extends StatefulWidget {
//   final String shippingType;
//   const SubBillScreen({
//     Key? key,
//     required this.shippingType
//   }) : super(key: key);
//
//   @override
//   State<SubBillScreen> createState() => _SubBillScreenState();
// }
//
// class _SubBillScreenState extends State<SubBillScreen> {
//
//   late TextEditingController noteController;
//   late TextEditingController couponController;
//   late TextEditingController payerController;
//   double deliveryPrice = 0.0;
//   String deliveryPriceId = "";
//   double  amountToBePaid = 0.0 ;
//   var cartStatus;
//   // String? cartId;
//   int? cartId;
//   bool isLoading = false;
//   bool isCouponCheck = false;
//   // String? branchId ;
//   double couponPrice = 0.0;
//   String? couponType;
//   String? couponText;
//   String? error;
//   String? status;
//   double couponDiscount = 0.0;
//   double discount = 0.0;
//   double total = 0.0;
//   double tax = 0.0;
//   double deliveryPriceAfterDiscount = 0.0;
//   int paymentIndex = 0 ;
//   var returnOfRequest;
//   bool  isUnsupportedCurrency = false;
//   // String? chosenPayment;
//   String? chosenPaymentNumber = "2";
//   String walletNumber = "1";
//   String cashNumber = "2";
//   String payPalNumber = "3";
//   String cardPaymentNumber = "4";
//
//
//   @override
//   void initState() {
//     super.initState();
//     noteController = TextEditingController();
//     couponController = TextEditingController();
//     payerController = TextEditingController();
//
//   }
//
//
//   @override
//   void dispose() {
//     super.dispose();
//     noteController.dispose();
//     couponController.dispose();
//     // payerController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     // Fetch providers
//     final cartModel = Provider.of<CartModel>(context , listen: false);
//     final taxModel = Provider.of<TaxModel>(context);
//     final userModel = Provider.of<UserModel>(context)..getUserInfo();
//     final userWalletModel = Provider.of<UserWalletModel>(context);
//     final newDeliveryPriceModel = Provider.of<NewDeliveryPriceModel>(context);
//     final requestModel = Provider.of<RequestModel>(context);
//     final discountModel = Provider.of<DiscountModel>(context);
//     final financialPortfoliosModel = Provider.of<FinancialPortfoliosModel>(context);
//     final themeModel = Provider.of<ThemeModel>(context);
//     final payPalModel = Provider.of<PayPalModel>(context);
//     final billProvider = Provider.of<BillProvider>(context);
//     final tapPaymentModel = Provider.of<TapModel>(context);
//     final aramexProvider = Provider.of<AramexProvider>(context);
//
//
//
//     DiscountVolume? discountVolume;
//
//     final cartList = cartModel.items.where((element) => !element.isPaidAdd).toList();
//
//
//     // Calculate delivery price
//     _calculateDeliveryPrice(cartModel, newDeliveryPriceModel);
//
//     // Calculate tax and total amount to be paid
//     _calculateTaxAndTotalAmount(cartModel, taxModel);
//
//     // Handle coupon discounts
//     if (cartModel.items.isNotEmpty && cartModel.isLoaded) {
//       _applyCouponDiscounts(cartModel);
//     }
//
//     // Handle discount volume logic
//     if (discountModel.items.isNotEmpty && discountModel.isLoaded) {
//       _applyDiscountVolume(discountModel, cartModel);
//     }
//
//     Widget calculationDiscount(BuildContext context) {
//       Widget? child;
//
//       if (cartModel.items.isNotEmpty) {
//         // Discount of balance
//         if (discountVolume!.valueType == "price" && discountVolume.type == "balance" && chosenPaymentNumber == walletNumber) {
//           child = Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "${discountVolume.value}",
//                 style: Theme.of(context).textTheme.subtitle2!.copyWith(fontFamily: "cairo"),
//               ),
//               Center(
//                 child: Text(
//                   "${cartModel.items[0].currency}",
//                   style: Theme.of(context).textTheme.subtitle2!.copyWith(fontFamily: "cairo", fontSize: 10.sp),
//                 ),
//               ),
//             ],
//           );
//         }
//         // Discount of percentage (balance)
//         else if (discountVolume!.valueType == "percentage" && discountVolume.type == "balance" && chosenPaymentNumber == walletNumber) {
//           child = Text(
//             "${(double.parse(discountVolume.value.toString())).round()} %",
//             style: Theme.of(context).textTheme.subtitle2!.copyWith(fontFamily: "cairo"),
//           );
//         }
//
//         // Discount of minimum (price)
//         else if (discountVolume.valueType == "price" && discountVolume.type == "minimum") {
//           child = Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "${discountVolume.value} ",
//                 style: Theme.of(context).textTheme.subtitle2!.copyWith(fontFamily: "cairo"),
//               ),
//               Center(
//                 child: Text(
//                   "${cartModel.items[0].currency}",
//                   style: Theme.of(context).textTheme.subtitle2!.copyWith(fontFamily: "cairo", fontSize: 10.sp),
//                 ),
//               ),
//             ],
//           );
//         }
//         // Discount of minimum (percentage)
//         else if (discountVolume.valueType == "percentage" && discountVolume.type == "minimum") {
//           child = Text(
//             "${(double.parse(discountVolume.value.toString())).round()} %",
//             style: Theme.of(context).textTheme.subtitle2!.copyWith(fontFamily: "cairo"),
//           );
//         }
//
//         // Discount of delivery (price)
//         else if (discountVolume.valueType == "price" && discountVolume.type == "delivery" && chosenPaymentNumber == cashNumber) {
//           child = Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 discountVolume.value.toString(),
//                 style: Theme.of(context).textTheme.subtitle2!.copyWith(fontFamily: "cairo"),
//               ),
//               5.pw,
//               Center(
//                 child: Text(
//                   "${cartModel.items[0].currency}",
//                   style: Theme.of(context).textTheme.subtitle2!.copyWith(fontFamily: "cairo", fontSize: 10.sp),
//                 ),
//               ),
//             ],
//           );
//         }
//         // Discount of delivery (percentage)
//         else if (discountVolume.valueType == "percentage" && discountVolume.type == "delivery" && chosenPaymentNumber == cashNumber) {
//           child = Text(
//             "${(double.parse(discountVolume.value.toString())).round()} %",
//             style: Theme.of(context).textTheme.subtitle2!.copyWith(fontFamily: "cairo"),
//           );
//         }
//       }
//
//       return Container(child: child);
//     }
//
//     return Consumer<ConnectivityNotifier> (
//       builder: (context , connection , child){
//         return SafeArea(
//           child: connection.hasConnection
//               ?  Scaffold(
//               backgroundColor: Theme.of(context).backgroundColor,
//               appBar: PreferredSize(
//                 preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
//                 child: const CustomAppBar(),
//               ),
//               body: ChangeNotifierProvider(
//                 create: (context) => UserModel(context),
//                 child: Consumer<UserModel>(
//                   builder: (context , userModel , child){
//                     userModel.getUserInfo();
//                     return userModel.isLoading || userModel.loadingFailed
//                         ?  const BillShimmer()
//                         :  Padding(
//                       padding:  EdgeInsets.all(10.0.w),
//                       child: ListView(
//                         children: [
//
//                           /// coupon details
//                           ChangeNotifierProvider<CouponModel>(
//                             create: (context) => CouponModel(context),
//                             child: Consumer<CouponModel>(
//                               builder: (context, model, child) {
//                                 return Container(
//                                   padding: EdgeInsets.all(10.0.w),
//                                   decoration: BoxDecoration(
//                                     color: Theme.of(context).primaryColor,
//                                     borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       TextFormFieldWithName(
//                                         controller: couponController,
//                                         keyboardType: TextInputType.text,
//                                         textInputAction: TextInputAction.done,
//                                         hintTextFormField: allTranslations.text("couponHint"),
//                                         fieldName: allTranslations.text("couponDetails"),
//                                         textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
//                                             fontFamily: "cairo"
//                                         ),
//                                         fieldNameStyle: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
//
//                                         onFieldSubmitted: () {
//                                           FocusScope.of(context).unfocus();
//                                         },
//
//                                       ),
//
//
//
//                                       10.ph,
//                                       couponController.text.isEmpty
//                                           ? 0.ph
//                                           : InkWell(
//                                         onTap: () async {
//                                           if (couponController.text.isNotEmpty) {
//                                             setState(() {
//                                               isCouponCheck = true;
//                                             });
//                                             if (await model.checkNormalCoupon(
//                                               number: couponController.text,
//
//                                             )) {
//                                               setState(() {
//                                                 couponPrice = double.parse(model.coupon.price.toString());
//                                                 couponType = model.coupon.valueType;
//                                                 couponText = couponController.text;
//                                               });
//
//                                               CustomDialog.showCustomDialog(
//                                                   context: context,
//                                                   barrierDismissible: true,
//                                                   title: allTranslations.text("correctCoupon"),
//                                                   description: Text(
//                                                     couponType == "price"
//                                                         ? "${double.parse(model.coupon.price.toString())}"
//                                                         : "${double.parse(model.coupon.price.toString()).round()} %",
//                                                     textAlign: TextAlign.center,
//                                                     style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                                                         fontWeight: FontWeight.bold,
//                                                         fontFamily: "cairo"
//
//                                                     ),
//                                                   ),
//                                                   withActions: true,
//                                                   withYesButton: true,
//                                                   onPressed: (){
//                                                     CustomDialog.hideCustomDialog(context);
//                                                   }
//                                               );
//
//
//                                               setState(() {
//                                                 isCouponCheck = false;
//                                               });
//                                             } else {
//
//                                               CustomDialog.showCustomDialog(
//                                                   context: context,
//                                                   barrierDismissible: true,
//                                                   title: allTranslations.text("errorCoupon"),
//                                                   icon: Lottie.asset(
//                                                     AppLottie.error,
//                                                     width: 100.w,
//                                                     height: 100.h,
//                                                     repeat: true,
//                                                   ),
//                                                   withActions: true,
//                                                   withYesButton: true,
//                                                   onPressed: (){
//                                                     CustomDialog.hideCustomDialog(context);
//                                                   }
//                                               );
//
//                                               setState(() {
//                                                 couponText = "";
//                                                 couponPrice = 0.0;
//                                                 couponType = "price";
//                                                 isCouponCheck = false;
//                                                 couponController.clear();
//                                               });
//                                               text = Column(
//                                                 mainAxisAlignment: MainAxisAlignment.start,
//                                                 children: [
//                                                   Text(
//                                                     allTranslations.text("errorCoupon"),
//                                                     style: const TextStyle(
//                                                         color: Colors.red,
//                                                         fontSize: 12,
//                                                         fontFamily: "cairo",
//                                                         fontWeight: FontWeight.normal),
//                                                   ),
//                                                 ],
//                                               );
//                                             }
//                                             setState(() {
//                                               checkState = true;
//                                             });
//                                           }
//                                         },
//                                         child:  isCouponCheck == false
//                                             ? CustomButtons(
//                                           text: allTranslations.text("checkCoupon"),
//                                           buttonColor: Theme.of(context).secondaryHeaderColor,
//                                         )
//                                             : const CircularLoading(),
//                                       ),
//
//
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//
//                           15.ph,
//
//                           /// note text filed
//
//                           Container(
//                             padding: EdgeInsets.all(10.0.w),
//                             decoration: BoxDecoration(
//                               color: Theme.of(context).primaryColor,
//                               borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                             ),
//                             child: TextFormFieldWithName(
//                               controller: noteController,
//                               keyboardType: TextInputType.text,
//                               textInputAction: TextInputAction.done,
//                               hintTextFormField:  allTranslations.text("noteHint"),
//                               fieldName: allTranslations.text("note"),
//                               fieldNameStyle : Theme.of(context).textTheme.bodyText1!.copyWith(
//                                   fontWeight: FontWeight.bold
//                               ),
//                               contentPadding: EdgeInsets.symmetric(vertical: 20.h , horizontal: 10.w),
//                               // validator: (value){
//                               //
//                               // },
//                               onFieldSubmitted: (){
//                                 FocusScope.of(context).unfocus();
//                               },
//                             ),
//                           ),
//
//                           15.ph,
//
//
//                           /// payment method
//                           financialPortfoliosModel.isLoading || financialPortfoliosModel.loadingFailed
//                               ? const CircularLoading()
//                               : Consumer<FinancialPortfoliosModel>(
//                             builder: (context , model , child){
//                               // model.getFinancialPortfolios();
//                               return   Container(
//                                 padding:  EdgeInsets.all(10.0.w),
//                                 height: 140.h,
//                                 width: MediaQuery.of(context).size.width,
//                                 decoration: BoxDecoration(
//                                   color:  Theme.of(context).primaryColor,
//                                   borderRadius:  BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                                 ),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       allTranslations.text("paymentMethods"),
//                                       style:   Theme.of(context).textTheme.bodyText1!.copyWith(
//                                           fontWeight: FontWeight.bold
//                                       ),
//                                     ),
//
//                                     5.ph,
//                                     Flexible(
//                                       child: ListView.builder(
//                                         shrinkWrap: true,
//                                         primary: false,
//                                         scrollDirection: Axis.horizontal,
//                                         itemCount: model.items.length,
//                                         itemBuilder: (context , index){
//                                           return Padding(
//                                             padding:  EdgeInsets.symmetric(horizontal: 5.w , vertical: 10.h),
//                                             child: InkWell(
//                                               onTap: () async{
//                                                 setState(() {
//                                                   paymentIndex = index;
//                                                   isUnsupportedCurrency = false;
//                                                   chosenPaymentNumber = model.items[paymentIndex].number.toString();
//                                                 });
//                                                 debugPrint("chosen Payment number$chosenPaymentNumber ");
//                                                 // financialPortfoliosModel.chosenPayment = model.items[paymentIndex].name.toString();
//
//                                                 /// stripe
//                                                 // if(financialPortfoliosModel.chosenPayment == allTranslations.text("card")){
//                                                 //   if(userModel.user.currencyName == "ريال يمني" || userModel.user.currencyName == "RY"){
//                                                 //     setState(() {
//                                                 //       isUnsupportedCurrency = true;
//                                                 //     });
//                                                 //     CustomToast.showFlutterToast(
//                                                 //         context: context,
//                                                 //         message: allTranslations.text('unsupportedCurrency')
//                                                 //     );
//                                                 //   }else {
//                                                 //
//                                                 //     pushScreen(context,   StripePaymentScreen(
//                                                 //       orderTotal: total.toStringAsFixed(2),
//                                                 //       currency: userModel.user.currencyName.toString(),
//                                                 //     ));
//                                                 //
//                                                 //
//                                                 //   }
//                                                 //
//                                                 //   // await payPalModel.loginPayPal();
//                                                 // }
//
//                                                 /// paypal
//                                                 if (chosenPaymentNumber == payPalNumber) {
//                                                   if(userModel.user.currencyName == "دولار إمريكي" || userModel.user.currencyName == "USD"){
//                                                     // LoadingDialog().showSimpleDialog(context);
//                                                     CustomLoadingDialog.showLoading(context);
//                                                     await payPalModel.loginPayPal();
//                                                     await payPalModel.payPal(
//                                                       auth: payPalModel.accessToken,
//                                                       total: total.round().toString(),
//                                                     );
//                                                       debugPrint("login payPal auth = ${payPalModel.accessToken}");
//                                                       debugPrint("href = ${payPalModel.href}");
//                                                     if(payPalModel.href != ""){
//                                                       CustomLoadingDialog.hideLoading(context);
//                                                       CustomDialog.showCustomDialog(
//                                                         context: context,
//                                                         barrierDismissible: false,
//                                                         title: allTranslations.text("paypalInstructions"),
//                                                         icon: const Icon(
//                                                           Icons.info_outline_rounded,
//                                                           size: 90,
//                                                           color: Colors.grey,
//                                                         ),
//                                                         description: Text(
//                                                           allTranslations.text("instructions"),
//                                                           textAlign: TextAlign.center,
//                                                           style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                                                               fontWeight: FontWeight.bold
//                                                           ),
//                                                         ),
//                                                         withYesButton: true,
//                                                         withActions: true,
//                                                         withNoButton: true,
//                                                         onPressed: () async{
//                                                           _launchURL(payPalModel.href, "لا يمكن الوصول الى الموقع");
//                                                           CustomLoadingDialog.hideLoading(context);
//                                                           Future.delayed(const Duration(seconds: 10) , (){
//                                                             CustomDialog.showCustomDialog(
//                                                               context: context,
//                                                               barrierDismissible: true,
//                                                               title: allTranslations.text("enterPayerId"),
//                                                               description: CustomTextFormField(
//                                                                 controller: payerController,
//                                                                 keyboardType: TextInputType.number,
//                                                                 textInputAction: TextInputAction.done,
//                                                                 hintText:  allTranslations.text("enterPayerId"),
//                                                                 textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
//                                                                     fontFamily: "cairo"
//                                                                 ),
//                                                                 hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
//                                                                     fontFamily: "cairo"
//                                                                 ),
//                                                                 contentPadding: EdgeInsets.symmetric(vertical: 10.h , horizontal: 10.w),
//                                                                 // validator: (v) {
//                                                                 //   if (v.length == 0) {
//                                                                 //     return allTranslations.text('fieldRequired');
//                                                                 //   }
//                                                                 //   return null;
//                                                                 // },
//                                                                 onFieldSubmitted: () {
//                                                                   FocusScope.of(context).unfocus();
//                                                                 },
//                                                               ),
//                                                               withYesButton: true,
//                                                               withActions: true,
//                                                               onPressed: () async{
//                                                                 CustomLoadingDialog.showLoading(context);
//                                                                 await payPalModel.executePayPal(
//                                                                     auth: payPalModel.accessToken,
//                                                                     payerId: payerController.text
//                                                                 );
//                                                                 if(payPalModel.message != "Requested resource ID was not found."){
//                                                                   await sendRequest(context , cartModel , userModel , discountVolume! , requestModel , billProvider , aramexProvider);
//                                                                   CustomLoadingDialog.hideLoading(context);
//                                                                 }else {
//                                                                   CustomLoadingDialog.hideLoading(context);
//                                                                   CustomLoadingDialog.hideLoading(context);
//                                                                   CustomDialog.showCustomDialog(
//                                                                     context: context,
//                                                                     barrierDismissible: false,
//                                                                     title: allTranslations.text("alert"),
//                                                                     description: Text(
//                                                                       payPalModel.message,
//                                                                       textAlign: TextAlign.center,
//                                                                       style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                                                                           fontWeight: FontWeight.bold
//                                                                       ),
//                                                                     ),
//                                                                     withYesButton: true,
//                                                                     withActions: true,
//                                                                     onPressed: ()  {
//                                                                       CustomLoadingDialog.hideLoading(context);
//                                                                     },
//                                                                   );
//                                                                 }
//                                                               },
//                                                             );
//                                                           });
//                                                         },
//                                                       );
//                                                     }
//
//                                                   }else {
//                                                     setState(() {
//                                                       isUnsupportedCurrency = true;
//                                                     });
//                                                     CustomToast.showFlutterToast(
//                                                         context: context,
//                                                         message: allTranslations.text('unsupportedCurrency')
//                                                     );
//                                                   }
//
//                                                 }
//
//
//                                                 /// tap payment
//                                                 else if (chosenPaymentNumber == cardPaymentNumber){
//
//                                                   if(userModel.user.currencyName == "ريال يمني" || userModel.user.currencyName == "RY"){
//                                                     setState(() {
//                                                       isUnsupportedCurrency = true;
//                                                     });
//                                                     CustomToast.showFlutterToast(
//                                                         context: context,
//                                                         message: allTranslations.text('unsupportedCurrency')
//                                                     );
//                                                   }else {
//                                                     debugPrint("tap amount $total === currency ${userModel.shortcutCurrency}");
//                                                     CustomLoadingDialog.showLoading(context);
//                                                     tapPaymentModel.createCharge(
//                                                         amount: total.toStringAsFixed(2).toString(),
//                                                         currency: userModel.shortcutCurrency
//                                                     ).then((value) {
//                                                       if(tapPaymentModel.tapId != ''){
//                                                         // _launchURL(tapPaymentModel.transactionUrl, "لا يمكن الوصول الى الموقع");
//                                                         showModalBottomSheet(
//                                                           context: context,
//                                                           isScrollControlled: true,
//                                                           enableDrag: false,
//                                                           shape:  RoundedRectangleBorder(
//                                                             borderRadius: BorderRadius.vertical(
//                                                                 top: Radius.circular(AppConstants.defaultBorderRadius.w)
//                                                             ),
//                                                           ),
//                                                           builder: (context) => CheckoutBottomSheet(
//                                                               checkoutUrl: tapPaymentModel.transactionUrl
//                                                           ),
//                                                         );
//                                                         CustomLoadingDialog.hideLoading(context);
//                                                       }else {
//                                                         CustomLoadingDialog.hideLoading(context);
//                                                         CustomDialog.showCustomDialog(
//                                                           context: context,
//                                                           barrierDismissible: false,
//                                                           title: tapPaymentModel.errorDescription,
//                                                           icon: Lottie.asset(
//                                                             AppLottie.error,
//                                                             width: 100.w,
//                                                             height: 100.h,
//                                                             repeat: false,
//                                                           ),
//                                                           withYesButton: true,
//                                                           withActions: true,
//                                                           onPressed: () async{
//                                                             CustomDialog.hideCustomDialog(context);
//                                                           },
//                                                         );
//                                                       }
//                                                     });
//                                                   }
//                                                 }
//                                               },
//                                               child: Container(
//                                                   width: 100.w,
//                                                   padding: EdgeInsets.all(5.w),
//                                                   decoration: BoxDecoration(
//                                                       borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                                                       color: themeModel.darkTheme == true
//                                                           ? Colors.grey[300]
//                                                           : Theme.of(context).primaryColor,
//                                                       border: Border.all(
//                                                           width: 3.w,
//                                                           color: paymentIndex == index
//                                                               ? Theme.of(context).accentColor
//                                                               : Theme.of(context).backgroundColor
//                                                       )
//                                                   ),
//                                                   child:  Column(
//                                                     children: [
//                                                       ClipRRect(
//                                                         borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                                                         child: CustomCachedNetworkImage(
//                                                           imageUrl: model.items[index].imagePath100.toString(),
//                                                           fit: BoxFit.contain,
//                                                           width: 30.w,
//                                                           height: 30.h,
//                                                         ),
//                                                       ),
//                                                       10.ph,
//                                                       Text(
//                                                         model.items[index].name.toString(),
//                                                         textAlign: TextAlign.center,
//                                                         maxLines: 1,
//                                                         overflow: TextOverflow.ellipsis,
//                                                         style: Theme.of(context).textTheme.caption!.copyWith(
//                                                             color: Theme.of(context).textTheme.bodyText1?.color
//                                                         ),
//                                                       ),
//
//                                                     ],
//                                                   )
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//
//                             },
//                           ),
//
//                           15.ph,
//
//                           chosenPaymentNumber == walletNumber
//                               ? getStateOfWalletBalanceWidget()
//                               : 0.ph,
//
//
//
//                           /// bill details
//                           Container(
//                             width: size.width,
//                             padding: EdgeInsets.all(5.0.w),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                               color: Theme.of(context).primaryColor,
//                             ),
//
//                             child: Padding(
//                               padding:  EdgeInsets.all(10.0.w),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     allTranslations.text("billDetails"),
//                                     style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                                         fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//
//                                   15.ph,
//
//                                   /// items count
//                                   CustomTowText(
//                                     title: allTranslations.text("itemsCount"),
//                                     titleStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
//                                         fontWeight: FontWeight.bold
//                                     ),
//                                     subTitle : cartList.length.toString(),
//                                     subTitleStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
//                                         fontFamily: "cairo"
//                                     ),
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   ),
//                                   15.ph,
//
//                                   const Divider(),
//
//                                   /// total
//                                   CustomTowText(
//                                     title: "${allTranslations.text("total")}: ",
//                                     titleStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
//                                         fontWeight: FontWeight.bold
//                                     ),
//                                     subWidget: Row(
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           "${cartModel.totalPrice}",
//                                           style: Theme.of(context).textTheme.subtitle2!.copyWith(
//                                               fontFamily: "cairo"
//                                           ),
//                                         ),
//                                         5.pw,
//                                         Center(
//                                           child: Text(
//                                             "${userModel.user.currencyName}",
//                                             style: Theme.of(context).textTheme.subtitle2!.copyWith(
//                                                 fontFamily: "cairo",
//                                                 fontSize: 10.sp
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   ),
//                                   15.ph,
//                                   const Divider(),
//
//                                   /// shipping fee
//
//                                   CustomTowText(
//                                     title: "${allTranslations.text("shippingFee")}: ",
//                                     titleStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
//                                         fontWeight: FontWeight.bold
//                                     ),
//
//                                     subWidget: Row(
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           deliveryPrice.toString() != "0.0"
//                                               ? deliveryPrice.toString()
//                                               : allTranslations.text("freeDeliver"),
//                                           style: Theme.of(context).textTheme.subtitle2!.copyWith(
//                                               fontFamily: "cairo"
//                                           ),
//                                         ),
//                                         5.pw,
//                                         Center(
//                                           child: Text(
//                                             deliveryPrice.toString() == "0.0"
//                                                 ? ""
//                                                 : "${userModel.user.currencyName}",
//                                             style: Theme.of(context).textTheme.subtitle2!.copyWith(
//                                                 fontFamily: "cairo",
//                                                 fontSize: 10.sp
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   ),
//                                   15.ph,
//                                   const Divider(),
//
//
//
//                                   /// tax fee
//
//                                   if (taxModel.items.isEmpty)
//                                     0.ph
//                                   else if(taxModel.isLoading || taxModel.loadingFailed)
//                                     const CircularLoading()
//                                   else if (userModel.loadingFailed || userModel.isLoading)
//                                       const CircularLoading()
//                                     else if (taxModel.taxPrice.price == "0.00")
//                                         0.ph
//                                       else if (userModel.user.countryId == taxModel.taxPrice.countryId)
//                                           Column(
//                                             mainAxisAlignment: MainAxisAlignment.start,
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Padding(
//                                                 padding:  EdgeInsets.only(bottom: 15.0.h),
//                                                 child: CustomTowText(
//                                                   title: "${allTranslations.text("taxFee")}  " " ${taxModel.taxPrice.price} %",
//                                                   titleStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
//                                                       fontWeight: FontWeight.bold,
//                                                       fontFamily: "cairo"
//                                                   ),
//
//                                                   subWidget: Row(
//                                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                                     mainAxisAlignment: MainAxisAlignment.center,
//                                                     children: [
//                                                       Text(
//                                                         tax.toStringAsFixed(2),
//                                                         style: Theme.of(context).textTheme.subtitle2!.copyWith(
//                                                             fontFamily: "cairo"
//                                                         ),
//                                                       ),
//                                                       5.pw,
//                                                       Center(
//                                                         child: Text(
//                                                           "${userModel.user.currencyName}",
//                                                           style: Theme.of(context).textTheme.subtitle2!.copyWith(
//                                                               fontFamily: "cairo",
//                                                               fontSize: 10.sp
//                                                           ),
//                                                         ),
//                                                       )
//                                                     ],
//                                                   ),
//
//                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                 ),
//                                               ),
//                                               const Divider(),
//                                             ],
//                                           ),
//
//
//
//
//
//
//                                   /// coupon
//                                   couponPrice == 0.0
//                                       ? 0.ph
//                                       : CustomTowText(
//                                     title: "${allTranslations.text("coupon")}: ",
//                                     titleStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
//                                         fontWeight: FontWeight.bold
//                                     ),
//                                     subWidget: Row(
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           couponType == "price"
//                                               ? "$couponPrice"
//                                               : ("${couponPrice.round()} %" ).toString(),
//                                           style: Theme.of(context).textTheme.subtitle2!.copyWith(
//                                               fontFamily: "cairo"
//                                           ),
//                                         ),
//                                         5.pw,
//                                         Center(
//                                           child: Text(
//                                             "${userModel.user.currencyName}",
//                                             style: Theme.of(context).textTheme.subtitle2!.copyWith(
//                                                 fontFamily: "cairo",
//                                                 fontSize: 10.sp
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//
//                                     subTitleStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
//                                         fontFamily: "cairo"
//                                     ),
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   ),
//
//                                   15.ph,
//
//                                   couponPrice == 0.0
//                                       ? 0.ph
//                                       : const Divider(),
//
//                                   /// discount
//
//                                   if(discountModel.isLoading || discountModel.loadingFailed)
//                                     const Align(alignment: Alignment.centerLeft, child:   CircularLoading(),)
//                                   else if (discountVolume != null && discountVolume.type == "balance"
//                                       && chosenPaymentNumber == walletNumber)
//                                     Column(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         CustomTowText(
//                                           title: chosenPaymentNumber == walletNumber && discountVolume.type.toString() == "balance"
//                                               ? "${allTranslations.text("discountOfBalance")}:"
//                                               : discountVolume.type.toString() == "minimum"
//                                               ? "${allTranslations.text("discount")}:"
//                                               : discountVolume.type.toString() == "delivery"
//                                               ? "${allTranslations.text("discountOfDeliver")}:"
//                                               : "${allTranslations.text("discount")}:",
//                                           titleStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
//                                               fontWeight: FontWeight.bold
//                                           ),
//                                           subWidget : calculationDiscount(context),
//                                           subTitleStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
//                                               fontFamily: "cairo"
//                                           ),
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         ),
//                                         const Divider()
//                                       ],
//                                     )
//                                   else if(discountVolume != null && discountVolume.type != "balance")
//                                       Column(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           CustomTowText(
//                                             title:  discountVolume.type.toString() == "minimum"
//                                                 ? "${allTranslations.text("discount")}:"
//                                                 : discountVolume.type.toString() == "delivery"
//                                                 ? "${allTranslations.text("discountOfDeliver")}:"
//                                                 : "${allTranslations.text("discount")}:",
//                                             titleStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
//                                                 fontWeight: FontWeight.bold
//                                             ),
//                                             subWidget : calculationDiscount(context),
//                                             subTitleStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
//                                                 fontFamily: "cairo"
//                                             ),
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           ),
//                                           const Divider()
//                                         ],
//                                       ),
//
//
//
//                                   15.ph,
//
//
//                                   /// amount to be Paid
//                                   CustomTowText(
//                                     title: "${allTranslations.text("amountToBePaid")}: ",
//                                     titleStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
//                                         fontWeight: FontWeight.bold
//                                     ),
//                                     subWidget: Row(
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           total.toStringAsFixed(2),
//                                           style: Theme.of(context).textTheme.subtitle2!.copyWith(
//                                               fontFamily: "cairo"
//                                           ),
//                                         ),
//                                         5.pw,
//                                         Center(
//                                           child: Text(
//                                             "${userModel.user.currencyName}",
//                                             style: Theme.of(context).textTheme.subtitle2!.copyWith(
//                                                 fontFamily: "cairo",
//                                                 fontSize: 10.sp
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   ),
//                                   15.ph,
//
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//
//
//
//
//               /// confirm button
//               bottomNavigationBar:  userModel.isLoading || userModel.loadingFailed
//                   ? const BillShimmer()
//                   : Padding(
//                 padding:  EdgeInsets.all(10.0.w),
//                 child: isUnsupportedCurrency == true
//                     ? CustomButtons(
//                     height: 45.h,
//                     text: allTranslations.text("confirmPurchase"),
//                     buttonColor: Colors.grey
//                 )
//                     : CustomButtons(
//                   height: 45.h,
//                   text: allTranslations.text("confirmPurchase"),
//                   isLoading : isLoading,
//                   buttonColor: Theme.of(context).secondaryHeaderColor,
//                   onTap: () async{
//                     if(connection.hasConnection){
//                       if(chosenPaymentNumber == walletNumber && total > double.parse(userWalletModel.userCurrentBalance.currentBalance.toString())){
//                         return CustomToast.showFlutterToast(
//                             context: context,
//                             message: allTranslations.text("noEnoughBalance")
//                         );
//                       }
//                       else if(chosenPaymentNumber == payPalNumber && (payPalModel.message == "Requested resource ID was not found." || payPalModel.message == "")){
//                         return CustomToast.showFlutterToast(
//                             context: context,
//                             message: allTranslations.text("paymentNotComplete")
//                         );
//                       }
//
//                       else if(chosenPaymentNumber == cardPaymentNumber){
//                         CustomLoadingDialog.showLoading(context);
//                         tapPaymentModel.getRetrieveCharge().then((value) {
//                           if(tapPaymentModel.chargeId != '' && tapPaymentModel.tapId != ''){
//                             CustomLoadingDialog.hideLoading(context);
//                             if(tapPaymentModel.chargeId == tapPaymentModel.tapId && tapPaymentModel.chargeStatus == "CAPTURED"){
//                               setState((){
//                                 isLoading = true;
//                               });
//
//                               /// send request
//                                sendRequest(context , cartModel , userModel , discountVolume! , requestModel , billProvider , aramexProvider);
//                             }else {
//                               return CustomToast.showFlutterToast(
//                                   context: context,
//                                   message: allTranslations.text("paymentNotComplete")
//                               );
//                             }
//                           }else {
//                             return CustomToast.showFlutterToast(
//                                 context: context,
//                                 message: allTranslations.text("errorOccurred")
//                             );
//                           }
//                         });
//
//                       }
//                       else{
//                         setState((){
//                           isLoading = true;
//                         });
//
//                         /// send request
//                         await sendRequest(context , cartModel , userModel , discountVolume! , requestModel , billProvider , aramexProvider);
//                       }
//
//                     }
//                     else {
//                       CustomToast.showFlutterToast(
//                         context: context,
//                         message: allTranslations.text("networkConnection"),
//                         toastLength: Toast.LENGTH_LONG,
//                       );
//                     }
//                   },
//                 ),
//               )
//
//           )
//               : Scaffold(
//             backgroundColor: Theme.of(context).backgroundColor,
//             appBar: PreferredSize(
//               preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
//               child: const CustomAppBar(),
//             ),
//             body: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Center(
//                     child: CustomMessage(
//                       appLottieIcon: AppLottie.noConnection,
//                       message: allTranslations.text("networkConnection"),
//                     ))
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget getStateOfWalletBalanceWidget() {
//
//     return Consumer<UserModel>(builder: (context, model, child) {
//       var userWalletModel = Provider.of<UserWalletModel>(context);
//       var cartProvider = Provider.of<CartModel>(context);
//       var userBalance;
//       model.isLoaded
//           ? userWalletModel.items.isEmpty
//           ? userBalance = "0.0"
//           : userBalance = userWalletModel.userCurrentBalance.currentBalance
//           : userBalance = 0.0;
//       var sumOfCart;
//       cartProvider.isLoaded
//           ? sumOfCart =  total
//           : sumOfCart = 0.0;
//       return userWalletModel.isLoading || userWalletModel.loadingFailed
//           ? const CircularLoading()
//           :  CustomCardIconText(
//         color: double.parse(userBalance) >= sumOfCart
//             ? AppColors.green
//             : AppColors.red,
//         icon: Icons.wallet,
//         backIconColor: Colors.white24,
//         iconColor: Colors.white,
//         height: 40.h,
//         width: 45.w,
//         secondWidget: Text(
//             userWalletModel.items.isEmpty
//                 ? "0.0"
//                 : userWalletModel.userCurrentBalance.currentBalance.toString(),
//             style: Theme.of(context).textTheme.headline2!.copyWith(
//                 fontWeight: FontWeight.bold,
//                 fontFamily: "cairo"
//             )
//         ),
//         itemsName: double.parse(userBalance) >= sumOfCart
//             ? allTranslations.text('enoughBalance')
//             : allTranslations.text('noEnoughBalance'),
//         itemsNameStyle: Theme.of(context).textTheme.headline1,
//       );
//     });
//   }
//
//
//   _launchURL(url, msg) async {
//     if (await canLaunchUrl(Uri.parse(url))) {
//       await launchUrl(Uri.parse(url));
//     } else {
//       throw msg;
//     }
//   }
//
//
//   void _calculateDeliveryPrice(CartModel cartModel, NewDeliveryPriceModel newDeliveryPriceModel) {
//     if (newDeliveryPriceModel.isLoading || newDeliveryPriceModel.loadingFailed) {
//        const CircularLoading();
//     }else {
//       final minimumDeliveryPrice = double.parse(newDeliveryPriceModel.newDeliveryPrice.minimum.toString());
//       final fixedDeliveryRate = double.parse(newDeliveryPriceModel.newDeliveryPrice.fixedDeliveryRate.toString());
//
//       // setState(() {
//         deliveryPrice = cartModel.totalPrice.round() <= minimumDeliveryPrice ? fixedDeliveryRate : 0.0;
//       // });
//     }
//
//   }
//
//   void _calculateTaxAndTotalAmount(CartModel cartModel, TaxModel taxModel) {
//     if (taxModel.items.isNotEmpty) {
//       final taxPrice = double.parse(taxModel.taxPrice.price.toString());
//       tax = (cartModel.totalPrice + deliveryPrice) * (taxPrice / 100);
//       // setState(() {
//         amountToBePaid = cartModel.totalPrice + deliveryPrice + tax;
//       // });
//     } else {
//       // setState(() {
//         amountToBePaid = cartModel.totalPrice + deliveryPrice;
//       // });
//     }
//   }
//
//   void _applyCouponDiscounts(CartModel cartModel) {
//     if (couponType == "price") {
//       total = (amountToBePaid - couponPrice).clamp(0.0, double.infinity);
//     } else {
//       total = (amountToBePaid - (amountToBePaid * (couponPrice / 100))).clamp(0.0, double.infinity);
//     }
//
//     if (cartModel.items.isNotEmpty && cartModel.items[0].insurance_rate != "0.0" && cartModel.items[0].insurance_rate != null) {
//       final insuranceRate = double.parse(cartModel.items[0].insurance_rate);
//       total = (amountToBePaid - (amountToBePaid * (insuranceRate / 100))).clamp(0.0, double.infinity);
//     }
//
//     couponDiscount = amountToBePaid - total;
//   }
//
//   void _applyDiscountVolume(DiscountModel discountModel, CartModel cartModel) {
//     DiscountVolume? discountVolume;
//
//     for (final item in discountModel.items) {
//       if (item.priceTo.isEmpty) {
//         if (double.parse(item.priceFrom) <= total) {
//           discountVolume = _getBetterDiscount(discountVolume, item);
//         }
//       } else {
//         if (amountToBePaid >= double.parse(item.priceFrom) && amountToBePaid < double.parse(item.priceTo)) {
//           discountVolume = _getBetterDiscount(discountVolume, item);
//         }
//       }
//     }
//
//     if (discountVolume != null && cartModel.items.isNotEmpty) {
//       _applyDiscountBasedOnType(discountVolume, cartModel);
//     }
//   }
//
//   DiscountVolume _getBetterDiscount(DiscountVolume? current, DiscountVolume newItem) {
//     if (current == null || double.parse(current.priceFrom.toString()) < double.parse(newItem.priceFrom.toString())) {
//       return newItem;
//     }
//     return current;
//   }
//
//   void _applyDiscountBasedOnType(DiscountVolume discountVolume, CartModel cartModel) {
//     if (discountVolume.valueType == "price" && discountVolume.type == "minimum") {
//       total = (amountToBePaid - double.parse(discountVolume.value.toString())).clamp(0.0, double.infinity);
//     } else if (discountVolume.valueType == "percentage" && discountVolume.type == "minimum") {
//       total = (amountToBePaid - (amountToBePaid * (double.parse(discountVolume.value.toString()) / 100))).clamp(0.0, double.infinity);
//     } else if (discountVolume.valueType == "price" && discountVolume.type == "balance" && chosenPaymentNumber == walletNumber) {
//       total = (amountToBePaid - double.parse(discountVolume.value.toString())).clamp(0.0, double.infinity);
//     } else if (discountVolume.valueType == "percentage" && discountVolume.type == "balance" && chosenPaymentNumber == walletNumber) {
//       total = (amountToBePaid - (amountToBePaid * (double.parse(discountVolume.value.toString()) / 100))).clamp(0.0, double.infinity);
//     } else if (discountVolume.valueType == "price" && discountVolume.type == "delivery" && chosenPaymentNumber == cashNumber) {
//       total = _applyDeliveryDiscount(discountVolume, cartModel);
//     } else if (discountVolume.valueType == "percentage" && discountVolume.type == "delivery" && chosenPaymentNumber == cashNumber) {
//       deliveryPriceAfterDiscount = (deliveryPrice - (deliveryPrice * (double.parse(discountVolume.value.toString()) / 100))).clamp(0.0, double.infinity);
//     }
//   }
//
//   double _applyDeliveryDiscount(DiscountVolume discountVolume, CartModel cartModel) {
//     if (cartModel.items[0].currency == "ريال يمني") {
//       return (amountToBePaid - double.parse(discountVolume.value.toString())).clamp(0.0, double.infinity);
//     } else {
//       deliveryPriceAfterDiscount = (deliveryPrice - double.parse(discountVolume.value.toString())).clamp(0.0, double.infinity);
//       return amountToBePaid - deliveryPriceAfterDiscount;
//     }
//   }
//
//   Future<void> sendRequest(BuildContext context , CartModel cartModel , UserModel userModel ,
//       DiscountVolume discountVolume , RequestModel requestModel , BillProvider billProvider, AramexProvider aramexProvider) async {
//     debugPrint("Send delivery price: $deliveryPrice");
//     debugPrint("Charge ID: ${SharedPrefsService.getString("CHARGE_ID")}");
//     debugPrint("Cart items before send: ${cartModel.items}");
//     Request request;
//     CartList cartList = CartList(items: List<CartItem>.from(cartModel.items));
//     cartStatus = await cartModel.sendCart(cartList);
//
//     if (cartModel.isLoaded) {
//       cartId = cartStatus["cart_id"];
//         debugPrint("******** cart id $cartId");
//
//        request = Request(
//         countryId: userModel.user.countryId,
//         currency: userModel.countryCurrencyId.toString(),
//         deliveryPricing: deliveryPrice.toString(),
//         paymentType: chosenPaymentNumber,
//         receivingType: "internal",
//         cartId: cartId.toString(),
//         couponNumber: couponText.toString().isEmpty ? "" : couponText,
//         discountid: discountVolume.id.toString(),
//         requestNote: noteController.text,
//         address_id: chosenLocationId ?? currentLocationId,
//         deliverLocationId: deliveryPriceId.isEmpty ? "4" : deliveryPriceId,
//         deliveryPriceId: deliveryPriceId,
//         bookingDate: DateTime.now().toString(),
//         chargeId: SharedPrefsService.getString("CHARGE_ID"),
//       );
//
//       final returnOfRequest = await requestModel.addNewRequest(request);
//       debugPrint(returnOfRequest);
//
//       if (requestModel.isLoaded) {
//         setState(() => isLoading = false);
//         await _showSuccessDialog(context , cartModel , billProvider);
//       } else {
//         await _showErrorDialog(context , requestModel , cartModel);
//       }
//     }
//   }
//
//   Future<void> _showSuccessDialog(BuildContext context , CartModel cartModel , BillProvider billProvider)  async {
//      CustomDialog.showCustomDialog(
//       context: context,
//       barrierDismissible: false,
//       title: allTranslations.text("requestSent"),
//       icon: Lottie.asset(
//         AppLottie.checkMark,
//         width: 100.w,
//         height: 100.h,
//         repeat: false,
//       ),
//       withYesButton: true,
//       withActions: true,
//       onPressed: () async {
//         await cartModel.deleteAll().then((_) {
//           pushScreenReplacement(context, const LastOrdersScreen(isFromBill: true));
//           // Reset shipping details manually
//           billProvider.selectedShippingType = '';
//           chosenLocationId = null;
//           currentLocationId = null;
//           billProvider.selectedMinute = '';
//           billProvider.selectedDate = '';
//           billProvider.selectedHour = '';
//           CustomDialog.hideCustomDialog(context);
//         });
//         await cartModel.loadData();
//       },
//     );
//   }
//
//   Future<void> _showErrorDialog(BuildContext context , RequestModel requestModel , CartModel cartModel) async {
//      CustomDialog.showCustomDialog(
//       context: context,
//       barrierDismissible: true,
//       title: allTranslations.text("requestSentFailed"),
//       icon: Lottie.asset(
//         AppLottie.error,
//         width: 100.w,
//         height: 100.h,
//         repeat: false,
//       ),
//       description: Text(
//         requestModel.errors["message"].toString(),
//         textAlign: TextAlign.center,
//         style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
//       ),
//       withActions: true,
//       withYesButton: true,
//       onPressed: () => CustomDialog.hideCustomDialog(context),
//     );
//
//     setState(() => isLoading = false);
//     debugPrint(requestModel.errors.toString());
//     await cartModel.loadData();
//   }
// }

import 'package:alalamia_spices/app/core/utils/constants.dart';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/data/providers/shipping/aramex_provider.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/module/bill/provider/bill_provider.dart';
import 'package:alalamia_spices/app/module/bill/widget/bill_shimmer.dart';
import 'package:alalamia_spices/app/module/bill/widget/checkou_bottom_sheet.dart';
import 'package:alalamia_spices/app/module/check_out/widget/index.dart';
import 'package:alalamia_spices/app/module/start/start.dart';
import 'package:alalamia_spices/app/module/user/last_orders/last_orders_screen.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/values/app_colors.dart';
import '../../core/values/app_lottie.dart';
import '../../data/model/aramex_shipment.dart';
import '../../data/model/request.dart';
import '../check_out/widget/location_details.dart';
import 'package:alalamia_spices/app/exports/model.dart';

Widget? text;
bool? checkState;

class BillScreen extends StatelessWidget {
  final String? shippingType;
  final double? aramexDeliveryPrice;
  final ShipmentData shipmentData;
  const BillScreen(
      {super.key,
      this.shippingType,
      this.aramexDeliveryPrice,
      required this.shipmentData});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TaxModel(context)),
          ChangeNotifierProvider(create: (context) => DiscountModel(context)),
          ChangeNotifierProvider(
              create: (context) => FinancialPortfoliosModel(context)),
          ChangeNotifierProvider(create: (context) => RequestModel(context)),
          ChangeNotifierProvider(create: (context) => CouponModel(context)),
          ChangeNotifierProvider(
              create: (context) => NewDeliveryPriceModel(context)),
          ChangeNotifierProvider(create: (context) => PayPalModel(context)),
          ChangeNotifierProvider(create: (context) => UserModel(context)),
          ChangeNotifierProvider(create: (context) => UserWalletModel(context)),
          ChangeNotifierProvider(
              create: (context) => CeilingPriceModel(context)),
          ChangeNotifierProvider(create: (context) => BillProvider()),
          ChangeNotifierProvider(create: (context) => TapModel(context)),
          ChangeNotifierProvider(create: (context) => AramexProvider()),
        ],
        child: SubBillScreen(
          shippingType: shippingType.toString(),
          aramexDeliveryPrice: aramexDeliveryPrice ?? 0.0,
          shipmentData: shipmentData,
        ));
  }
}

class SubBillScreen extends StatefulWidget {
  final String shippingType;
  final double aramexDeliveryPrice;
  final ShipmentData shipmentData;
  const SubBillScreen(
      {super.key,
      required this.shippingType,
      required this.aramexDeliveryPrice,
      required this.shipmentData});

  @override
  State<SubBillScreen> createState() => _SubBillScreenState();
}

class _SubBillScreenState extends State<SubBillScreen> {
  late TextEditingController noteController;
  late TextEditingController couponController;
  late TextEditingController payerController;
  double deliveryPrice = 0.0;
  String deliveryPriceId = "";
  double amountToBePaid = 0.0;
  var cartStatus;
  // String? cartId;
  int? cartId;
  bool isLoading = false;
  bool isCouponCheck = false;
  // String? branchId ;
  double couponPrice = 0.0;
  String? couponType;
  String? couponText;
  String? error;
  String? status;
  double couponDiscount = 0.0;
  double discount = 0.0;
  double total = 0.0;
  double tax = 0.0;
  double deliveryPriceAfterDiscount = 0.0;
  int paymentIndex = 0;
  var returnOfRequest;
  bool isUnsupportedCurrency = false;
  // String chosenPayment = allTranslations.text("receipt");
  String? chosenPaymentNumber = "2";
  String walletNumber = "1";
  String cashNumber = "2";
  String payPalNumber = "3";
  String cardPaymentNumber = "4";

  @override
  void initState() {
    super.initState();
    noteController = TextEditingController();
    couponController = TextEditingController();
    payerController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    noteController.dispose();
    couponController.dispose();
    // payerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final cartModel = Provider.of<CartModel>(context);
    final taxModel = Provider.of<TaxModel>(context);
    final userModel = Provider.of<UserModel>(context)..getUserInfo();
    final userWalletModel = Provider.of<UserWalletModel>(context);
    final newDeliveryPriceModel = Provider.of<NewDeliveryPriceModel>(context);
    final requestModel = Provider.of<RequestModel>(context);
    final discountModel = Provider.of<DiscountModel>(context);
    final financialPortfoliosModel =
        Provider.of<FinancialPortfoliosModel>(context);
    final themeModel = Provider.of<ThemeModel>(context);
    final payPalModel = Provider.of<PayPalModel>(context);
    final billProvider = Provider.of<BillProvider>(context);
    final tapPaymentModel = Provider.of<TapModel>(context);
    final aramexProvider = Provider.of<AramexProvider>(context);
    DiscountVolume? discountVolume;
    var cartList =
        cartModel.items.where((element) => element.isPaidAdd == false).toList();

    try {
      if (newDeliveryPriceModel.isLoading || taxModel.isLoading) {
        const CircularLoading();
      } else {
        if (widget.shippingType == allTranslations.text("aramex")) {
          setState(() {
            deliveryPrice = widget.aramexDeliveryPrice;
          });
        } else {
          if (cartModel.totalPrice.round() <=
              double.parse(
                  newDeliveryPriceModel.newDeliveryPrice.minimum.toString())) {
            setState(() {
              deliveryPrice = double.parse(newDeliveryPriceModel
                  .newDeliveryPrice.fixedDeliveryRate
                  .toString());
            });
          } else {
            setState(() {
              deliveryPrice = double.parse("0.0");
            });
          }
        }
        if (taxModel.items.isNotEmpty) {
          tax =
              ((double.parse(cartModel.totalPrice.toString()) + deliveryPrice) *
                  (double.parse(taxModel.taxPrice.price.toString()) / 100));
          setState(() {
            amountToBePaid = double.parse(cartModel.totalPrice.toString()) +
                deliveryPrice +
                double.parse(tax.toString());
          });
        } else {
          setState(() {
            amountToBePaid =
                double.parse(cartModel.totalPrice.toString()) + deliveryPrice;
          });
        }
      }
    } catch (error) {
      if (kDebugMode) {
        debugPrint("NewDeliveryPrice bill screen error $error");
      }
    }

    Future sendRequest() async {
      if (kDebugMode) {
        print("send delivery price ===== $deliveryPrice");
      }
      Request request;
      CartList cartList = CartList(items: List<CartItem>.from(cartModel.items));
      cartStatus = await cartModel.sendCart(cartList);

      if (cartModel.isLoaded) {
        // cartId = cartID;
        cartId = cartStatus["cart_id"];
        if (kDebugMode) {
          print("******** cart id $cartId");
        }
        request = Request(
            countryId: userModel.user.countryId,
            currency: userModel.countryCurrencyId.toString(),
            deliveryPricing: deliveryPrice.toString(),
            paymentType: chosenPaymentNumber,
            receivingType: "internal",
            cartId: cartId.toString(),
            couponNumber: couponText.toString().isEmpty ? "" : couponText,
            discountid: discountVolume?.id,
            requestNote: noteController.text,
            address_id: chosenLocationId ?? currentLocationId,
            deliverLocationId: deliveryPriceId == "" ? "4" : deliveryPriceId,
            deliveryPriceId: deliveryPriceId,
            bookingDate: DateTime.now().toString(),
            chargeId: SharedPrefsService.getString("CHARGE_ID"));
        returnOfRequest = await requestModel.addNewRequest(request);
        if (kDebugMode) {
          print("return of request: $returnOfRequest");
        }

        if (requestModel.isLoaded) {
          if (widget.shippingType == allTranslations.text("aramex")) {
            try {
              await aramexProvider
                  .createShipment(widget.shipmentData)
                  .then((value) {
                aramexProvider.sendAramexData(
                    requestNumber: requestModel.requestNumber,
                    aramexId: aramexProvider.shipmentId);
              });
              debugPrint("ui request number: ${requestModel.requestNumber}");
              debugPrint("ui shipment id: ${aramexProvider.shipmentId}");
            } catch (e) {
              // Handle any errors that occur during the process
              debugPrint('Error send aramex data: $e');
            }
          }
          setState(() {
            isLoading = false;
          });

          CustomDialog.showCustomDialog(
            context: context,
            barrierDismissible: false,
            title: allTranslations.text("requestSent"),
            icon: Lottie.asset(
              AppLottie.checkMark,
              width: 100.w,
              height: 100.h,
              repeat: false,
            ),
            withYesButton: true,
            withActions: true,
            onPressed: () async {
              for (int i = 0; i < cartList.items!.length; i++) {
                await cartModel.delete(
                    cartList.items![i], cartList.items![i].type!);
              }
              billProvider.selectedShippingType = '';
              chosenLocationId = null;
              currentLocationId = null;
              billProvider.selectedMinute = '';
              billProvider.selectedDate = '';
              billProvider.selectedHour = '';
              CustomDialog.hideCustomDialog(context);
              await cartModel.loadData();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const StartScreen()),
                  (route) => false);
              pageController.jumpToPage(2);
            },
          );
        } else {
          if (requestModel.errors.isNotEmpty) {
            CustomDialog.showCustomDialog(
                context: context,
                barrierDismissible: true,
                title: allTranslations.text("requestSentFailed"),
                icon: Lottie.asset(
                  AppLottie.error,
                  width: 100.w,
                  height: 100.h,
                  repeat: false,
                ),
                description: Text(
                  requestModel.errors["message"].toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                withActions: true,
                withYesButton: true,
                onPressed: () {
                  CustomDialog.hideCustomDialog(context);
                });

            setState(() {
              isLoading = false;
            });
            if (kDebugMode) {
              print(requestModel.errors);
              print(requestModel.errors["message"].toString());
            }
            await cartModel.loadData();
          }
        }
      }
    }

    // this if condition check the type of coupon price or percentage
    if (cartModel.items.isNotEmpty) {
      if (cartModel.isLoaded) {
        if (couponType == "price") {
          total = (amountToBePaid - couponPrice) < 0
              ? 0.0
              : (amountToBePaid - couponPrice);
        } else {
          total = (amountToBePaid - (amountToBePaid * (couponPrice / 100))) < 0
              ? 0.0
              : (amountToBePaid - (amountToBePaid * (couponPrice / 100)));
        }

        if (cartModel.items.isNotEmpty) {
          if (cartModel.items[0].insurance_rate != "0.0" &&
              cartModel.items[0].insurance_rate != null) {
            total = (amountToBePaid -
                        (amountToBePaid *
                            (double.parse(cartModel.items[0].insurance_rate) /
                                100))) <
                    0
                ? 0.0
                : (amountToBePaid -
                    (amountToBePaid *
                        (double.parse(cartModel.items[0].insurance_rate) /
                            100)));
          }
        }
        couponDiscount = amountToBePaid - total;
      }
    }

    //////////////////////////////////////////////////////////////////

    if (discountModel.items.isNotEmpty) {
      if (discountModel.isLoaded) {
        for (int i = 0; i < discountModel.items.length; i++) {
          if (discountModel.items[i].priceTo == "") {
            if (double.parse(discountModel.items[i].priceFrom) <= total) {
              if (discountVolume == null) {
                discountVolume = discountModel.items[i];
              } else {
                if (double.parse(discountVolume.priceFrom.toString()) <
                    double.parse(discountModel.items[i].priceFrom)) {
                  discountVolume = discountModel.items[i];
                }
              }
              if (kDebugMode) {
                debugPrint(discountVolume!.priceFrom.toString());
              }
            }
          } else {
            if (amountToBePaid >=
                    double.parse(discountModel.items[i].priceFrom) &&
                amountToBePaid < double.parse(discountModel.items[i].priceTo)) {
              if (discountVolume == null) {
                discountVolume = discountModel.items[i];
              } else {
                if (double.parse(discountVolume.priceFrom.toString()) <
                    double.parse(discountModel.items[i].priceFrom)) {
                  discountVolume = discountModel.items[i];
                }
              }
              if (kDebugMode) {
                debugPrint(discountVolume!.priceFrom);
              }
            }
          }
        }
        if (discountVolume != null && cartModel.items.isNotEmpty) {
          if (discountVolume.valueType == "price" &&
              discountVolume.type == "minimum") {
            total = (amountToBePaid -
                        double.parse(discountVolume.value.toString())) <
                    0
                ? 0.0
                : (amountToBePaid -
                    double.parse(discountVolume.value.toString()));
          } else if (discountVolume.valueType != "price" &&
              discountVolume.type == "minimum") {
            total = (amountToBePaid -
                        (amountToBePaid *
                            (double.parse(discountVolume.value.toString()) /
                                100))) <
                    0
                ? 0.0
                : (amountToBePaid -
                    (amountToBePaid *
                        (double.parse(discountVolume.value.toString()) / 100)));
          } else if (discountVolume.valueType == "price" &&
              discountVolume.type == "balance" &&
              chosenPaymentNumber == walletNumber) {
            total = (amountToBePaid -
                        double.parse(discountVolume.value.toString())) <
                    0
                ? 0.0
                : (amountToBePaid -
                    double.parse(discountVolume.value.toString()));
          } else if (discountVolume.valueType == "percentage" &&
              discountVolume.type == "balance" &&
              chosenPaymentNumber == walletNumber) {
            total = (amountToBePaid -
                        (amountToBePaid *
                            (double.parse(discountVolume.value.toString()) /
                                100))) <
                    0
                ? 0.0
                : (amountToBePaid -
                    (amountToBePaid *
                        (double.parse(discountVolume.value.toString()) / 100)));
          } else if (discountVolume.valueType == "price" &&
              discountVolume.type == "delivery" &&
              cartModel.items[0].currency == "ريال يمني" &&
              chosenPaymentNumber == cashNumber) {
            total = (amountToBePaid -
                        double.parse(discountVolume.value.toString())) <
                    0
                ? 0.0
                : double.parse(deliveryPrice.toString()) -
                            double.parse(discountVolume.value.toString()) <
                        0
                    ? total = (amountToBePaid -
                        double.parse(deliveryPrice.toString()))
                    : (amountToBePaid -
                        double.parse(discountVolume.value.toString()));
          } else if (discountVolume.valueType == "percentage" &&
              discountVolume.type == "delivery" &&
              chosenPaymentNumber == cashNumber &&
              cartModel.items[0].currency == "ريال يمني") {
            total = ((double.parse(deliveryPrice.toString()) *
                        (double.parse(discountVolume.value.toString()) /
                            100))) <
                    0
                ? 0.0
                : (amountToBePaid -
                    (double.parse(deliveryPrice.toString()) *
                        (double.parse(discountVolume.value.toString()) / 100)));
          } else if (discountVolume.valueType == "price" &&
              discountVolume.type == "delivery" &&
              chosenPaymentNumber == cashNumber &&
              cartModel.items[0].currency != "ريال يمني") {
            deliveryPriceAfterDiscount =
                (double.parse(deliveryPrice.toString()) -
                            double.parse(discountVolume.value.toString())) <
                        0
                    ? 0.0
                    : double.parse(deliveryPrice.toString()) -
                                double.parse(discountVolume.value.toString()) <
                            0
                        ? deliveryPrice = 0.0
                        : (double.parse(deliveryPrice.toString()) -
                            double.parse(discountVolume.value.toString()));
          } else if (discountVolume.valueType == "percentage" &&
              discountVolume.type == "delivery" &&
              chosenPaymentNumber == cashNumber &&
              cartModel.items[0].currency != "ريال يمني") {
            deliveryPriceAfterDiscount =
                ((double.parse(deliveryPrice.toString()) *
                            (double.parse(discountVolume.value.toString()) /
                                100))) <
                        0
                    ? 0.0
                    : (double.parse(deliveryPrice.toString()) -
                        (double.parse(deliveryPrice.toString()) *
                            (double.parse(discountVolume.value.toString()) /
                                100)));
          }
        }
        discount = amountToBePaid - total;
      }
    }

    Widget calculationDiscount(BuildContext context) {
      Widget? child;

      if (cartModel.items.isNotEmpty) {
        /// discount of balance
        if (discountVolume != null &&
            discountVolume.valueType == "price" &&
            discountVolume.type == "balance" &&
            chosenPaymentNumber == walletNumber) {
          child = Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${discountVolume.value}",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontFamily: "cairo")),
              Center(
                child: Text("${cartModel.items[0].currency}",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontFamily: "cairo", fontSize: 10.sp)),
              ),
            ],
          );
        } else if (discountVolume != null &&
            discountVolume.valueType == "percentage" &&
            discountVolume.type == "balance" &&
            chosenPaymentNumber == walletNumber) {
          child = Text(
              ("${(double.parse(discountVolume.value.toString())).round()} %")
                  .toString(),
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontFamily: "cairo"));
        }

        /// discount of minimum

        if (discountVolume != null &&
            discountVolume.valueType == "price" &&
            discountVolume.type == "minimum") {
          child = Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${discountVolume.value} ",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontFamily: "cairo")),
              Center(
                child: Text("${cartModel.items[0].currency}",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontFamily: "cairo", fontSize: 10.sp)),
              ),
            ],
          );
        } else if (discountVolume != null &&
            discountVolume.valueType == "percentage" &&
            discountVolume.type == "minimum") {
          child = Text(
              ("${(double.parse(discountVolume.value.toString())).round()} %")
                  .toString(),
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontFamily: "cairo"));
        }

        /// discount of delivery

        if (discountVolume != null &&
            discountVolume.valueType == "price" &&
            discountVolume.type == "delivery" &&
            chosenPaymentNumber == cashNumber) {
          child = Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(discountVolume.value.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontFamily: "cairo")),
              5.pw,
              Center(
                child: Text(
                  "${cartModel.items[0].currency}",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontFamily: "cairo", fontSize: 10.sp),
                ),
              )
            ],
          );
        } else if (discountVolume != null &&
            discountVolume.valueType == "percentage" &&
            discountVolume.type == "delivery" &&
            chosenPaymentNumber == cashNumber) {
          child = Text(
              ("${(double.parse(discountVolume.value.toString())).round()} %")
                  .toString(),
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontFamily: "cairo"));
        }
      }

      return Container(child: child);
    }

    try {
      total = amountToBePaid -
          discount -
          couponDiscount -
          deliveryPriceAfterDiscount;
    } catch (e) {
      if (kDebugMode) {
        debugPrint("error bill $e");
      }
    }

    return Consumer<ConnectivityNotifier>(
      builder: (context, connection, child) {
        return SafeArea(
          child: connection.hasConnection
              ? Scaffold(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
                    child: const CustomAppBar(),
                  ),
                  body: ChangeNotifierProvider(
                    create: (context) => UserModel(context),
                    child: Consumer<UserModel>(
                      builder: (context, userModel, child) {
                        userModel.getUserInfo();
                        return userModel.isLoading || userModel.loadingFailed
                            ? const BillShimmer()
                            : Padding(
                                padding: EdgeInsets.all(10.0.w),
                                child: ListView(
                                  children: [
                                    /// coupon details
                                    ChangeNotifierProvider<CouponModel>(
                                      create: (context) => CouponModel(context),
                                      child: Consumer<CouponModel>(
                                        builder: (context, model, child) {
                                          return Container(
                                            padding: EdgeInsets.all(10.0.w),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppConstants
                                                          .defaultBorderRadius
                                                          .w),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextFormFieldWithName(
                                                  controller: couponController,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  hintTextFormField:
                                                      allTranslations
                                                          .text("couponHint"),
                                                  fieldName: allTranslations
                                                      .text("couponDetails"),
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          fontFamily: "cairo"),
                                                  fieldNameStyle:
                                                      Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                  onFieldSubmitted: () {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                  },
                                                ),
                                                10.ph,
                                                couponController.text.isEmpty
                                                    ? 0.ph
                                                    : InkWell(
                                                        onTap: () async {
                                                          if (couponController
                                                              .text
                                                              .isNotEmpty) {
                                                            setState(() {
                                                              isCouponCheck =
                                                                  true;
                                                            });
                                                            if (await model
                                                                .checkNormalCoupon(
                                                              number:
                                                                  couponController
                                                                      .text,
                                                            )) {
                                                              setState(() {
                                                                couponPrice = double
                                                                    .parse(model
                                                                        .coupon
                                                                        .price
                                                                        .toString());
                                                                couponType = model
                                                                    .coupon
                                                                    .valueType;
                                                                couponText =
                                                                    couponController
                                                                        .text;
                                                              });

                                                              CustomDialog
                                                                  .showCustomDialog(
                                                                      context:
                                                                          context,
                                                                      barrierDismissible:
                                                                          true,
                                                                      title: allTranslations
                                                                          .text(
                                                                              "correctCoupon"),
                                                                      description:
                                                                          Text(
                                                                        couponType ==
                                                                                "price"
                                                                            ? "${double.parse(model.coupon.price.toString())}"
                                                                            : "${double.parse(model.coupon.price.toString()).round()} %",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium!
                                                                            .copyWith(
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: "cairo"),
                                                                      ),
                                                                      withActions:
                                                                          true,
                                                                      withYesButton:
                                                                          true,
                                                                      onPressed:
                                                                          () {
                                                                        CustomDialog.hideCustomDialog(
                                                                            context);
                                                                      });

                                                              setState(() {
                                                                isCouponCheck =
                                                                    false;
                                                              });
                                                            } else {
                                                              CustomDialog
                                                                  .showCustomDialog(
                                                                      context:
                                                                          context,
                                                                      barrierDismissible:
                                                                          true,
                                                                      title: allTranslations
                                                                          .text(
                                                                              "errorCoupon"),
                                                                      icon: Lottie
                                                                          .asset(
                                                                        AppLottie
                                                                            .error,
                                                                        width:
                                                                            100.w,
                                                                        height:
                                                                            100.h,
                                                                        repeat:
                                                                            true,
                                                                      ),
                                                                      withActions:
                                                                          true,
                                                                      withYesButton:
                                                                          true,
                                                                      onPressed:
                                                                          () {
                                                                        CustomDialog.hideCustomDialog(
                                                                            context);
                                                                      });

                                                              setState(() {
                                                                couponText = "";
                                                                couponPrice =
                                                                    0.0;
                                                                couponType =
                                                                    "price";
                                                                isCouponCheck =
                                                                    false;
                                                                couponController
                                                                    .clear();
                                                              });
                                                              text = Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    allTranslations
                                                                        .text(
                                                                            "errorCoupon"),
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            "cairo",
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                                  ),
                                                                ],
                                                              );
                                                            }
                                                            setState(() {
                                                              checkState = true;
                                                            });
                                                          }
                                                        },
                                                        child: isCouponCheck ==
                                                                false
                                                            ? CustomButtons(
                                                                text: allTranslations
                                                                    .text(
                                                                        "checkCoupon"),
                                                                buttonColor: Theme.of(
                                                                        context)
                                                                    .secondaryHeaderColor,
                                                              )
                                                            : const CircularLoading(),
                                                      ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),

                                    15.ph,

                                    /// note text filed

                                    Container(
                                      padding: EdgeInsets.all(10.0.w),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(
                                            AppConstants.defaultBorderRadius.w),
                                      ),
                                      child: TextFormFieldWithName(
                                        controller: noteController,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.done,
                                        hintTextFormField:
                                            allTranslations.text("noteHint"),
                                        fieldName: allTranslations.text("note"),
                                        fieldNameStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 20.h, horizontal: 10.w),
                                        // validator: (value){
                                        //
                                        // },
                                        onFieldSubmitted: () {
                                          FocusScope.of(context).unfocus();
                                        },
                                      ),
                                    ),

                                    15.ph,

                                    /// payment method
                                    financialPortfoliosModel.isLoading ||
                                            financialPortfoliosModel
                                                .loadingFailed
                                        ? const CircularLoading()
                                        : Consumer<FinancialPortfoliosModel>(
                                            builder: (context, model, child) {
                                              // model.getFinancialPortfolios();
                                              return Container(
                                                padding: EdgeInsets.all(10.0.w),
                                                height: 140.h,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  borderRadius: BorderRadius
                                                      .circular(AppConstants
                                                          .defaultBorderRadius
                                                          .w),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      allTranslations.text(
                                                          "paymentMethods"),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                    5.ph,
                                                    Flexible(
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        primary: false,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount:
                                                            model.items.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        5.w,
                                                                    vertical:
                                                                        10.h),
                                                            child: InkWell(
                                                              onTap: () async {
                                                                setState(() {
                                                                  paymentIndex =
                                                                      index;
                                                                  isUnsupportedCurrency =
                                                                      false;
                                                                  chosenPaymentNumber = model
                                                                      .items[
                                                                          paymentIndex]
                                                                      .number
                                                                      .toString();
                                                                });
                                                                // financialPortfoliosModel.chosenPayment = model.items[paymentIndex].name.toString();

                                                                /// stripe
                                                                // if(financialPortfoliosModel.chosenPayment == allTranslations.text("card")){
                                                                //   if(userModel.user.currencyName == "ريال يمني" || userModel.user.currencyName == "RY"){
                                                                //     setState(() {
                                                                //       isUnsupportedCurrency = true;
                                                                //     });
                                                                //     CustomToast.showFlutterToast(
                                                                //         context: context,
                                                                //         message: allTranslations.text('unsupportedCurrency')
                                                                //     );
                                                                //   }else {
                                                                //
                                                                //     pushScreen(context,   StripePaymentScreen(
                                                                //       orderTotal: total.toStringAsFixed(2),
                                                                //       currency: userModel.user.currencyName.toString(),
                                                                //     ));
                                                                //
                                                                //
                                                                //   }
                                                                //
                                                                //   // await payPalModel.loginPayPal();
                                                                // }

                                                                /// paypal
                                                                if (chosenPaymentNumber ==
                                                                    payPalNumber) {
                                                                  if (userModel
                                                                              .user
                                                                              .currencyName ==
                                                                          "دولار إمريكي" ||
                                                                      userModel
                                                                              .user
                                                                              .currencyName ==
                                                                          "USD") {
                                                                    // LoadingDialog().showSimpleDialog(context);
                                                                    CustomLoadingDialog
                                                                        .showLoading(
                                                                            context);
                                                                    await payPalModel
                                                                        .loginPayPal();
                                                                    await payPalModel
                                                                        .payPal(
                                                                      auth: payPalModel
                                                                          .accessToken,
                                                                      total: total
                                                                          .round()
                                                                          .toString(),
                                                                    );
                                                                    if (kDebugMode) {
                                                                      debugPrint(
                                                                          "login payPal auth = ${payPalModel.accessToken}");
                                                                      debugPrint(
                                                                          "href = ${payPalModel.href}");
                                                                    }

                                                                    if (payPalModel
                                                                            .href !=
                                                                        "") {
                                                                      CustomLoadingDialog
                                                                          .hideLoading(
                                                                              context);
                                                                      CustomDialog
                                                                          .showCustomDialog(
                                                                        context:
                                                                            context,
                                                                        barrierDismissible:
                                                                            false,
                                                                        title: allTranslations
                                                                            .text("paypalInstructions"),
                                                                        icon:
                                                                            const Icon(
                                                                          Icons
                                                                              .info_outline_rounded,
                                                                          size:
                                                                              90,
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                        description:
                                                                            Text(
                                                                          allTranslations
                                                                              .text("instructions"),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .copyWith(fontWeight: FontWeight.bold),
                                                                        ),
                                                                        withYesButton:
                                                                            true,
                                                                        withActions:
                                                                            true,
                                                                        withNoButton:
                                                                            true,
                                                                        onPressed:
                                                                            () async {
                                                                          _launchURL(
                                                                              payPalModel.href,
                                                                              "لا يمكن الوصول الى الموقع");
                                                                          CustomLoadingDialog.hideLoading(
                                                                              context);
                                                                          Future.delayed(
                                                                              const Duration(seconds: 10),
                                                                              () {
                                                                            CustomDialog.showCustomDialog(
                                                                              context: context,
                                                                              barrierDismissible: true,
                                                                              title: allTranslations.text("enterPayerId"),
                                                                              description: CustomTextFormField(
                                                                                controller: payerController,
                                                                                keyboardType: TextInputType.number,
                                                                                textInputAction: TextInputAction.done,
                                                                                hintText: allTranslations.text("enterPayerId"),
                                                                                textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(fontFamily: "cairo"),
                                                                                hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(fontFamily: "cairo"),
                                                                                contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                                                                                // validator: (v) {
                                                                                //   if (v.length == 0) {
                                                                                //     return allTranslations.text('fieldRequired');
                                                                                //   }
                                                                                //   return null;
                                                                                // },
                                                                                onFieldSubmitted: () {
                                                                                  FocusScope.of(context).unfocus();
                                                                                },
                                                                              ),
                                                                              withYesButton: true,
                                                                              withActions: true,
                                                                              onPressed: () async {
                                                                                CustomLoadingDialog.showLoading(context);
                                                                                await payPalModel.executePayPal(auth: payPalModel.accessToken, payerId: payerController.text);
                                                                                if (payPalModel.message != "Requested resource ID was not found.") {
                                                                                  await sendRequest();
                                                                                  CustomLoadingDialog.hideLoading(context);
                                                                                } else {
                                                                                  CustomLoadingDialog.hideLoading(context);
                                                                                  CustomLoadingDialog.hideLoading(context);
                                                                                  CustomDialog.showCustomDialog(
                                                                                    context: context,
                                                                                    barrierDismissible: false,
                                                                                    title: allTranslations.text("alert"),
                                                                                    description: Text(
                                                                                      payPalModel.message,
                                                                                      textAlign: TextAlign.center,
                                                                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                    withYesButton: true,
                                                                                    withActions: true,
                                                                                    onPressed: () {
                                                                                      CustomLoadingDialog.hideLoading(context);
                                                                                    },
                                                                                  );
                                                                                }
                                                                              },
                                                                            );
                                                                          });
                                                                        },
                                                                      );
                                                                    }
                                                                  } else {
                                                                    setState(
                                                                        () {
                                                                      isUnsupportedCurrency =
                                                                          true;
                                                                    });
                                                                    CustomToast.showFlutterToast(
                                                                        context:
                                                                            context,
                                                                        message:
                                                                            allTranslations.text('unsupportedCurrency'));
                                                                  }
                                                                }

                                                                /// tap payment
                                                                else if (chosenPaymentNumber ==
                                                                    cardPaymentNumber) {
                                                                  if (userModel
                                                                              .user
                                                                              .currencyName ==
                                                                          "ريال يمني" ||
                                                                      userModel
                                                                              .user
                                                                              .currencyName ==
                                                                          "RY") {
                                                                    setState(
                                                                        () {
                                                                      isUnsupportedCurrency =
                                                                          true;
                                                                    });
                                                                    CustomToast.showFlutterToast(
                                                                        context:
                                                                            context,
                                                                        message:
                                                                            allTranslations.text('unsupportedCurrency'));
                                                                  } else {
                                                                    debugPrint(
                                                                        "tap amount $total === currency ${userModel.shortcutCurrency}");
                                                                    CustomLoadingDialog
                                                                        .showLoading(
                                                                            context);
                                                                    tapPaymentModel
                                                                        .createCharge(
                                                                            amount:
                                                                                total.toStringAsFixed(2).toString(),
                                                                            currency: userModel.shortcutCurrency)
                                                                        .then((value) {
                                                                      if (tapPaymentModel
                                                                              .tapId !=
                                                                          '') {
                                                                        // _launchURL(tapPaymentModel.transactionUrl, "لا يمكن الوصول الى الموقع");
                                                                        showModalBottomSheet(
                                                                          context:
                                                                              context,
                                                                          isScrollControlled:
                                                                              true,
                                                                          enableDrag:
                                                                              false,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.vertical(top: Radius.circular(AppConstants.defaultBorderRadius.w)),
                                                                          ),
                                                                          builder: (context) =>
                                                                              CheckoutBottomSheet(checkoutUrl: tapPaymentModel.transactionUrl),
                                                                        );
                                                                        CustomLoadingDialog.hideLoading(
                                                                            context);
                                                                      } else {
                                                                        CustomLoadingDialog.hideLoading(
                                                                            context);
                                                                        CustomDialog
                                                                            .showCustomDialog(
                                                                          context:
                                                                              context,
                                                                          barrierDismissible:
                                                                              false,
                                                                          title:
                                                                              tapPaymentModel.errorDescription,
                                                                          icon:
                                                                              Lottie.asset(
                                                                            AppLottie.error,
                                                                            width:
                                                                                100.w,
                                                                            height:
                                                                                100.h,
                                                                            repeat:
                                                                                false,
                                                                          ),
                                                                          withYesButton:
                                                                              true,
                                                                          withActions:
                                                                              true,
                                                                          onPressed:
                                                                              () async {
                                                                            CustomDialog.hideCustomDialog(context);
                                                                          },
                                                                        );
                                                                      }
                                                                    });
                                                                  }
                                                                }
                                                              },
                                                              child: Container(
                                                                  width: 100.w,
                                                                  padding:
                                                                      EdgeInsets.all(
                                                                          5.w),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(AppConstants
                                                                              .defaultBorderRadius
                                                                              .w),
                                                                      color: themeModel.darkTheme ==
                                                                              true
                                                                          ? Colors.grey[
                                                                              300]
                                                                          : Theme.of(context)
                                                                              .primaryColor,
                                                                      border: Border.all(
                                                                          width: 3
                                                                              .w,
                                                                          color: paymentIndex == index
                                                                              ? Theme.of(context).colorScheme.secondary
                                                                              : Theme.of(context).colorScheme.surface)),
                                                                  child: Column(
                                                                    children: [
                                                                      ClipRRect(
                                                                        borderRadius: BorderRadius.circular(AppConstants
                                                                            .defaultBorderRadius
                                                                            .w),
                                                                        child:
                                                                            CustomCachedNetworkImage(
                                                                          imageUrl: model
                                                                              .items[index]
                                                                              .imagePath100
                                                                              .toString(),
                                                                          fit: BoxFit
                                                                              .contain,
                                                                          width:
                                                                              30.w,
                                                                          height:
                                                                              30.h,
                                                                        ),
                                                                      ),
                                                                      10.ph,
                                                                      Text(
                                                                        model
                                                                            .items[index]
                                                                            .name
                                                                            .toString(),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodySmall!
                                                                            .copyWith(color: Theme.of(context).textTheme.bodyLarge?.color),
                                                                      ),
                                                                    ],
                                                                  )),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),

                                    15.ph,

                                    chosenPaymentNumber == walletNumber
                                        ? getStateOfWalletBalanceWidget()
                                        : 0.ph,

                                    /// bill details
                                    Container(
                                      width: size.width,
                                      padding: EdgeInsets.all(5.0.w),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            AppConstants.defaultBorderRadius.w),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0.w),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              allTranslations
                                                  .text("billDetails"),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),

                                            15.ph,

                                            /// items count
                                            CustomTowText(
                                              title: allTranslations
                                                  .text("itemsCount"),
                                              titleStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                              subTitle:
                                                  cartList.length.toString(),
                                              subTitleStyle: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      fontFamily: "cairo"),
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                            ),
                                            15.ph,

                                            const Divider(),

                                            /// total
                                            CustomTowText(
                                              title:
                                                  "${allTranslations.text("total")}: ",
                                              titleStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                              subWidget: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "${cartModel.totalPrice}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .copyWith(
                                                            fontFamily:
                                                                "cairo"),
                                                  ),
                                                  5.pw,
                                                  Center(
                                                    child: Text(
                                                      "${userModel.user.currencyName}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall!
                                                          .copyWith(
                                                              fontFamily:
                                                                  "cairo",
                                                              fontSize: 10.sp),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                            ),
                                            15.ph,
                                            const Divider(),

                                            /// shipping fee

                                            CustomTowText(
                                              title:
                                                  "${allTranslations.text("shippingFee")}: ",
                                              titleStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                              subWidget: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    deliveryPrice.toString() !=
                                                            "0.0"
                                                        ? deliveryPrice
                                                            .toString()
                                                        : allTranslations.text(
                                                            "freeDeliver"),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .copyWith(
                                                            fontFamily:
                                                                "cairo"),
                                                  ),
                                                  5.pw,
                                                  Center(
                                                    child: Text(
                                                      deliveryPrice
                                                                  .toString() ==
                                                              "0.0"
                                                          ? ""
                                                          : "${userModel.user.currencyName}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall!
                                                          .copyWith(
                                                              fontFamily:
                                                                  "cairo",
                                                              fontSize: 10.sp),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                            ),
                                            15.ph,
                                            const Divider(),

                                            /// tax fee

                                            if (taxModel.items.isEmpty)
                                              0.ph
                                            else if (taxModel.isLoading ||
                                                taxModel.loadingFailed)
                                              const CircularLoading()
                                            else if (userModel.loadingFailed ||
                                                userModel.isLoading)
                                              const CircularLoading()
                                            else if (taxModel.taxPrice.price ==
                                                "0.00")
                                              0.ph
                                            else if (userModel.user.countryId ==
                                                taxModel.taxPrice.countryId)
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 15.0.h),
                                                    child: CustomTowText(
                                                      title:
                                                          "${allTranslations.text("taxFee")}  "
                                                          " ${taxModel.taxPrice.price} %",
                                                      titleStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      "cairo"),
                                                      subWidget: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            tax.toStringAsFixed(
                                                                2),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleSmall!
                                                                .copyWith(
                                                                    fontFamily:
                                                                        "cairo"),
                                                          ),
                                                          5.pw,
                                                          Center(
                                                            child: Text(
                                                              "${userModel.user.currencyName}",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .copyWith(
                                                                      fontFamily:
                                                                          "cairo",
                                                                      fontSize:
                                                                          10.sp),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                    ),
                                                  ),
                                                  const Divider(),
                                                ],
                                              ),

                                            /// coupon
                                            couponPrice == 0.0
                                                ? 0.ph
                                                : CustomTowText(
                                                    title:
                                                        "${allTranslations.text("coupon")}: ",
                                                    titleStyle:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                    subWidget: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          couponType == "price"
                                                              ? "$couponPrice"
                                                              : ("${couponPrice.round()} %")
                                                                  .toString(),
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .titleSmall!
                                                              .copyWith(
                                                                  fontFamily:
                                                                      "cairo"),
                                                        ),
                                                        5.pw,
                                                        Center(
                                                          child: Text(
                                                            "${userModel.user.currencyName}",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleSmall!
                                                                .copyWith(
                                                                    fontFamily:
                                                                        "cairo",
                                                                    fontSize:
                                                                        10.sp),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    subTitleStyle:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .copyWith(
                                                                fontFamily:
                                                                    "cairo"),
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                  ),

                                            15.ph,

                                            couponPrice == 0.0
                                                ? 0.ph
                                                : const Divider(),

                                            /// discount

                                            if (discountModel.isLoading ||
                                                discountModel.loadingFailed)
                                              const Align(
                                                alignment: Alignment.centerLeft,
                                                child: CircularLoading(),
                                              )
                                            else if (discountVolume != null &&
                                                discountVolume.type ==
                                                    "balance" &&
                                                chosenPaymentNumber ==
                                                    walletNumber)
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomTowText(
                                                    title: chosenPaymentNumber ==
                                                                walletNumber &&
                                                            discountVolume.type
                                                                    .toString() ==
                                                                "balance"
                                                        ? "${allTranslations.text("discountOfBalance")}:"
                                                        : discountVolume.type
                                                                    .toString() ==
                                                                "minimum"
                                                            ? "${allTranslations.text("discount")}:"
                                                            : discountVolume
                                                                        .type
                                                                        .toString() ==
                                                                    "delivery"
                                                                ? "${allTranslations.text("discountOfDeliver")}:"
                                                                : "${allTranslations.text("discount")}:",
                                                    titleStyle:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                    subWidget:
                                                        calculationDiscount(
                                                            context),
                                                    subTitleStyle:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .copyWith(
                                                                fontFamily:
                                                                    "cairo"),
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                  ),
                                                  const Divider()
                                                ],
                                              )
                                            else if (discountVolume != null &&
                                                discountVolume.type !=
                                                    "balance")
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomTowText(
                                                    title: discountVolume.type
                                                                .toString() ==
                                                            "minimum"
                                                        ? "${allTranslations.text("discount")}:"
                                                        : discountVolume.type
                                                                    .toString() ==
                                                                "delivery"
                                                            ? "${allTranslations.text("discountOfDeliver")}:"
                                                            : "${allTranslations.text("discount")}:",
                                                    titleStyle:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                    subWidget:
                                                        calculationDiscount(
                                                            context),
                                                    subTitleStyle:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .copyWith(
                                                                fontFamily:
                                                                    "cairo"),
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                  ),
                                                  const Divider()
                                                ],
                                              )
                                            else
                                              0.ph,

                                            15.ph,

                                            /// amount to be Paid
                                            CustomTowText(
                                              title:
                                                  "${allTranslations.text("amountToBePaid")}: ",
                                              titleStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                              subWidget: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    total.toStringAsFixed(2),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .copyWith(
                                                            fontFamily:
                                                                "cairo"),
                                                  ),
                                                  5.pw,
                                                  Center(
                                                    child: Text(
                                                      "${userModel.user.currencyName}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall!
                                                          .copyWith(
                                                              fontFamily:
                                                                  "cairo",
                                                              fontSize: 10.sp),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                            ),
                                            15.ph,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      },
                    ),
                  ),

                  /// confirm button
                  bottomNavigationBar: userModel.isLoading ||
                          userModel.loadingFailed
                      ? const BillShimmer()
                      : Padding(
                          padding: EdgeInsets.all(10.0.w),
                          child: isUnsupportedCurrency == true
                              ? CustomButtons(
                                  height: 45.h,
                                  text: allTranslations.text("confirmPurchase"),
                                  buttonColor: Colors.grey)
                              : CustomButtons(
                                  height: 45.h,
                                  text: allTranslations.text("confirmPurchase"),
                                  isLoading: isLoading,
                                  buttonColor:
                                      Theme.of(context).secondaryHeaderColor,
                                  onTap: () async {
                                    if (connection.hasConnection) {
                                      if (chosenPaymentNumber == walletNumber &&
                                          total >
                                              double.parse(userWalletModel
                                                  .userCurrentBalance
                                                  .currentBalance
                                                  .toString())) {
                                        return CustomToast.showFlutterToast(
                                            context: context,
                                            message: allTranslations
                                                .text("noEnoughBalance"));
                                      } else if (chosenPaymentNumber ==
                                              payPalNumber &&
                                          (payPalModel.message ==
                                                  "Requested resource ID was not found." ||
                                              payPalModel.message == "")) {
                                        return CustomToast.showFlutterToast(
                                            context: context,
                                            message: allTranslations
                                                .text("paymentNotComplete"));
                                      } else if (chosenPaymentNumber ==
                                          cardPaymentNumber) {
                                        CustomLoadingDialog.showLoading(
                                            context);
                                        tapPaymentModel
                                            .getRetrieveCharge()
                                            .then((value) {
                                          if (tapPaymentModel.chargeId != '' &&
                                              tapPaymentModel.tapId != '') {
                                            CustomLoadingDialog.hideLoading(
                                                context);
                                            if (tapPaymentModel.chargeId ==
                                                    tapPaymentModel.tapId &&
                                                tapPaymentModel.chargeStatus ==
                                                    "CAPTURED") {
                                              setState(() {
                                                isLoading = true;
                                              });

                                              /// send request
                                              sendRequest();
                                            } else {
                                              return CustomToast.showFlutterToast(
                                                  context: context,
                                                  message: allTranslations.text(
                                                      "paymentNotComplete"));
                                            }
                                          } else {
                                            return CustomToast.showFlutterToast(
                                                context: context,
                                                message: allTranslations
                                                    .text("errorOccurred"));
                                          }
                                        });
                                      } else {
                                        setState(() {
                                          isLoading = true;
                                        });

                                        /// send request
                                        await sendRequest();
                                      }
                                    } else {
                                      CustomToast.showFlutterToast(
                                        context: context,
                                        message: allTranslations
                                            .text("networkConnection"),
                                        toastLength: Toast.LENGTH_LONG,
                                      );
                                    }
                                  },
                                ),
                        ))
              : Scaffold(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
                    child: const CustomAppBar(),
                  ),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: CustomMessage(
                        appLottieIcon: AppLottie.noConnection,
                        message: allTranslations.text("networkConnection"),
                      ))
                    ],
                  ),
                ),
        );
      },
    );
  }

  Widget getStateOfWalletBalanceWidget() {
    return Consumer<UserModel>(builder: (context, model, child) {
      var userWalletModel = Provider.of<UserWalletModel>(context);
      var cartProvider = Provider.of<CartModel>(context);
      Object? userBalance;
      model.isLoaded
          ? userWalletModel.items.isEmpty
              ? userBalance = "0.0"
              : userBalance = userWalletModel.userCurrentBalance.currentBalance
          : userBalance = 0.0;
      double sumOfCart;
      cartProvider.isLoaded ? sumOfCart = total : sumOfCart = 0.0;
      return userWalletModel.isLoading || userWalletModel.loadingFailed
          ? const CircularLoading()
          : CustomCardIconText(
              color: double.parse(userBalance as String) >= sumOfCart
                  ? AppColors.green
                  : AppColors.red,
              icon: Icons.wallet,
              backIconColor: Colors.white24,
              iconColor: Colors.white,
              height: 40.h,
              width: 45.w,
              secondWidget: Text(
                  userWalletModel.items.isEmpty
                      ? "0.0"
                      : userWalletModel.userCurrentBalance.currentBalance
                          .toString(),
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.bold, fontFamily: "cairo")),
              itemsName: double.parse(userBalance) >= sumOfCart
                  ? allTranslations.text('enoughBalance')
                  : allTranslations.text('noEnoughBalance'),
              itemsNameStyle: Theme.of(context).textTheme.displayLarge,
            );
    });
  }

  _launchURL(url, msg) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw msg;
    }
  }
}
