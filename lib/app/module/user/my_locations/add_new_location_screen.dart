//
// import 'dart:async';
// import 'package:alalamia_spices/app/core/utils/constants.dart';
// import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
// import 'package:alalamia_spices/app/core/values/app_lottie.dart';
// import 'package:alalamia_spices/app/exports/provider.dart';
// import 'package:alalamia_spices/app/module/check_out/check_out_screen.dart';
// import 'package:alalamia_spices/app/module/user/my_locations/my_location_screen.dart';
// import 'package:android_intent_plus/android_intent.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_geocoder/geocoder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:lottie/lottie.dart' as lottie;
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:search_map_place_updated/search_map_place_updated.dart';
// import 'package:alalamia_spices/app/exports/provider.dart';
// import 'package:alalamia_spices/app/exports/widget.dart';
// import 'package:alalamia_spices/app/exports/services.dart';
// import '../../check_out/widget/location_details.dart';
//
// class AddNewLocationScreen extends StatelessWidget {
//   final bool isFromCheckOut;
//   const AddNewLocationScreen({
//     Key? key,
//     required this.isFromCheckOut
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         // ChangeNotifierProvider<AreaModel>(create: (context) => AreaModel(context),)
//         ChangeNotifierProvider<LocationModel>(create: (context) => LocationModel(context),)
//       ],
//       child:  SubAddNewLocation(isFromCheckOut: isFromCheckOut,),
//     );
//   }
// }
//
//
//
// class SubAddNewLocation extends StatefulWidget {
//   final bool isFromCheckOut;
//   const SubAddNewLocation({
//     Key? key,
//     required this.isFromCheckOut
//   }) : super(key: key);
//
//   @override
//   State<SubAddNewLocation> createState() => _SubAddNewLocationState();
// }
//
// class _SubAddNewLocationState extends State<SubAddNewLocation> with WidgetsBindingObserver {
//
//   TextEditingController descriptionController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   GoogleMapController? mapController;
//   Completer<GoogleMapController> mapControllerCompleter = Completer();
//   Position? position;
//   String? chosenArea;
//   // String? chosenAreaId;
//   String? _darkMapStyle;
//   String? _lightMapStyle;
//   LatLng? _lastMapPosition;
//   String? placeName;
//   bool _isLoading =  false;
//   int optionalValue = 0;
//   bool checkedValue = false;
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   var geolocation;
//
//
//   Future checkGps() async {
//     bool isGpsEnabled = await Geolocator.isLocationServiceEnabled();
//
//     if (!(isGpsEnabled)) {
//       if (Theme.of(context).platform == TargetPlatform.android) {
//
//         await showDialog(
//             context: context,
//             builder: (BuildContext context){
//
//               return CustomDialogWidget(
//                   title: Text(
//                     allTranslations.text("locationMessage"),
//                     style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold
//                     ),
//                   ),
//                   content:Text(
//                     allTranslations.text('locationMessageSub'),
//                     style: Theme.of(context).textTheme.bodyText2,
//                   ),
//
//                   withNoButton: true,
//                   withActions: true,
//                   withYesButton: true,
//                   onPressed: (){
//                     const  AndroidIntent intent =  AndroidIntent(
//                         action: 'android.settings.LOCATION_SOURCE_SETTINGS');
//                     intent.launch();
//                     Navigator.of(context, rootNavigator: true).pop();
//                   }
//               );
//             }
//         );
//
//
//
//       }
//     }
//   }
//
//   void getCurrentLocation() async {
//
//     // Position res = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//     // setState(() {
//     //   position = res;
//     // });
//     // final coordinators = Coordinates(position!.latitude, position!.longitude);
//     // var address = await Geocoder.local.findAddressesFromCoordinates(coordinators);
//     // var first = address.first;
//     // placeName = ("${first.addressLine}").toString();
//     position = await Geolocator.getLastKnownPosition();
//     List<Placemark> placemarks = await placemarkFromCoordinates(
//         position!.latitude, position!.longitude);
//     Placemark place = placemarks.first;
//     placeName = ("${place.street}  ${place.locality} ${place.country}").toString();
//
//   }
//
//   Future _loadMapStyles() async {
//     _darkMapStyle  = await rootBundle.loadString('assets/map_style/darkMapStyle.json');
//     _lightMapStyle = await rootBundle.loadString('assets/map_style/lightMapStyle.json');
//   }
//
//   Future _setMapStyle(BuildContext context) async {
//     var themeChange = Provider.of<ThemeModel>(context , listen: false);
//     final controller = await mapControllerCompleter.future;
//     final theme = WidgetsBinding.instance.window.platformBrightness;
//     if (themeChange.darkTheme == true) {
//       controller.setMapStyle(_darkMapStyle);
//     } else {
//       controller.setMapStyle(_lightMapStyle);
//     }
//   }
//
//
//   bool isMarkerSelected = false;
//
//
//   Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
//   void getMarkers(double markerLat, double markerLong) {
//     MarkerId markerId = MarkerId(markerLat.toString() + markerLong.toString());
//     Marker marker = Marker(
//         markerId: markerId,
//         position: LatLng(markerLat, markerLong),
//         icon: BitmapDescriptor.defaultMarker,
//         infoWindow: const InfoWindow(title: "My Location"));
//     setState(() {
//       markers = <MarkerId, Marker>{};
//       markers[markerId] = marker;
//     });
//   }
//
//   void _onTapMarker(LatLng tapped) async {
//     setState(() {
//       isMarkerSelected = true;
//       _lastMapPosition = tapped ;
//
//       if (kDebugMode) {
//         print(tapped.longitude + tapped.latitude);
//       }
//     });
//
//     getMarkers(tapped.latitude, tapped.longitude);
//     final coordinators = Coordinates(tapped.latitude, tapped.longitude);
//     var address = await Geocoder.local.findAddressesFromCoordinates(coordinators);
//     var first = address.first;
//     placeName = ("${first.addressLine}").toString();
//   }
//
//
//
//   Future<LatLng> askPermissionAndGetLocation() async {
//     if (await Permission.locationWhenInUse.serviceStatus.isEnabled) { //this here checks
// //if the permission is granted and if not , it requests it.
//
//       print("Hi I am Moahammed");
//
//       if (await Permission.location.request().isGranted) {
//
//       }
//     }
//     return Future.error("Location services disabled or restricted");
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     checkGps();
//     getCurrentLocation();
//     askPermissionAndGetLocation();
//     WidgetsBinding.instance.addObserver(this);
//     _loadMapStyles();
//   }
//
//   @override
//   void didChangePlatformBrightness() {
//     setState(() {
//       _setMapStyle(context);
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     descriptionController.dispose();
//     mapController!.dispose();
//     phoneController.dispose();
//     WidgetsBinding.instance.removeObserver(this);
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // if (kDebugMode) {
//     //   print("place name $placeName");
//     // }
//     return ChangeNotifierProvider<LocationModel>(
//       create: (context) => LocationModel(context),
//       child: Consumer<LocationModel> (
//         builder: (context , model , child){
//           var defaultLocation = model.items.where((element) => element.location == 1).toList();
//           // areaModel.getAreaList();
//           return SafeArea(
//             child: Scaffold(
//               backgroundColor: Theme.of(context).backgroundColor,
//               appBar: PreferredSize(
//                 preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
//                 child: const CustomAppBar(),
//               ),
//               body: GestureDetector(
//                 onTap: (){
//                   return FocusScope.of(context).unfocus();
//                 },
//                 child: Form(
//                   key: formKey,
//                   child: SizedBox(
//                     height: MediaQuery.of(context).size.height,
//                     width: MediaQuery.of(context).size.width,
//                     child: Stack(
//                       // mainAxisAlignment: MainAxisAlignment.start,
//                       // crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//
//                         /// choose region
//                         // areaModel.isLoading || areaModel.loadingFailed
//                         // ? const CircularLoading()
//                         // : CustomCardIconText(
//                         //     color: Theme.of(context).primaryColor,
//                         //     icon: Icons.language,
//                         //     iconColor: Colors.grey,
//                         //     height: 40.h,
//                         //     width: 45.w,
//                         //     itemsName: allTranslations.text("chooseRegion"),
//                         //     subItemsName: chosenArea,
//                         //     itemsNameStyle: Theme.of(context).textTheme.bodyText2,
//                         //     secondIcon: Icons.arrow_forward_ios,
//                         //     secondIconColor: Colors.grey,
//                         //     onTap: () async{
//                         //
//                         //       await showModalBottomSheet(
//                         //           context: context,
//                         //           elevation: 0.3,
//                         //           isScrollControlled: false,
//                         //           enableDrag: true,
//                         //           shape: const RoundedRectangleBorder(
//                         //             borderRadius: BorderRadius.vertical(
//                         //                 top: Radius.circular(AppConstants.defaultBorderRadius.w)
//                         //             ),
//                         //           ),
//                         //           builder: (context) {
//                         //             return Padding(
//                         //               padding: EdgeInsets.all(10.0.w),
//                         //               child: Wrap(
//                         //                 crossAxisAlignment: WrapCrossAlignment.start,
//                         //                 runSpacing: 10.0.h,
//                         //                 runAlignment: WrapAlignment.spaceBetween,
//                         //                 children: [
//                         //                   Padding(
//                         //                     padding: const EdgeInsets.only(top: 10.0.w),
//                         //                     child: CustomTowText(
//                         //                       title: allTranslations.text("chooseRegion"),
//                         //                       subTitle: chosenArea,
//                         //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         //                       titleStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
//                         //                           fontWeight: FontWeight.bold,
//                         //                           fontSize: 22.sp
//                         //
//                         //                       ),
//                         //                       subWidget: Padding(
//                         //                         padding:  EdgeInsets.symmetric(horizontal: 5.0.w),
//                         //                         child: InkWell(
//                         //                           onTap: (){
//                         //                             Navigator.of(context).pop();
//                         //                           },
//                         //                           child: Icon(
//                         //                             Icons.close,
//                         //                             size: 30,
//                         //                             color: Theme.of(context).secondaryHeaderColor,
//                         //                           ),
//                         //                         ),
//                         //                       ),
//                         //                     ),
//                         //                   ),
//                         //
//                         //                   40.ph,
//                         //
//                         //                   DropdownSearch<String>(
//                         //                     popupProps:  PopupProps.modalBottomSheet(
//                         //                         isFilterOnline: true,
//                         //                         showSearchBox: true,
//                         //                         showSelectedItems: true,
//                         //                         searchFieldProps: TextFieldProps(
//                         //                             showCursor: true,
//                         //                             decoration: InputDecoration(
//                         //                               hintText: allTranslations.text("searchRegion"),
//                         //                               hintStyle: Theme.of(context).textTheme.caption,
//                         //                               border: OutlineInputBorder(
//                         //                                   borderRadius : BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                         //                                   borderSide: BorderSide(
//                         //                                       color: Theme.of(context).backgroundColor
//                         //                                   )
//                         //                               ),
//                         //                             )
//                         //
//                         //                         )
//                         //                       // disabledItemFn: (String s) => s.startsWith('I'),
//                         //                     ),
//                         //                     items: areaModel.areaList,
//                         //                     dropdownDecoratorProps:  DropDownDecoratorProps(
//                         //                       dropdownSearchDecoration: InputDecoration(
//                         //                         border: OutlineInputBorder(
//                         //                             borderRadius : BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                         //                             borderSide: BorderSide(
//                         //                                 color: Theme.of(context).secondaryHeaderColor
//                         //                             )
//                         //                         ),
//                         //                         // labelText: "Menu mode",
//                         //                         hintText: allTranslations.text("areas"),
//                         //
//                         //                       ),
//                         //                     ),
//                         //                     onChanged: (value){
//                         //
//                         //                       setState(() {
//                         //                         chosenArea = value;
//                         //                       });
//                         //                       for(var i = 0; i < areaModel.items.length; i++){
//                         //                         if(chosenArea == areaModel.items[i].name){
//                         //                           chosenAreaId = areaModel.items[i].stateId;
//                         //
//                         //                         }
//                         //                       }
//                         //
//                         //                       if(kDebugMode){
//                         //                         print("area id $chosenAreaId");
//                         //                         print("chosen area $chosenArea");
//                         //                       }
//                         //                     },
//                         //                     selectedItem: chosenArea,
//                         //                   ),
//                         //
//                         //                   20.ph,
//                         //
//                         //                   CustomButtons(
//                         //                     height: 40.h,
//                         //                     text: allTranslations.text("save"),
//                         //                     buttonColor: Theme.of(context).secondaryHeaderColor,
//                         //                     onTap: () async {
//                         //                       Navigator.of(context).pop();
//                         //                     },
//                         //                   )
//                         //                 ],
//                         //               ),
//                         //             );
//                         //           });
//                         //
//                         //     }
//                         // ),
//                         //
//                         // 10.ph,
//
//                         /// Google Maps
//                         Padding(
//                           padding:  EdgeInsets.only(top: 190.0.r , left: 10.r , right: 10.r),
//                           child: GoogleMap(
//                             mapType: MapType.normal,
//                             buildingsEnabled: true,
//                             rotateGesturesEnabled: true,
//                             scrollGesturesEnabled: true,
//                             trafficEnabled: true,
//                             myLocationEnabled: true,
//                             tiltGesturesEnabled: false,
//                             minMaxZoomPreference: const  MinMaxZoomPreference(13, 17),
//                             initialCameraPosition: const CameraPosition(
//                                 bearing:
//                                 192.8334901395799,
//                                 target:  LatLng(15.361980, 44.201950),
//                                 tilt: 59.440717697143555,
//                                 zoom: 14),
//                             markers: Set<Marker>.of(markers.values),
//                             onTap: _onTapMarker,
//                             onMapCreated: (GoogleMapController controller) {
//                               mapController = controller;
//                               mapControllerCompleter.complete(controller);
//                               _setMapStyle(context);
//
//                             },
//
//                           ),
//                         ),
//
//
//                         /// phone text filed
//
//                         Positioned(
//                           top: 10,
//                           left: 10.r,
//                           right: 10.r,
//                           child: Container(
//                             padding: defaultLocation.isNotEmpty
//                                 ? EdgeInsets.all(0.h)
//                                 : EdgeInsets.symmetric(horizontal: 5.w , vertical: 5.h),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                                 color: defaultLocation.isNotEmpty
//                                     ? Colors.transparent
//                                     : Theme.of(context).primaryColor
//                             ),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   flex: 4,
//                                   child: CustomTextFormField(
//                                     maxLines: 1,
//                                     controller: phoneController,
//                                     keyboardType: TextInputType.phone,
//                                     textInputAction: TextInputAction.next,
//                                     hintText: allTranslations.text("userPhone"),
//                                     contentPadding: EdgeInsets.symmetric(horizontal: 10.w , vertical: 5.h),
//                                     textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
//                                         fontFamily: "cairo",
//                                         fontSize: 12.sp
//                                     ),
//                                     validator: (value){
//                                       if (value.length == 0) {
//                                         return allTranslations.text('mostEnterPhone');
//                                       }
//                                       return null;
//                                     },
//                                   ),
//                                 ),
//
//
//
//
//
//                                 model.isLoading || model.loadingFailed
//                                     ? const CircularLoading()
//                                     : defaultLocation.isNotEmpty
//                                     ? 0.ph
//                                     : StatefulBuilder(
//                                   builder: (context , mySetState){
//                                     return Expanded(
//                                       flex: 2,
//                                       child: CheckboxListTile(
//                                         dense: true,
//                                         contentPadding: EdgeInsets.all(0.h),
//                                         title: Text(
//                                           allTranslations.text("default"),
//                                           style: Theme.of(context).textTheme.caption,
//                                         ),
//                                         value: checkedValue,
//                                         checkboxShape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                                         ),
//                                         onChanged: (newValue) {
//                                           mySetState(() {
//                                             checkedValue = newValue!;
//                                             checkedValue == true
//                                                 ? optionalValue = 1
//                                                 : optionalValue = 0;
//                                           });
//                                           if(kDebugMode){
//                                             print("optional =  $optionalValue");
//                                           }
//                                         },
//                                         controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
//                                       ),
//                                     );
//                                   },
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//
//                         /// description text filed
//
//                         Positioned(
//                           top: 70,
//                           left: 10.r,
//                           right: 10.r,
//                           child: CustomTextFormField(
//                             controller: descriptionController,
//                             keyboardType: TextInputType.text,
//                             textInputAction: TextInputAction.done,
//                             hintText: allTranslations.text("locationDetailsHint"),
//                             contentPadding: EdgeInsets.symmetric(horizontal: 10.w , vertical: 5.h),
//                             validator: (value) {
//                               if (value.length == 0) {
//                                 return allTranslations.text("fieldRequired");
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//
//
//
//                         /// search location
//
//                         Positioned(
//                           top: 130,
//                           left: 10.r,
//                           right: 10.r,
//                           child: SearchMapPlaceWidget(
//                             hasClearButton: true,
//                             apiKey: "AIzaSyBAuQmLWRlS8VtG_8Q9lboVzR2bahdLeU8",
//                             iconColor: Theme.of(context).accentColor,
//                             bgColor: Theme.of(context).primaryColor,
//                             textColor: Theme.of(context).textTheme.caption!.color!,
//                             placeType: PlaceType.establishment,
//                             language: allTranslations.currentLanguage,
//                             location: const LatLng(15.369445, 44.191006),
//                             radius: 30000,
//                             strictBounds: false,
//                             placeholder: allTranslations.text('mapSearchHint'),
//
//                             onSelected: (Place place) async {
//
//                               geolocation = await place.geolocation;
//                               mapController!.animateCamera(
//                                   CameraUpdate.newLatLng(
//                                       geolocation.coordinates
//                                   )
//                               );
//
//                               mapController!.animateCamera(
//                                   CameraUpdate.newLatLngBounds(geolocation.bounds, 100)
//                               );
//
// //                                mapController = await _mapController.future;
// //                                 _selectedPlace = place;
//
// //
// //
//                             },
//                           ),
//                         ),
//
//
//                         /// button
//                         Positioned(
//                           bottom: 0,
//                           right: 10.r,
//                           left: 10.r,
//                           child: CustomButtons(
//                             text: allTranslations.text("save"),
//                             textWidget: _isLoading == false
//                                 ? null
//                                 : const CircularLoading(),
//                             buttonColor: chosenArea == ""
//                                 ? Colors.grey
//                                 : _isLoading == true
//                                 ? Theme.of(context).backgroundColor
//                                 : Theme.of(context).secondaryHeaderColor,
//                             onTap: chosenArea == ""
//                                 ? CustomToast.showFlutterToast(
//                               context: context,
//                               message: allTranslations.text("chooseRegion"),
//                             )
//                                 : () async{
//                               setState((){
//                                 _isLoading = true;
//                               });
//                               if(formKey.currentState!.validate()){
//
//                                 if(isMarkerSelected == false){
//                                   if (kDebugMode) {
//                                     print("/// isMarkerSelected = false");
//                                   }
//                                   getCurrentLocation();
//                                   UserLocations location =
//                                   UserLocations(
//                                       name: placeName.toString(),
//                                       desc: descriptionController.text,
//                                       lat: position!.latitude.toString(),
//                                       long: position!.longitude.toString(),
//                                       areaId: chosenAreaId,
//                                       phone: phoneController.text.toString(),
//                                       location: optionalValue
//                                   );
//                                   await model.addLocation(location);
//
//                                   if (model.isLoaded) {
//
//
//                                     await showDialog(
//                                         context: context,
//                                         builder: (BuildContext context){
//
//                                           return CustomDialogWidget(
//                                               title: Text(
//                                                 allTranslations.text("locationSaved"),
//                                                 style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                                                     fontSize: 16.sp,
//                                                     fontWeight: FontWeight.bold
//                                                 ),
//                                               ),
//                                               content: lottie.Lottie.asset(
//                                                 AppLottie.checkMark,
//                                                 width: 100.w,
//                                                 height: 100.h,
//                                                 repeat: false,
//                                               ),
//
//                                               withNoButton: false,
//                                               withActions: true,
//                                               withYesButton: true,
//                                               onPressed: (){
//                                                 widget.isFromCheckOut == true
//                                                     ? pushScreenReplacement(context, const CheckOutScreen())
//                                                     : pushScreenReplacement(context, const MyLocationsScreen(
//                                                       fromAddUserLocation: true,
//                                                 ));
//                                               }
//                                           );
//                                         }
//                                     );
//
//                                     // CustomDialog().showCustomDialog(
//                                     //   context: context,
//                                     //   title: Text(
//                                     //     allTranslations.text("locationSaved"),
//                                     //     style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                                     //         fontSize: 16.sp,
//                                     //         fontWeight: FontWeight.bold
//                                     //     ),
//                                     //   ),
//                                     //   content: lottie.Lottie.asset(
//                                     //     AppLottie.checkMark,
//                                     //     width: 100.w,
//                                     //     height: 100.h,
//                                     //     repeat: false,
//                                     //   ),
//                                     //   withNoButton: false,
//                                     //   withActions: true,
//                                     //   withYesButton: true,
//                                     //   onPressed: (){
//                                     //     widget.isFromCheckOut == true
//                                     //         ? pushScreenReplacement(context, const CheckOutScreen())
//                                     //         : pushScreenReplacement(context, const MyLocationsScreen());
//                                     //   }
//                                     // );
//
//
//                                     // Future.delayed(const Duration(seconds: 2) , () {
//                                     //  widget.isFromCheckOut == true
//                                     //  ? PersistentNavBarNavigator.pushNewScreen(
//                                     //     context,
//                                     //     screen:  const CheckOutScreen(),
//                                     //     withNavBar: false, // OPTIONAL VALUE. True by default.
//                                     //     pageTransitionAnimation: PageTransitionAnimation.cupertino,
//                                     //   )
//                                     //  : PersistentNavBarNavigator.pushNewScreen(
//                                     //    context,
//                                     //    screen:  const MyLocationsScreen(),
//                                     //    withNavBar: false, // OPTIONAL VALUE. True by default.
//                                     //    pageTransitionAnimation: PageTransitionAnimation.cupertino,
//                                     //  );
//                                     //   Navigator.pop(context);
//                                     // });
//
//
//
//                                   }else {
//                                     setState((){
//                                       _isLoading = false;
//                                     });
//                                   }
//                                 } else{
//                                   _onTapMarker(_lastMapPosition!);
//                                   UserLocations location = UserLocations(
//                                       name: placeName,
//                                       desc:  descriptionController.text,
//                                       lat: _lastMapPosition!.latitude.toString(),
//                                       long:  _lastMapPosition!.longitude.toString(),
//                                       areaId: chosenAreaId,
//                                       phone: phoneController.text.toString(),
//                                       location: optionalValue
//                                   );
//
//                                   await model.addLocation(location);
//                                   if (model.isLoaded) {
//                                     await showDialog(
//                                         context: context,
//                                         builder: (BuildContext context){
//
//                                           return CustomDialogWidget(
//                                               title: Text(
//                                                 allTranslations.text("locationSaved"),
//                                                 style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                                                     fontSize: 16.sp,
//                                                     fontWeight: FontWeight.bold
//                                                 ),
//                                               ),
//                                               content: lottie.Lottie.asset(
//                                                 AppLottie.checkMark,
//                                                 width: 100.w,
//                                                 height: 100.h,
//                                                 repeat: false,
//                                               ),
//
//                                               withNoButton: false,
//                                               withActions: true,
//                                               withYesButton: true,
//                                               onPressed: (){
//                                                 widget.isFromCheckOut == true
//                                                     ? pushScreenReplacement(context, const CheckOutScreen())
//                                                     : pushScreenReplacement(context, const MyLocationsScreen(
//                                                   fromAddUserLocation: true,
//                                                 ));
//                                               }
//                                           );
//                                         }
//                                     );
//
//                                     // Future.delayed(const Duration(seconds: 2) , () {
//                                     //   widget.isFromCheckOut == true
//                                     //       ? PersistentNavBarNavigator.pushNewScreen(
//                                     //     context,
//                                     //     screen:  const CheckOutScreen(),
//                                     //     withNavBar: false, // OPTIONAL VALUE. True by default.
//                                     //     pageTransitionAnimation: PageTransitionAnimation.cupertino,
//                                     //   )
//                                     //       : PersistentNavBarNavigator.pushNewScreen(
//                                     //     context,
//                                     //     screen:  const MyLocationsScreen(),
//                                     //     withNavBar: false, // OPTIONAL VALUE. True by default.
//                                     //     pageTransitionAnimation: PageTransitionAnimation.cupertino,
//                                     //   );
//                                     //   Navigator.pop(context);
//                                     // });
//                                   }
//                                 }
//                               }
//                               else {
//                                 setState((){
//                                   _isLoading = false;
//                                 });
//                                 formKey.currentState!.validate();
//                               }
//                             },
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
//

import 'dart:async';
import 'package:alalamia_spices/app/core/utils/constants.dart';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/core/values/app_lottie.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/module/check_out/check_out_screen.dart';
import 'package:alalamia_spices/app/module/user/my_locations/my_location_screen.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:provider/provider.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import '../../check_out/widget/location_details.dart';

class AddNewLocationScreen extends StatefulWidget {
  final bool isFromCheckOut;
  const AddNewLocationScreen({super.key, required this.isFromCheckOut});

  @override
  State<AddNewLocationScreen> createState() => _AddNewLocationScreenState();
}

class _AddNewLocationScreenState extends State<AddNewLocationScreen>
    with WidgetsBindingObserver {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GoogleMapController? mapController;
  Completer<GoogleMapController> mapControllerCompleter = Completer();
  Position? position;
  String? chosenArea;
  // String? chosenAreaId;
  String? _darkMapStyle;
  String? _lightMapStyle;
  LatLng? _lastMapPosition;
  String? placeName;
  bool _isLoading = false;
  int optionalValue = 0;
  bool checkedValue = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var geolocation;

  Future checkGps() async {
    bool isGpsEnabled = await Geolocator.isLocationServiceEnabled();

    if (!(isGpsEnabled)) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        CustomDialog.showCustomDialog(
            context: context,
            barrierDismissible: false,
            title: allTranslations.text("locationMessage"),
            description: Text(
              allTranslations.text('locationMessageSub'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            withNoButton: true,
            withActions: true,
            withYesButton: true,
            onPressed: () {
              const AndroidIntent intent = AndroidIntent(
                  action: 'android.settings.LOCATION_SOURCE_SETTINGS');
              intent.launch();
              Navigator.of(context, rootNavigator: true).pop();
            });
      }
    }
  }

  Future<void> getCurrentLocation() async {
    Position res = await Geolocator.getCurrentPosition();
    setState(() {
      position = res;
    });
    var address =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);
    var first = address.first;
    placeName = ("${first.thoroughfare}").toString();
    // position = await Geolocator.getLastKnownPosition();
    // List<Placemark> placemarks = await placemarkFromCoordinates(
    //     position!.latitude, position!.longitude);
    // Placemark place = placemarks.first;
    // placeName = ("${place.street}  ${place.locality} ${place.country}").toString();
  }

  Future _loadMapStyles() async {
    _darkMapStyle =
        await rootBundle.loadString('assets/map_style/darkMapStyle.json');
    _lightMapStyle =
        await rootBundle.loadString('assets/map_style/lightMapStyle.json');
  }

  Future _setMapStyle(BuildContext context) async {
    var themeChange = Provider.of<ThemeModel>(context, listen: false);
    final controller = await mapControllerCompleter.future;
    if (themeChange.darkTheme == true) {
      controller.setMapStyle(_darkMapStyle);
    } else {
      controller.setMapStyle(_lightMapStyle);
    }
  }

  bool isMarkerSelected = false;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  void getMarkers(double markerLat, double markerLong) {
    MarkerId markerId = MarkerId(markerLat.toString() + markerLong.toString());
    Marker marker = Marker(
        markerId: markerId,
        position: LatLng(markerLat, markerLong),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(title: "My Location"));
    setState(() {
      markers = <MarkerId, Marker>{};
      markers[markerId] = marker;
    });
  }

  Future<void> _onTapMarker(LatLng tapped) async {
    setState(() {
      isMarkerSelected = true;
      _lastMapPosition = tapped;

      debugPrint(tapped.longitude.toString() + tapped.latitude.toString());
    });
    getMarkers(tapped.latitude, tapped.longitude);
    var address =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);
    var first = address.first;
    placeName = first.thoroughfare == '' ? first.street : first.thoroughfare;
  }

  @override
  void initState() {
    super.initState();
    checkGps();
    getCurrentLocation();
    WidgetsBinding.instance.addObserver(this);
    _loadMapStyles();
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {
      _setMapStyle(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
    descriptionController.dispose();
    mapController!.dispose();
    phoneController.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    // if (kDebugMode) {
    //   print("place name $placeName");
    // }
    return ChangeNotifierProvider<LocationModel>(
      create: (context) => LocationModel(context),
      child: Consumer<LocationModel>(
        builder: (context, model, child) {
          var defaultLocation =
              model.items.where((element) => element.location == 1).toList();
          // areaModel.getAreaList();
          return SafeArea(
            child: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
                child: const CustomAppBar(),
              ),
              body: GestureDetector(
                onTap: () {
                  return FocusScope.of(context).unfocus();
                },
                child: Form(
                  key: formKey,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// choose region
                        // areaModel.isLoading || areaModel.loadingFailed
                        // ? const CircularLoading()
                        // : CustomCardIconText(
                        //     color: Theme.of(context).primaryColor,
                        //     icon: Icons.language,
                        //     iconColor: Colors.grey,
                        //     height: 40.h,
                        //     width: 45.w,
                        //     itemsName: allTranslations.text("chooseRegion"),
                        //     subItemsName: chosenArea,
                        //     itemsNameStyle: Theme.of(context).textTheme.bodyText2,
                        //     secondIcon: Icons.arrow_forward_ios,
                        //     secondIconColor: Colors.grey,
                        //     onTap: () async{
                        //
                        //       await showModalBottomSheet(
                        //           context: context,
                        //           elevation: 0.3,
                        //           isScrollControlled: false,
                        //           enableDrag: true,
                        //           shape: const RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.vertical(
                        //                 top: Radius.circular(AppConstants.defaultBorderRadius.w)
                        //             ),
                        //           ),
                        //           builder: (context) {
                        //             return Padding(
                        //               padding: EdgeInsets.all(10.0.w),
                        //               child: Wrap(
                        //                 crossAxisAlignment: WrapCrossAlignment.start,
                        //                 runSpacing: 10.0.h,
                        //                 runAlignment: WrapAlignment.spaceBetween,
                        //                 children: [
                        //                   Padding(
                        //                     padding: const EdgeInsets.only(top: 10.0.w),
                        //                     child: CustomTowText(
                        //                       title: allTranslations.text("chooseRegion"),
                        //                       subTitle: chosenArea,
                        //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                       titleStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                        //                           fontWeight: FontWeight.bold,
                        //                           fontSize: 22.sp
                        //
                        //                       ),
                        //                       subWidget: Padding(
                        //                         padding:  EdgeInsets.symmetric(horizontal: 5.0.w),
                        //                         child: InkWell(
                        //                           onTap: (){
                        //                             Navigator.of(context).pop();
                        //                           },
                        //                           child: Icon(
                        //                             Icons.close,
                        //                             size: 30,
                        //                             color: Theme.of(context).secondaryHeaderColor,
                        //                           ),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ),
                        //
                        //                   40.ph,
                        //
                        //                   DropdownSearch<String>(
                        //                     popupProps:  PopupProps.modalBottomSheet(
                        //                         isFilterOnline: true,
                        //                         showSearchBox: true,
                        //                         showSelectedItems: true,
                        //                         searchFieldProps: TextFieldProps(
                        //                             showCursor: true,
                        //                             decoration: InputDecoration(
                        //                               hintText: allTranslations.text("searchRegion"),
                        //                               hintStyle: Theme.of(context).textTheme.caption,
                        //                               border: OutlineInputBorder(
                        //                                   borderRadius : BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                        //                                   borderSide: BorderSide(
                        //                                       color: Theme.of(context).backgroundColor
                        //                                   )
                        //                               ),
                        //                             )
                        //
                        //                         )
                        //                       // disabledItemFn: (String s) => s.startsWith('I'),
                        //                     ),
                        //                     items: areaModel.areaList,
                        //                     dropdownDecoratorProps:  DropDownDecoratorProps(
                        //                       dropdownSearchDecoration: InputDecoration(
                        //                         border: OutlineInputBorder(
                        //                             borderRadius : BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                        //                             borderSide: BorderSide(
                        //                                 color: Theme.of(context).secondaryHeaderColor
                        //                             )
                        //                         ),
                        //                         // labelText: "Menu mode",
                        //                         hintText: allTranslations.text("areas"),
                        //
                        //                       ),
                        //                     ),
                        //                     onChanged: (value){
                        //
                        //                       setState(() {
                        //                         chosenArea = value;
                        //                       });
                        //                       for(var i = 0; i < areaModel.items.length; i++){
                        //                         if(chosenArea == areaModel.items[i].name){
                        //                           chosenAreaId = areaModel.items[i].stateId;
                        //
                        //                         }
                        //                       }
                        //
                        //                       if(kDebugMode){
                        //                         print("area id $chosenAreaId");
                        //                         print("chosen area $chosenArea");
                        //                       }
                        //                     },
                        //                     selectedItem: chosenArea,
                        //                   ),
                        //
                        //                   20.ph,
                        //
                        //                   CustomButtons(
                        //                     height: 40.h,
                        //                     text: allTranslations.text("save"),
                        //                     buttonColor: Theme.of(context).secondaryHeaderColor,
                        //                     onTap: () async {
                        //                       Navigator.of(context).pop();
                        //                     },
                        //                   )
                        //                 ],
                        //               ),
                        //             );
                        //           });
                        //
                        //     }
                        // ),
                        //
                        // 10.ph,

                        /// Google Maps
                        Padding(
                          padding: EdgeInsets.only(
                              top: 190.0.r, left: 10.r, right: 10.r),
                          child: GoogleMap(
                            mapType: MapType.normal,
                            buildingsEnabled: true,
                            rotateGesturesEnabled: true,
                            scrollGesturesEnabled: true,
                            trafficEnabled: true,
                            myLocationEnabled: true,
                            tiltGesturesEnabled: false,
                            initialCameraPosition: const CameraPosition(
                                bearing: 192.8334901395799,
                                target: LatLng(15.361980, 44.201950),
                                tilt: 59.440717697143555,
                                zoom: 14),
                            markers: Set<Marker>.of(markers.values),
                            onTap: (position) => _onTapMarker(position),
                            onMapCreated: (GoogleMapController controller) {
                              mapController = controller;
                              mapControllerCompleter.complete(controller);
                              _setMapStyle(context);
                              _goToCurrentLocation(controller);
                            },
                          ),
                        ),

                        /// phone text filed

                        Positioned(
                          top: 10,
                          left: 10.r,
                          right: 10.r,
                          child: Container(
                            padding: defaultLocation.isNotEmpty
                                ? EdgeInsets.all(0.h)
                                : EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 5.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    AppConstants.defaultBorderRadius.w),
                                color: defaultLocation.isNotEmpty
                                    ? Colors.transparent
                                    : Theme.of(context).primaryColor),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: CustomTextFormField(
                                    maxLines: 1,
                                    controller: phoneController,
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.next,
                                    hintText: allTranslations.text("userPhone"),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 5.h),
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontFamily: "cairo",
                                            fontSize: 12.sp),
                                    validator: (value) {
                                      if (value.length == 0) {
                                        return allTranslations
                                            .text('mostEnterPhone');
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                model.isLoading || model.loadingFailed
                                    ? const CircularLoading()
                                    : defaultLocation.isNotEmpty
                                        ? 0.ph
                                        : StatefulBuilder(
                                            builder: (context, mySetState) {
                                              return Expanded(
                                                flex: 2,
                                                child: CheckboxListTile(
                                                  dense: true,
                                                  contentPadding:
                                                      EdgeInsets.all(0.h),
                                                  title: Text(
                                                    allTranslations
                                                        .text("default"),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall,
                                                  ),
                                                  value: checkedValue,
                                                  checkboxShape:
                                                      RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(AppConstants
                                                            .defaultBorderRadius
                                                            .w),
                                                  ),
                                                  onChanged: (newValue) {
                                                    mySetState(() {
                                                      checkedValue = newValue!;
                                                      checkedValue == true
                                                          ? optionalValue = 1
                                                          : optionalValue = 0;
                                                    });
                                                    debugPrint(
                                                        "optional =  $optionalValue");
                                                  },
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading, //  <-- leading Checkbox
                                                ),
                                              );
                                            },
                                          )
                              ],
                            ),
                          ),
                        ),

                        /// description text filed

                        Positioned(
                          top: 70,
                          left: 10.r,
                          right: 10.r,
                          child: CustomTextFormField(
                            controller: descriptionController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            hintText:
                                allTranslations.text("locationDetailsHint"),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                            validator: (value) {
                              if (value.length == 0) {
                                return allTranslations.text("fieldRequired");
                              }
                              return null;
                            },
                          ),
                        ),

                        /// search location

                        Positioned(
                          top: 130,
                          left: 10.r,
                          right: 10.r,
                          child: SearchMapPlaceWidget(
                            hasClearButton: true,
                            apiKey: "AIzaSyBAuQmLWRlS8VtG_8Q9lboVzR2bahdLeU8",
                            iconColor: Theme.of(context).colorScheme.secondary,
                            bgColor: Theme.of(context).primaryColor,
                            textColor:
                                Theme.of(context).textTheme.bodySmall!.color!,
                            placeType: PlaceType.establishment,
                            language: allTranslations.currentLanguage,
                            location: const LatLng(15.369445, 44.191006),
                            radius: 30000,
                            strictBounds: false,
                            placeholder: allTranslations.text('mapSearchHint'),
                            onSelected: (Place place) async {
                              geolocation = await place.geolocation;
                              mapController!.animateCamera(
                                  CameraUpdate.newLatLng(
                                      geolocation.coordinates));

                              mapController!.animateCamera(
                                  CameraUpdate.newLatLngBounds(
                                      geolocation.bounds, 100));

//                                mapController = await _mapController.future;
//                                 _selectedPlace = place;

//
//
                            },
                          ),
                        ),

                        /// button
                        Positioned(
                          bottom: 0,
                          right: 10.r,
                          left: 10.r,
                          child: CustomButtons(
                            text: allTranslations.text("save"),
                            textWidget: _isLoading == false
                                ? null
                                : const CircularLoading(),
                            buttonColor: chosenArea == ""
                                ? Colors.grey
                                : _isLoading == true
                                    ? Theme.of(context).colorScheme.surface
                                    : Theme.of(context).secondaryHeaderColor,
                            onTap: chosenArea == ""
                                ? CustomToast.showFlutterToast(
                                    context: context,
                                    message:
                                        allTranslations.text("chooseRegion"),
                                  )
                                : () async {
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    if (formKey.currentState!.validate()) {
                                      if (isMarkerSelected == false) {
                                        debugPrint(
                                            "/// isMarkerSelected = false");
                                        await getCurrentLocation();
                                        UserLocations location = UserLocations(
                                            name: placeName.toString(),
                                            desc: descriptionController.text,
                                            lat: position!.latitude.toString(),
                                            long:
                                                position!.longitude.toString(),
                                            areaId: chosenAreaId,
                                            phone:
                                                phoneController.text.toString(),
                                            location: optionalValue);
                                        await model.addLocation(location);

                                        if (model.isLoaded) {
                                          CustomDialog.showCustomDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              title: allTranslations
                                                  .text("locationSaved"),
                                              icon: lottie.Lottie.asset(
                                                AppLottie.checkMark,
                                                width: 100.w,
                                                height: 100.h,
                                                repeat: false,
                                              ),
                                              withNoButton: false,
                                              withActions: true,
                                              withYesButton: true,
                                              onPressed: () {
                                                if (widget.isFromCheckOut ==
                                                    true) {
                                                  pushScreenReplacement(context,
                                                      const CheckOutScreen());
                                                } else {
                                                  pushScreenReplacement(context,
                                                      const MyLocationsScreen());
                                                }

                                                CustomDialog.hideCustomDialog(
                                                    context);
                                              });
                                        } else {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        }
                                      } else {
                                        _onTapMarker(_lastMapPosition!);
                                        UserLocations location = UserLocations(
                                          name: placeName.toString(),
                                          desc: descriptionController.text
                                              .toString(),
                                          lat: _lastMapPosition!.latitude
                                              .toString(),
                                          long: _lastMapPosition!.longitude
                                              .toString(),
                                          areaId: chosenAreaId.toString(),
                                          phone:
                                              phoneController.text.toString(),
                                          location: optionalValue,
                                        );
                                        await model.addLocation(location);
                                        if (model.isLoaded) {
                                          CustomDialog.showCustomDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              title: allTranslations
                                                  .text("locationSaved"),
                                              icon: lottie.Lottie.asset(
                                                AppLottie.checkMark,
                                                width: 100.w,
                                                height: 100.h,
                                                repeat: false,
                                              ),
                                              withNoButton: false,
                                              withActions: true,
                                              withYesButton: true,
                                              onPressed: () {
                                                if (widget.isFromCheckOut ==
                                                    true) {
                                                  pushScreenReplacement(context,
                                                      const CheckOutScreen());
                                                } else {
                                                  pushScreenReplacement(context,
                                                      const MyLocationsScreen());
                                                }

                                                CustomDialog.hideCustomDialog(
                                                    context);
                                              });
                                        }
                                      }
                                    } else {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      formKey.currentState!.validate();
                                    }
                                  },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _goToCurrentLocation(GoogleMapController controller) async {
    final location = await Geolocator.getCurrentPosition();
    await controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(location.latitude, location.longitude),
          zoom: 14,
        ),
      ),
    );
    await _onTapMarker(LatLng(location.latitude, location.longitude));
  }
}
