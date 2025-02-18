// //
// // // In your Flutter app, import the share_plus plugin
// // import 'package:share_plus/share_plus.dart';
// // import 'package:uni_links/uni_links.dart';
// // import 'package:flutter/material.dart';
// //
// //
// //
// //
// // // Define a method to handle the incoming links
// // void handleIncomingLinks(BuildContext context) async {
// //   // Get the initial link
// //   String? initialLink = await getInitialLink();
// //   // Handle the initial link
// //   handleLink(initialLink! , context);
// //   // Listen for link changes
// //   getUriLinksStream().listen((Uri? uri) {
// //     // Handle the link
// //     handleLink(uri.toString() , context);
// //   });
// // }
// //
// // // Define a method to handle a link
// // void handleLink(String link , BuildContext context) {
// //   // Check if the link is valid
// //   if (link != null && link.startsWith('myapp://')) {
// //     // Extract the article id from the link
// //     String articleId = link.substring(link.lastIndexOf('/') + 1);
// //     // Navigate to the article page
// //     Navigator.pushNamed(context, '/article/$articleId');
// //   }
// // }
//
// // import 'package:flutter/material.dart';
// // class CountryPicker extends StatelessWidget {
// //   const CountryPicker({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return StatefulBuilder(
// //       builder: (context , mySetState){
// //         return CustomCardIconText(
// //             color: Theme.of(context).primaryColor,
// //             icon: Icons.language,
// //             iconColor: Colors.grey,
// //             height: 40.h,
// //             width: 45.w,
// //             itemsName: allTranslations.text("country"),
// //             // subItemsName: countryName ?? " ",
// //             secondIcon: Icons.arrow_forward_ios,
// //             secondIconColor: Colors.grey,
// //             onTap: () async {
// //               await showModalBottomSheet(
// //                   context: context,
// //                   elevation: 0.3,
// //                   isScrollControlled: true,
// //                   enableDrag: true,
// //                   shape:  RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.vertical(
// //                         top: Radius.circular(AppConstants.defaultBorderRadius.w)
// //                     ),
// //                   ),
// //                   builder: (context) {
// //                     return StatefulBuilder(
// //                       builder: (context , mySetState) {
// //                         return Padding(
// //                           padding: EdgeInsets.all(10.0.w),
// //                           child: Wrap(
// //                             // spacing: 20.h,
// //                             crossAxisAlignment: WrapCrossAlignment.start,
// //                             runSpacing: 10.0.h,
// //                             runAlignment: WrapAlignment.spaceBetween,
// //                             children: [
// //
// //                               BottomSheetHeader(title: allTranslations.text("country"), subTitle: allTranslations.text("countrySubTitle")),
// //
// //                               countriesModel.isLoading || countriesModel.loadingFailed
// //                                   ? const CircularLoading()
// //                                   : GridView.builder(
// //                                 shrinkWrap: true,
// //                                 scrollDirection: Axis.vertical,
// //                                 gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
// //                                   maxCrossAxisExtent: 180.w,
// //                                   mainAxisExtent: 160.h,
// //                                   // childAspectRatio: 3 / 6,
// //                                   // crossAxisSpacing: 3, // the space between them horizontally
// //                                   // mainAxisSpacing: 3
// //                                 ),
// //                                 itemCount: countriesModel.items.length,
// //                                 itemBuilder: (context , index){
// //                                   return InkWell(
// //                                     onTap: (){
// //                                       mySetState((){
// //                                         selectedCountry = index;
// //                                         countryName = countriesModel.items[selectedCountry].name.toString();
// //                                         countryId = countriesModel.items[selectedCountry].id.toString();
// //                                         countryImage = countriesModel.items[selectedCountry].imagePath.toString();
// //                                         // countriesModel.newCountryName = countriesModel.items[selectedCountry].name;
// //                                         // countriesModel.newCountryId = countriesModel.items[selectedCountry].id.toString();
// //                                         // countriesModel.newCountryImage = countriesModel.items[selectedCountry].imagePath.toString();
// //                                       });
// //                                       setState(() {
// //
// //                                       });
// //                                     },
// //                                     child: Padding(
// //                                       padding:  EdgeInsets.all(10.0.w),
// //                                       child: Container(
// //                                         width: 140.w,
// //                                         height: 140.h,
// //                                         padding: EdgeInsets.all(5.w),
// //                                         decoration: BoxDecoration(
// //                                             borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
// //                                             border: selectedCountry == index
// //                                                 ? Border.all(color: Theme.of(context).colorScheme.secondary , width: 2.w)
// //                                                 : Border.all(color: Colors.grey[400]!)
// //                                         ),
// //                                         child: Column(
// //                                           mainAxisAlignment: MainAxisAlignment.center,
// //                                           crossAxisAlignment: CrossAxisAlignment.center,
// //                                           children: [
// //                                             CustomCachedNetworkImage(
// //                                               imageUrl: countriesModel.items[index].imagePath,
// //                                               width: 70.w,
// //                                               height: 70.h,
// //                                               errorImageHeight: 30.h,
// //                                               errorImageWidth: 30.w,
// //                                             ),
// //                                             10.ph,
// //
// //                                             Text(
// //                                               countriesModel.items[index].name.toString(),
// //                                               // countriesModel.items[index].name.toString(),
// //                                               style: Theme.of(context).textTheme.bodyLarge!.copyWith(
// //                                                   fontWeight: FontWeight.bold
// //                                               ),
// //                                             )
// //                                           ],
// //                                         ),
// //                                       ),
// //                                     ),
// //                                   );
// //                                 },
// //                               ),
// //
// //                               20.ph,
// //
// //                               CustomButtons(
// //                                 height: 45.h,
// //                                 text: allTranslations.text("save"),
// //                                 buttonColor: countryId != ""
// //                                     ? Theme.of(context).secondaryHeaderColor
// //                                     : Colors.grey,
// //                                 onTap: countryId != ""
// //                                     ? ()  async{
// //                                   setState(()  {
// //                                     // countriesModel.newCountryName = countriesModel.items[selectedCountry].name;
// //                                     // countriesModel.newCountryId = countriesModel.items[selectedCountry].id.toString();
// //                                     // countriesModel.newCountryImage = countriesModel.items[selectedCountry].imagePath.toString();
// //                                     saveCountryDetails(
// //                                         id: countryId.toString(),
// //                                         name: countryName.toString(),
// //                                         image: countryImage.toString()
// //                                     );
// //
// //
// //                                   });
// //                                   await Provider.of<UserWalletModel>(context , listen: false).loadData(context);
// //                                   await cartModel.deleteAll();
// //                                   await cartModel.loadData(context);
// //                                   await MaterialAppWithTheme.restartApp(context);
// //                                   Navigator.of(context).pop();
// //                                 }
// //                                     : () {
// //                                   CustomToast.showFlutterToast(
// //                                       context: context,
// //                                       message: allTranslations.text("chooseCountryHintTxt")
// //                                   );
// //                                 },
// //                               )
// //                             ],
// //                           ),
// //                         );
// //                       },
// //                     );
// //                   });
// //
// //             }
// //         );
// //       } ,
// //     ),;
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'app/data/providers/ceiling_price_model.dart';
// import 'app/data/providers/coupon_model.dart';
// import 'app/data/providers/delivery_pricing/new_delivery_price_model.dart';
// import 'app/data/providers/discount_model.dart';
// import 'app/data/providers/payment/financial_portfolios_model.dart';
// import 'app/data/providers/payment/payPal_model.dart';
// import 'app/data/providers/payment/tap_model.dart';
// import 'app/data/providers/request_model.dart';
// import 'app/data/providers/tax_price_model.dart';
// import 'app/data/providers/userModel.dart';
// import 'app/data/providers/user_wallet_model.dart';
// import 'app/global_widgets/custom_toast.dart';
// import 'app/module/bill/provider/bill_provider.dart';
//
// class BillScreen extends StatelessWidget {
//   final String? shippingType;
//
//   const BillScreen({
//     Key? key,
//     this.shippingType
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//         providers: _buildProviders(context),
//         child: SubBillScreen(
//           shippingType: shippingType.toString(),
//         )
//     );
//   }
//
//   List<ChangeNotifierProvider> _buildProviders(BuildContext context) {
//     return [
//       ChangeNotifierProvider(create: (context) => TaxModel(context)),
//       ChangeNotifierProvider(create: (context) => DiscountModel(context)),
//       ChangeNotifierProvider(create: (context) => FinancialPortfoliosModel(context)),
//       ChangeNotifierProvider(create: (context) => RequestModel(context)),
//       ChangeNotifierProvider(create: (context) => CouponModel(context)),
//       ChangeNotifierProvider(create: (context) => NewDeliveryPriceModel(context)),
//       ChangeNotifierProvider(create: (context) => PayPalModel(context)),
//       ChangeNotifierProvider(create: (context) => UserModel(context)),
//       ChangeNotifierProvider(create: (context) => UserWalletModel(context)),
//       ChangeNotifierProvider(create: (context) => CeilingPriceModel(context)),
//       ChangeNotifierProvider(create: (context) => BillProvider()),
//       ChangeNotifierProvider(create: (context) => TapModel(context)),
//     ];
//   }
// }
// class SubBillScreen extends StatefulWidget {
//   final String shippingType;
//
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
//   late final BillController _billController;
//   late final PaymentController _paymentController;
//
//   @override
//   void initState() {
//     super.initState();
//     _billController = BillController();
//     _paymentController = PaymentController();
//   }
//
//   @override
//   void dispose() {
//     _billController.dispose();
//     _paymentController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ConnectivityNotifier>(
//         builder: (context, connection, child) {
//           return SafeArea(
//               child: connection.hasConnection
//                   ? _buildMainContent()
//                   : const NoConnectionView()
//           );
//         }
//     );
//   }
//
//   Widget _buildMainContent() {
//     return Scaffold(
//       backgroundColor: Theme.of(context).backgroundColor,
//       appBar: const CustomAppBar(),
//       body: _buildBody(),
//       bottomNavigationBar: _buildBottomBar(),
//     );
//   }
//
//   Widget _buildBody() {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: EdgeInsets.all(AppSpacing.screenPadding),
//         child: Column(
//           children: [
//             _buildCouponSection(),
//             _buildNoteSection(),
//             _buildPaymentMethodSection(),
//             _buildWalletBalanceSection(),
//             _buildBillDetailsSection(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCouponSection() {
//     return BillCard(
//       child: Column(
//         children: [
//           CouponTextField(
//             controller: _billController.couponController,
//             onSubmitted: _billController.validateCoupon,
//           ),
//           if (_billController.isCouponValid)
//             CouponDetails(coupon: _billController.coupon)
//         ],
//       ),
//     );
//   }
//
//   Widget _buildNoteSection() {
//     return BillCard(
//       child: NoteTextField(
//         controller: _billController.noteController,
//       ),
//     );
//   }
//
//   Widget _buildPaymentMethodSection() {
//     return BillCard(
//       child: PaymentMethodSelector(
//         selectedMethod: _paymentController.selectedMethod,
//         onMethodSelected: _paymentController.selectPaymentMethod,
//       ),
//     );
//   }
//
//   Widget _buildWalletBalanceSection() {
//     if (!_paymentController.isWalletPayment) return const SizedBox.shrink();
//
//     return BillCard(
//       child: WalletBalance(
//         balance: _billController.walletBalance,
//         total: _billController.total,
//       ),
//     );
//   }
//
//   Widget _buildBillDetailsSection() {
//     return BillCard(
//       child: BillDetails(
//         billData: _billController.billData,
//       ),
//     );
//   }
//
//   Widget _buildBottomBar() {
//     return SafeArea(
//       child: Padding(
//         padding: EdgeInsets.all(AppSpacing.screenPadding),
//         child: ConfirmButton(
//           onPressed: _handleConfirmation,
//           isLoading: _billController.isLoading,
//         ),
//       ),
//     );
//   }
//
//   Future<void> _handleConfirmation() async {
//     if (!_validatePayment()) return;
//
//     await _billController.processPurchase(
//       paymentMethod: _paymentController.selectedMethod,
//     );
//   }
//
//   bool _validatePayment() {
//     if (!_paymentController.validatePayment()) {
//       CustomToast.show(
//           message: allTranslations.text('paymentNotComplete')
//       );
//       return false;
//     }
//     return true;
//   }
// }
// class BillController extends ChangeNotifier {
//   final TextEditingController noteController = TextEditingController();
//   final TextEditingController couponController = TextEditingController();
//
//   BillData _billData = BillData();
//   bool _isLoading = false;
//   Coupon? _coupon;
//
//   bool get isLoading => _isLoading;
//   BillData get billData => _billData;
//   Coupon? get coupon => _coupon;
//
//   Future<void> validateCoupon(String code) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       _coupon = await CouponService.validate(code);
//       _billData = _billData.copyWith(
//           couponDiscount: _calculateCouponDiscount()
//       );
//     } catch (e) {
//       _coupon = null;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<void> processPurchase({
//     required PaymentMethod paymentMethod
//   }) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       await PaymentService.process(
//           billData: _billData,
//           paymentMethod: paymentMethod
//       );
//
//       await _createOrder();
//
//     } catch (e) {
//       CustomToast.show(message: e.toString());
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   @override
//   void dispose() {
//     noteController.dispose();
//     couponController.dispose();
//     super.dispose();
//   }
// }
// class BillData {
//   final double subtotal;
//   final double tax;
//   final double shipping;
//   final double discount;
//   final double couponDiscount;
//   final double total;
//
//   BillData({
//     this.subtotal = 0,
//     this.tax = 0,
//     this.shipping = 0,
//     this.discount = 0,
//     this.couponDiscount = 0,
//     this.total = 0,
//   });
//
//   BillData copyWith({
//     double? subtotal,
//     double? tax,
//     double? shipping,
//     double? discount,
//     double? couponDiscount,
//     double? total,
//   }) {
//     return BillData(
//       subtotal: subtotal ?? this.subtotal,
//       tax: tax ?? this.tax,
//       shipping: shipping ?? this.shipping,
//       discount: discount ?? this.discount,
//       couponDiscount: couponDiscount ?? this.couponDiscount,
//       total: total ?? this.total,
//     );
//   }
// }
// class BillCard extends StatelessWidget {
//   final Widget child;
//
//   const BillCard({
//     Key? key,
//     required this.child,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: AppSpacing.medium),
//       padding: EdgeInsets.all(AppSpacing.medium),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
//       ),
//       child: child,
//     );
//   }
// }
