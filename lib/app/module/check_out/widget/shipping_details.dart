// import 'package:alalamia_spices/app/core/utils/constants.dart';
// import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
// import 'package:alalamia_spices/app/global_widgets/circular_loading.dart';
// import 'package:alalamia_spices/app/global_widgets/custom_text_form_field.dart';
// import 'package:alalamia_spices/app/module/check_out/services/shipping_type_provider.dart';
// import 'package:alalamia_spices/app/module/check_out/widget/index.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../data/model/translations.dart';
// import '../../../global_widgets/custom_drop_down.dart';
// import 'package:intl/intl.dart' as intel;
//
// import '../check_out_screen.dart';
//
//
//
// // int currentIndex = 1;
// class ShippingDetails extends StatefulWidget {
//    const ShippingDetails({Key? key}) : super(key: key);
//
//   @override
//   State<ShippingDetails> createState() => _ShippingDetailsState();
// }
//
// class _ShippingDetailsState extends State<ShippingDetails> {
//   bool isShippingHidden = false;
//   late TextEditingController dateController;
//   late TextEditingController hourController;
//   late TextEditingController minuteController;
//   ShippingTypeModel shippingTypeModel = ShippingTypeModel();
//   late String  currentShippingType;
//   int _currentIndex = 1;
//   DateTime _selectedDateValue = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
//   bool _showTitle = true;
//   DateTimePickerLocale _locale = DateTimePickerLocale.en_us;
//   String _format = 'yyyy-MMMM-dd';
//   final  List<RadioGroup> _radioOptionGroup = [
//     RadioGroup(
//       text: allTranslations.text('freeShipping'),
//       index: 1,
//     ),
//     RadioGroup(
//       text: allTranslations.text('conditionShipping'),
//       index: 2,
//     ),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     dateController  = TextEditingController();
//     hourController  = TextEditingController();
//     minuteController  = TextEditingController();
//     currentShippingType = allTranslations.text("internalRequest");
//   }
//
//
//   @override
//   void dispose() {
//     super.dispose();
//     dateController.dispose();
//     hourController.dispose();
//     minuteController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     shippingTypeModel.getShippingList();
//
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//
//         Container(
//           width: MediaQuery.of(context).size.width,
//           padding: EdgeInsets.all(10.0.w),
//           decoration: BoxDecoration(
//             borderRadius: const BorderRadius.only(
//               bottomRight: Radius.circular(AppConstants.defaultBorderRadius.w),
//               bottomLeft: Radius.circular(AppConstants.defaultBorderRadius.w),
//             ),
//             color: Theme.of(context).primaryColor,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 allTranslations.text("shippingType"),
//                 style: Theme.of(context).textTheme.bodyMedium!,
//               ),
//               15.ph,
//
//               shippingTypeModel.shippingItems.isEmpty
//               ? const CircularLoading()
//               : CustomDropDown(
//                   listItem:  shippingTypeModel.shippingItems,
//                   value: currentShippingType,
//                   hintText: allTranslations.text("internalRequest"),
//                   fillColor: Theme.of(context).primaryColor,
//                   onChanged: (value) {
//                     setState(() {
//                       currentShippingType = value;
//                       selectedShippingType = currentShippingType;
//                     });
//                   }
//               ),
//
//             ],
//           ),
//         ),
//
//
//         /// free or conditions
//         currentShippingType == allTranslations.text("internalRequest")
//         ? Container(
//           width: MediaQuery.of(context).size.width,
//           padding: EdgeInsets.all(10.0.w),
//           decoration: BoxDecoration(
//             borderRadius: const BorderRadius.only(
//               bottomRight: Radius.circular(AppConstants.defaultBorderRadius.w),
//               bottomLeft: Radius.circular(AppConstants.defaultBorderRadius.w),
//             ),
//             color: Theme.of(context).primaryColor,
//           ),
//           child: Container(
//               padding: EdgeInsets.all(10.0.w),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                   color:  Theme.of(context).backgroundColor
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: _radioOptionGroup
//                     .map((item) => Container(
//                   width: 150.w,
//                   alignment: Alignment.center,
//                   // padding: EdgeInsets.all(5.0.w),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                       color: item.index == _currentIndex
//                           ?  Theme.of(context).colorScheme.secondary
//                           : Theme.of(context).backgroundColor
//                   ),
//                   child: Row(
//                     children: <Widget>[
//                       Radio(
//                         groupValue: _currentIndex,
//                         value: item.index,
//                         onChanged: (val) {
//                           setState(() {
//                             shippingType = val == 1 ? 'freeShipping' : 'conditionShipping';
//                             _currentIndex = val!;
//                           });
//                           // print(currentIndex);
//                         },
//                         activeColor: item.index == _currentIndex
//                             ? Theme.of(context).backgroundColor
//                             : Theme.of(context).secondaryHeaderColor,
//                       ),
//                       Text(
//                         item.text,
//                         style: item.index == _currentIndex
//                             ? Theme.of(context).textTheme.caption!.copyWith(
//                             color: Theme.of(context).primaryColor
//                         )
//                             : Theme.of(context).textTheme.caption,
//                       ),
//                     ],
//                   ),
//                 ))
//                     .toList(),
//               )
//           ),
//         )
//         : 0.ph,
//
//
//         /// date
//         // if it is free show the message we will contact you soon else show the date and time
//         _currentIndex == 1
//         ? Container(
//           width: MediaQuery.of(context).size.width,
//           padding: EdgeInsets.all(20.0.h),
//           decoration: BoxDecoration(
//             borderRadius: const BorderRadius.only(
//               bottomRight: Radius.circular(AppConstants.defaultBorderRadius.w),
//               bottomLeft: Radius.circular(AppConstants.defaultBorderRadius.w),
//             ),
//             color: Theme.of(context).primaryColor,
//           ),
//           child: Center(
//             child: Text(
//               allTranslations.text("freeShippingMessage"),
//               style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                 fontWeight: FontWeight.bold
//               ),
//             ),
//           ),
//         )
//         : Container(
//           width: MediaQuery.of(context).size.width,
//           padding: EdgeInsets.all(10.0.w),
//           decoration: BoxDecoration(
//             borderRadius: const BorderRadius.only(
//               bottomRight: Radius.circular(AppConstants.defaultBorderRadius.w),
//               bottomLeft: Radius.circular(AppConstants.defaultBorderRadius.w),
//             ),
//             color: Theme.of(context).primaryColor,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 allTranslations.text("shippingDate"),
//                 style: Theme.of(context).textTheme.bodyMedium!,
//               ),
//               15.ph,
//
//               InkWell(
//                 onTap: (){
//                   DatePicker.showDatePicker(
//                     context,
//                     pickerTheme: DateTimePickerTheme(
//
//                       showTitle: _showTitle,
//                       confirm: Text(
//                           allTranslations.text("agree"),
//                           style: Theme.of(context).textTheme.bodyMedium!!.copyWith(
//                               fontWeight: FontWeight.bold
//                           )
//                       ),
//                       cancel:Text(
//                           allTranslations.text("cancel"),
//                           style: Theme.of(context).textTheme.bodyMedium!!.copyWith(
//                               fontWeight: FontWeight.bold
//                           )
//                       ),
//                     ),
//                     minDateTime: DateTime(_selectedDateValue.year),
//                     maxDateTime: DateTime(_selectedDateValue.year, 13),
//                     initialDateTime: DateTime(_selectedDateValue.year, _selectedDateValue.month, _selectedDateValue.day),
//                     dateFormat: _format,
//                     locale: _locale,
//                     onClose: () => print("----- onClose -----"),
//                     onCancel: () => print('onCancel'),
//                     onChange: (dateTime, List<int> index) {},
//                     onConfirm: (dateTime, List<int> index) {
//                       setState(() {
//                         dateController.text = intel.DateFormat("yyyy-MM-dd").format(dateTime.toLocal());
//                         _selectedDateValue = dateTime;
//                         selectedDate = dateController.text;
//                       });
//                       if (kDebugMode) {
//                         print("*********** $dateController");
//                       }
//                     },
//                   );
//                 },
//                 child: Container(
//                   height: 50.h,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                       border: Border.all(color: Colors.grey[400]!)
//                   ),
//                   child: Center(
//                     child: Text(
//                       dateController.text == ""
//                         ? allTranslations.text("date")
//                         : dateController.text,
//                       textAlign: TextAlign.right,
//                       style: Theme.of(context).textTheme.caption!.copyWith(
//                         fontFamily: "cairo",
//                         fontWeight: FontWeight.bold
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               15.ph,
//               Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: CustomTextFormField(
//                           maxLines: 1,
//                           controller: minuteController,
//                           keyboardType: TextInputType.number,
//                           textInputAction: TextInputAction.done,
//                           hintText: allTranslations.text("minute"),
//                           hintStyle: Theme.of(context).textTheme.caption!.copyWith(
//                               fontFamily: "cairo"
//                             ),
//                           contentPadding: EdgeInsets.symmetric(vertical: 10.h , horizontal: 10.w),
//                           textStyle: Theme.of(context).textTheme.caption!.copyWith(
//                             fontFamily: "cairo",
//                             fontWeight: FontWeight.bold
//                           ),
//                           inputFormatters: [
//                             // ignore: deprecated_member_use
//                             FilteringTextInputFormatter.allow(
//                                 RegExp('^[1-5]?[0-9]\$'))
//                           ],
//                         validator: (v) {
//                           if (v.length == 0){
//
//                             return allTranslations
//                                 .text('fieldRequired');
//                           }
//
//
//                           return null;
//                         },
//                         onChanged: (value){
//                           setState(() {
//                             minuteController.text = value;
//                             selectedMinute = minuteController.text;
//                           });
//                         },
//                       ),
//                     ),
//                     10.pw,
//                     Expanded(
//                       child: CustomTextFormField(
//                           maxLines: 1,
//                           controller: hourController,
//                           keyboardType: TextInputType.number,
//                           textInputAction: TextInputAction.done,
//                           hintText: allTranslations.text("hour"),
//                           hintStyle: Theme.of(context).textTheme.caption!.copyWith(
//                               fontFamily: "cairo"
//                           ),
//                           contentPadding: EdgeInsets.symmetric(vertical: 10.h , horizontal: 10.w),
//                           textStyle: Theme.of(context).textTheme.caption!.copyWith(
//                               fontFamily: "cairo",
//                               fontWeight: FontWeight.bold
//                           ),
//                           inputFormatters: [
//                             FilteringTextInputFormatter.allow(RegExp("^(2[0-4]|1[0-9]|[1-9])\$")),
//                           ],
//                         validator: (v) {
//                           if (v.length == 0){
//
//                             return allTranslations
//                                 .text('fieldRequired');
//                           }
//                           return null;
//                         },
//                         onChanged: (value){
//                             setState(() {
//                               hourController.text = value;
//                               selectedHour = hourController.text;
//                             });
//                         },
//                         // onFieldSubmitted: (){
//                         //
//                         // },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               15.ph,
//
//             ],
//           ),
//         ),
//
//
//       ],
//     );
//   }
//
//    void _toggleShipping() {
//      setState(() {
//        isShippingHidden = !isShippingHidden;
//      });
//    }
// }
//
//
// // class RadioButton extends StatefulWidget {
// //   RadioButton({Key? key}) : super(key: key);
// //
// //   _RadioButtonState createState() => _RadioButtonState();
// // }
// //
// // class _RadioButtonState extends State<RadioButton> {
// //
// //   int _currentIndex = 1;
// //   final  List<RadioGroup> _radioOptionGroup = [
// //     RadioGroup(
// //       text: allTranslations.text('freeShipping'),
// //       index: 1,
// //     ),
// //     RadioGroup(
// //       text: allTranslations.text('conditionShipping'),
// //       index: 2,
// //     ),
// //   ];
// //   @override
// //   Widget build(BuildContext context) {
// //
// //     return Row(
// //       mainAxisSize: MainAxisSize.max,
// //       mainAxisAlignment: MainAxisAlignment.spaceAround,
// //       children: _radioOptionGroup
// //           .map((item) => Container(
// //         width: 150.w,
// //         alignment: Alignment.center,
// //         // padding: EdgeInsets.all(5.0.w),
// //         decoration: BoxDecoration(
// //             borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
// //             color: item.index == _currentIndex
// //                 ?  Colors.grey
// //                 : Theme.of(context).backgroundColor
// //         ),
// //         child: Row(
// //           children: <Widget>[
// //             Radio(
// //               groupValue: _currentIndex,
// //               value: item.index,
// //               onChanged: (val) {
// //                 setState(() {
// //                   shippingType = val == 1 ? 'freeShipping' : 'conditionShipping';
// //                   currentIndex = val!;
// //                   _currentIndex = currentIndex;
// //                 });
// //                 print(currentIndex);
// //               },
// //               activeColor: item.index == _currentIndex
// //                   ? Theme.of(context).backgroundColor
// //                   : Theme.of(context).secondaryHeaderColor,
// //             ),
// //             Text(
// //               item.text,
// //               style: item.index == _currentIndex
// //                   ? Theme.of(context).textTheme.caption!.copyWith(
// //                   color: Theme.of(context).primaryColor
// //               )
// //                   : Theme.of(context).textTheme.caption,
// //             ),
// //           ],
// //         ),
// //       ))
// //           .toList(),
// //     );
// //   }
// // }
//
//
//
