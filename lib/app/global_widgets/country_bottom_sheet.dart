// //
// import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
// import 'package:alalamia_spices/app/data/model/appModel.dart';
// import 'package:alalamia_spices/app/exports/widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../alalamiah_app.dart';
// import '../core/utils/constants.dart';
// import '../data/classes/countries.dart';
// import '../data/model/cartModel.dart';
// import '../data/model/ceiling_price_model.dart';
// import '../data/model/countries_model.dart';
// import '../data/model/translations.dart';
// import '../data/model/user_wallet_model.dart';
// import '../module/app_config/app_config_screen.dart';
// import '../services/custom_toast.dart';
// import '../services/prefs.dart';
// //
// // class CountryPickerDialog {
// //   final BuildContext context;
// //   final CountriesModel countriesModel;
// //
// //   CountryPickerDialog({required this.context, required this.countriesModel});
// //
// //   Future saveCountryDetails ({required String id, required String image, required String name}) async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     await prefs.setString("countryId", id);
// //     await prefs.setString("countryImage", image);
// //     await prefs.setString("countryName", name);
// //   }
// //
// //   Future<Future<Countries?>> showCountryPicker() async {
// //     return showModalBottomSheet<Countries>(
// //       context: context,
// //       elevation: 0.3,
// //       isScrollControlled: true,
// //       enableDrag: true,
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.vertical(
// //           top: Radius.circular(AppConstants.defaultBorderRadius.w),
// //         ),
// //       ),
// //       builder: (BuildContext context) {
// //         return Padding(
// //           padding: EdgeInsets.all(10.0.w),
// //           child: Wrap(
// //             crossAxisAlignment: WrapCrossAlignment.start,
// //             runSpacing: 10.0.h,
// //             runAlignment: WrapAlignment.spaceBetween,
// //             children: [
// //               BottomSheetHeader(
// //                   title: allTranslations.text("country"),
// //                   subTitle: allTranslations.text("countrySubTitle")
// //               ),
// //
// //               CountryPicker(countriesModel: countriesModel),
// //
// //               20.ph,
// //
// //               CustomButtons(
// //                 height: 45.h,
// //                 text: allTranslations.text("save"),
// //                 buttonColor: countryId.isNotEmpty
// //                     ? Theme.of(context).secondaryHeaderColor
// //                     : Colors.grey,
// //                 onTap: countryId.isNotEmpty
// //                     ? () async {
// //                   try {
// //                     await saveCountryDetailsAndReloadModels(context);
// //                     Navigator.of(context).pop();
// //                   } catch (e) {
// //                     CustomToast.showFlutterToast(
// //                       context: context,
// //                       message: e.toString(), // Show the error message
// //                     );
// //                   }
// //                 }
// //                     : () {
// //                   CustomToast.showFlutterToast(
// //                     context: context,
// //                     message: allTranslations.text("chooseCountryHintTxt"),
// //                   );
// //                 },
// //               ),
// //
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }
// //   Future<void> saveCountryDetailsAndReloadModels(BuildContext context) async {
// //     saveCountryDetails(
// //       id: countryId,
// //       name: countryName.toString(),
// //       image: countryImage.toString(),
// //     );
// //
// //    print("idddddddd $countryId");
// //
// //     await countriesModel.changeCountry(countryId);
// //     await Provider.of<UserWalletModel>(context, listen: false).loadData(context);
// //     await Provider.of<CartModel>(context, listen: false).deleteAll();
// //     await Provider.of<CartModel>(context, listen: false).loadData(context);
// //     await MaterialAppWithTheme.restartApp(context);
// //
// //   }
// // }
// //
// // class CountryPicker extends StatefulWidget {
// //   final CountriesModel countriesModel;
// //   const CountryPicker({super.key, required this.countriesModel});
// //
// //   @override
// //   State<CountryPicker> createState() => _CountryPickerState();
// // }
// //
// // class _CountryPickerState extends State<CountryPicker> {
// //   int selectedCountry = 0;
// //   @override
// //   Widget build(BuildContext context) {
// //     if (widget.countriesModel.isLoading || widget.countriesModel.loadingFailed) {
// //       return const CircularLoading();
// //     }
// //     return GridView.builder(
// //       shrinkWrap: true,
// //       scrollDirection: Axis.vertical,
// //       gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
// //         maxCrossAxisExtent: 180.w,
// //         mainAxisExtent: 160.h,
// //
// //       ),
// //       itemCount: widget.countriesModel.items.length,
// //       itemBuilder: (context , index){
// //         return InkWell(
// //           onTap: (){
// //             setState(() {
// //               selectedCountry = index;
// //               countryName = widget.countriesModel.items[selectedCountry].name.toString();
// //               countryId = widget.countriesModel.items[selectedCountry].id.toString();
// //               countryImage = widget.countriesModel.items[selectedCountry].imagePath.toString();
// //             });
// //
// //
// //           },
// //           child: Padding(
// //             padding:  EdgeInsets.all(10.0.w),
// //             child: Container(
// //               width: 140.w,
// //               height: 140.h,
// //               padding: EdgeInsets.all(5.w),
// //               decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
// //                   border: selectedCountry == index
// //                       ? Border.all(color: Theme.of(context).colorScheme.secondary , width: 2.w)
// //                       : Border.all(color: Colors.grey[400]!)
// //               ),
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 crossAxisAlignment: CrossAxisAlignment.center,
// //                 children: [
// //                   CustomCachedNetworkImage(
// //                     imageUrl: widget.countriesModel.items[index].imagePath,
// //                     width: 70.w,
// //                     height: 70.h,
// //                     errorImageHeight: 30.h,
// //                     errorImageWidth: 30.w,
// //                   ),
// //                   10.ph,
// //
// //                   Text(
// //                     widget.countriesModel.items[index].name.toString(),
// //                     textAlign: TextAlign.center,
// //                     style: Theme.of(context).textTheme.bodyLarge!.copyWith(
// //                         fontWeight: FontWeight.bold
// //                     ),
// //                   )
// //                 ],
// //               ),
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }
//
//
//
//
// class CountryPickerDialog {
//   final BuildContext context;
//   final CountriesModel countriesModel;
//
//   CountryPickerDialog({required this.context, required this.countriesModel});
//
//   int selectedCountryIndex = 0;
//   Future<void> showCountryPicker(BuildContext context) async {
//      showModalBottomSheet<Countries>(
//       context: context,
//       elevation: 0.3,
//       isScrollControlled: true,
//       enableDrag: true,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(AppConstants.defaultBorderRadius.w),
//         ),
//       ),
//       builder: (_) => _buildBottomSheet(context),
//     );
//   }
//
//
//   Widget _buildBottomSheet(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(10.0.w),
//       child: Wrap(
//         crossAxisAlignment: WrapCrossAlignment.start,
//         runSpacing: 10.0.h,
//         runAlignment: WrapAlignment.spaceBetween,
//         children: [
//           BottomSheetHeader(
//             title: allTranslations.text("country"),
//             subTitle: allTranslations.text("countrySubTitle"),
//           ),
//           CountryPicker(countriesModel: countriesModel),
//           20.ph,
//           _buildSaveButton(context),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSaveButton(BuildContext context) {
//     var cartModel = Provider.of<CartModel>(context , listen: false);
//     var countriesModel = Provider.of<CountriesModel>(context , listen: false);
//     return Consumer<CountryPickerState>(
//       builder: (context, pickerState, _) => CustomButtons(
//       height: 45.h,
//       isLoading: countriesModel.isSaving,
//       text: allTranslations.text("save"),
//       buttonColor: pickerState.countryId.isNotEmpty
//           ? Theme.of(context).secondaryHeaderColor
//           : Colors.grey,
//       onTap: pickerState.countryId.isNotEmpty
//           ? () async{
//
//         countriesModel.isSaving = true;
//
//         try{
//           // if(appModel.token != 'visitor'){
//           //   await countriesModel.changeCountry(pickerState.countryId);
//           // }
//           countriesModel.saveCountryDetails(
//               id: countryId.toString(),
//               name: countryName.toString(),
//               image: countryImage.toString()
//           );
//
//           countriesModel.getCountryCode();
//           countriesModel.getCountryDetails();
//
//           if(countriesModel.isLoaded){
//             countriesModel.isSaving = false;
//             Navigator.pop(context);
//           }
//
//
//         }catch (error){
//
//             print("error changing country = $error");
//
//         }
//
//         SharedPrefsService.putBool("hasShownDialog", false);
//         await Provider.of<UserWalletModel>(context , listen: false).loadData(context);
//         await Provider.of<CeilingPriceModel>(context , listen: false).loadData(context);
//         await cartModel.deleteAll();
//         await cartModel.loadData(context);
//         await MaterialAppWithTheme.restartApp(context);
//       }
//           : () {
//         CustomToast.showFlutterToast(
//           context: context,
//           message: allTranslations.text("chooseCountryHintTxt"),
//         );
//       },
//     ),
//     );
//   }
//
// }
//
// class CountryPicker extends StatefulWidget {
//   final CountriesModel countriesModel;
//   const CountryPicker({super.key, required this.countriesModel});
//
//   @override
//   State<CountryPicker> createState() => _CountryPickerState();
// }
//
// class _CountryPickerState extends State<CountryPicker> {
//   int selectedCountryIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     if (widget.countriesModel.isLoading || widget.countriesModel.loadingFailed) {
//       return const CircularLoading();
//     }
//     return GridView.builder(
//       shrinkWrap: true,
//       scrollDirection: Axis.vertical,
//       gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//         maxCrossAxisExtent: 180.w,
//         mainAxisExtent: 160.h,
//       ),
//       itemCount: widget.countriesModel.items.length,
//       itemBuilder: (context, index) {
//         final country = widget.countriesModel.items[index];
//         return _buildCountryTile(country, index , context);
//       },
//     );
//   }
//
//   Widget _buildCountryTile(Countries country, int index , BuildContext context) {
//     final isSelected = selectedCountryIndex == index;
//     var countriesModel = Provider.of<CountriesModel>(context , listen: false);
//     countriesModel.saveCountryCode(
//         initialCountry: countriesModel.items[selectedCountryIndex].adminName.toString(),
//         dialCode: countriesModel.items[selectedCountryIndex].phone.toString(),
//         countryId: countriesModel.items[selectedCountryIndex].id.toString()
//     );
//     return InkWell(
//       onTap: () => _selectCountry(index),
//       child: Padding(
//         padding: EdgeInsets.all(10.0.w),
//         child: Container(
//           width: 140.w,
//           height: 140.h,
//           padding: EdgeInsets.all(5.w),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//             border: isSelected
//                 ? Border.all(color: Theme.of(context).colorScheme.secondary, width: 2.w)
//                 : Border.all(color: Colors.grey[400]!),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               CustomCachedNetworkImage(
//                 imageUrl: country.imagePath.toString(),
//                 width: 70.w,
//                 height: 70.h,
//                 errorImageHeight: 30.h,
//                 errorImageWidth: 30.w,
//               ),
//               SizedBox(height: 10.h),
//               Text(
//                 country.name.toString(),
//                 textAlign: TextAlign.center,
//                 style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _selectCountry(int index) {
//     setState(() {
//       selectedCountryIndex = index;
//       // Update the state with the selected country details.
//       Provider.of<CountryPickerState>(context, listen: false).selectCountry(widget.countriesModel.items[index]);
//     });
//   }
// }
//
// class CountryPickerState with ChangeNotifier {
//   String countryId = '';
//   String countryName = '';
//   String countryImage = '';
//
//   void selectCountry(Countries country) {
//     countryId = country.id.toString();
//     countryName = country.name.toString();
//     countryImage = country.imagePath.toString();
//     notifyListeners();
//   }
// }
//
//
