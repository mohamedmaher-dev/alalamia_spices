//
// import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
// import 'package:alalamia_spices/app/data/model/financial_portfolios_model.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
//
// import '../../../data/model/translations.dart';
// import '../../../global_widgets/circular_loading.dart';
// import '../../../global_widgets/custom_buttons.dart';
// import '../../../global_widgets/custom_card_icon_text.dart';
// import '../../../global_widgets/custom_drop_down.dart';
// import '../../../global_widgets/custom_two_text.dart';
//
// String? chosenPayment;
// class PaymentMethods extends StatefulWidget {
//   const PaymentMethods({Key? key}) : super(key: key);
//
//   @override
//   State<PaymentMethods> createState() => _PaymentMethodsState();
// }
//
// class _PaymentMethodsState extends State<PaymentMethods> {
//   // String? chosenPayment;
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<FinancialPortfoliosModel>(
//       create: (context) => FinancialPortfoliosModel(context),
//       child: Consumer<FinancialPortfoliosModel>(
//         builder: (context , model , child){
//           model.getFinancialPortfolios();
//           return  model.isLoading || model.loadingFailed
//               ? const CircularLoading()
//               : CustomCardIconText(
//               icon: CupertinoIcons.money_euro,
//               iconColor: Colors.grey,
//               itemsName: allTranslations.text("paymentDetails"),
//               subItemsName: chosenPayment,
//               secondIcon: Icons.arrow_forward_ios,
//               secondIconColor: Colors.grey,
//               onTap: () async{
//                 await showModalBottomSheet(
//                     context: context,
//                     elevation: 0.3,
//                     isScrollControlled: false,
//                     enableDrag: true,
//                     shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.vertical(
//                           top: Radius.circular(AppConstants.defaultBorderRadius.w)
//                       ),
//                     ),
//                     builder: (context) {
//                       return StatefulBuilder(
//                         builder: (context , mySetState){
//                           return Padding(
//                             padding: EdgeInsets.all(10.0.w),
//                             child: Wrap(
//                               crossAxisAlignment: WrapCrossAlignment.start,
//                               runSpacing: 10.0.h,
//                               runAlignment: WrapAlignment.spaceBetween,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 10.0.w),
//                                   child: CustomTowText(
//                                     title: allTranslations.text("paymentDetails"),
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     titleStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 22.sp
//
//                                     ),
//                                     subWidget: Padding(
//                                       padding:  EdgeInsets.symmetric(horizontal: 5.0.w),
//                                       child: InkWell(
//                                         onTap: (){
//                                           Navigator.of(context).pop();
//                                         },
//                                         child: Icon(
//                                           Icons.close,
//                                           size: 30,
//                                           color: Theme.of(context).secondaryHeaderColor,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 3.ph,
//                                 Text(
//                                   allTranslations.text("paymentSubTitle"),
//                                   style: Theme.of(context).textTheme.caption!.copyWith(
//                                       fontWeight: FontWeight.bold
//                                   ),
//                                 ),
//                                 20.ph,
//
//                                 CustomDropDown(
//                                     listItem: model.financialItems,
//                                     value: model.currentFinancial.toString(),
//                                     hintText: allTranslations.text("paymentMethods"),
//                                     onChanged: (value){
//                                       mySetState((){
//                                         chosenPayment = value;
//                                         model.currentFinancial = value;
//                                       });
//                                       setState(() {
//
//                                       });
//                                     }
//                                 ),
//
//                                 20.ph,
//
//                                 CustomButtons(
//                                   height: 40.h,
//                                   text: allTranslations.text("save"),
//                                   buttonColor: Theme.of(context).secondaryHeaderColor,
//                                   onTap: (){
//                                     Navigator.of(context).pop();
//                                   },
//                                 )
//                               ],
//                             ),
//                           );
//                         },
//                       );
//                     });
//               }
//           );
//         },
//       ),
//     );
//   }
// }
