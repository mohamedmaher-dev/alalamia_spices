// import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
// import 'package:alalamia_spices/app/exports/provider.dart';location.dart';
// import 'package:alalamia_spices/app/data/model/location_model.dart';
// import 'package:alalamia_spices/app/module/user/my_locations/edite_location_screen.dart';
// import 'package:alalamia_spices/app/exports/services.dart';/screen_navigation_service.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import '../../../../core/utils/constants.dart';
// import '../../../../data/model/translations.dart';
// import '../../../../global_widgets/custom_dialog.dart';
// import '../../../../global_widgets/custom_two_text.dart';
//
//
// class MyLocationsCard extends StatefulWidget {
//   final UserLocations locations;
//   final String id;
//   const MyLocationsCard({
//     required this.locations,
//     required this.id,
//     Key? key
//   }) : super(key: key);
//
//   @override
//   State<MyLocationsCard> createState() => _MyLocationsCardState();
// }
//
// class _MyLocationsCardState extends State<MyLocationsCard> {
//   bool checkedValue = false;
//   int optionalValue = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<LocationModel>(
//       create: (context) => LocationModel(context),
//       child: Consumer<LocationModel>(
//         builder: (context , model , child){
//           return Stack(
//             children: [
//               Padding(
//                 padding:  EdgeInsets.symmetric(horizontal: 10.w , vertical: 10.h),
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: 100.h,
//                   padding: const  EdgeInsets.all( 10.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                     color: widget.locations.location == 1
//                       ? Theme.of(context).colorScheme.secondary.withOpacity(0.5)
//                       : Theme.of(context).primaryColor,
//                     // border: Border.all(color: widget.locations.location == 1
//                     //     ? Theme.of(context).colorScheme.secondary
//                     //     : Colors.transparent)
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CustomTowText(
//                         title: "${allTranslations.text("locationTitle")}: ",
//                         subWidget: SizedBox(
//                           width: 230.w,
//                           child: Text(
//                               widget.locations.name.toString(),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: Theme.of(context).textTheme.bodyMedium!
//                           ),
//                         ),
//                         titleStyle: Theme.of(context).textTheme.bodyMedium!!.copyWith(
//                             fontWeight: FontWeight.bold
//                         ),
//                         // subTitle: widget.locations.name.toString(),
//                         // subTitleStyle: Theme.of(context).textTheme.bodyMedium!
//                       ),
//
//                       10.ph,
//                       CustomTowText(
//                         title: allTranslations.text("detail"),
//                         titleStyle: Theme.of(context).textTheme.caption!.copyWith(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14.sp
//                         ),
//                         subTitle: "${widget.locations.desc}" ,
//                       ),
//
//
//
//                       StatefulBuilder(
//                         builder: (context , mySetState){
//                           return Builder(
//                             builder: (context) {
//                               return Expanded(
//                                 flex: 2,
//                                 child: CheckboxListTile(
//                                   dense: true,
//                                   contentPadding: EdgeInsets.all(0.h),
//                                   title: Text(
//                                     allTranslations.text("default"),
//                                     style: Theme.of(context).textTheme.caption,
//                                   ),
//                                   value: widget.locations.location == 1
//                                     ? true
//                                     : false,
//                                   checkboxShape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                                   ),
//                                   onChanged: (newValue) async{
//                                     await showDialog(
//                                         context: context,
//                                         builder: (BuildContext context){
//
//                                           return CustomDialogWidget(
//                                             title: Text(
//                                                 allTranslations.text("changeDefaultLocation"),
//                                               style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                                                 fontWeight: FontWeight.bold
//                                               ),
//                                             ),
//                                             withActions: true,
//                                             withYesButton: true,
//                                             withNoButton: true,
//                                             onPressed: () async{
//                                               Navigator.pop(context);
//
//                                               if(await model.changeDefaultLocation(locationId: widget.id,)){
//                                                 mySetState(() {
//                                                   checkedValue = newValue!;
//                                                   checkedValue == true
//                                                       ? widget.locations.location = 1
//                                                       : widget.locations.location = 0;
//                                                 });
//                                               }
//
//
//                                               if(kDebugMode){
//                                                 print("optional =  $optionalValue");
//                                               }
//                                               // if(mounted) return;
//
//                                             },
//                                           );
//                                         }
//                                     );
//
//
//
//                                   },
//                                   controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
//                                 ),
//                               );
//                             }
//                           );
//                         },
//                       ),
//
//
//                     ],
//                   ),
//                 ),
//               ),
//
//
//
//               /// edite location
//               Positioned(
//                 top: 10,
//                 left: allTranslations.currentLanguage == "ar" ? 3 : null,
//                 right: allTranslations.currentLanguage == "en" ? 3 : null,
//                 child: InkWell(
//                   onTap: () {
//                     pushScreen(context,  EditeLocationScreen(
//                       locations: widget.locations,
//                     )
//                     );
//                   },
//                   child: Card(
//                     elevation: 0.5,
//                     child: Container(
//                       height: 30.h,
//                       width: 30.w,
//                       padding:  EdgeInsets.all(5.w),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                         color: Theme.of(context).primaryColor,
//                       ),
//                       child: Container(
//                         height: 10.h,
//                         width: 10.w,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                           color: Theme.of(context).colorScheme.secondary,
//                         ),
//                         child: Icon(
//                           Icons.edit,
//                           color: Theme.of(context).primaryColor,
//                           size: 15,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//
//
//               /// delete location
//               Positioned(
//                 top: 80,
//                 left: allTranslations.currentLanguage == "ar" ? 3 : null,
//                 right: allTranslations.currentLanguage == "en" ? 3 : null,
//                 child: InkWell(
//                   onTap: () async{
//
//                     await showDialog(
//                         context: context,
//                         barrierDismissible: false,
//                         builder: (BuildContext context){
//
//                           return CustomDialogWidget(
//                             title: Text(
//                               allTranslations.text("confirmDeletion"),
//                               style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                                   fontWeight: FontWeight.bold
//                               ),
//                             ),
//                             withYesButton: true,
//                             withNoButton: true,
//                             withActions: true,
//                             onPressed: () async{
//                               model.errors.clear();
//                               await model.delete(
//                                   widget.locations,
//                                   widget.locations.id.toString(),
//
//                               );
//                               model.loadData();
//                               Navigator.pop(context);
//
//                             },
//                           );
//                         }
//                     );
//
//                   },
//                   child: Card(
//                     elevation: 0.5,
//                     child: Container(
//                       height: 30.h,
//                       width: 30.w,
//                       padding:  EdgeInsets.all(5.w),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                         color: Theme.of(context).primaryColor,
//                       ),
//                       child: Container(
//                         height: 10.h,
//                         width: 10.w,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                           color: Theme.of(context).colorScheme.secondary,
//                         ),
//                         child: Icon(
//                           Icons.delete,
//                           color: Theme.of(context).primaryColor,
//                           size: 15,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
