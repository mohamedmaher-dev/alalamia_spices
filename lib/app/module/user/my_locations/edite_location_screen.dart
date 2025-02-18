//
// import 'dart:async';
// import 'package:alalamia_spices/app/core/utils/constants.dart';
// import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
// import 'package:alalamia_spices/app/core/values/app_lottie.dart';
// import 'package:alalamia_spices/app/exports/provider.dart';location.dart';
// import 'package:alalamia_spices/app/data/model/area_model.dart';
// import 'package:alalamia_spices/app/global_widgets/custom_app_bar.dart';
// import 'package:alalamia_spices/app/global_widgets/custom_dialog.dart';
// import 'package:alalamia_spices/app/global_widgets/custom_text_form_field.dart';
// import 'package:alalamia_spices/app/module/check_out/check_out_screen.dart';
// import 'package:alalamia_spices/app/module/user/my_locations/my_location_screen.dart';
// import 'package:alalamia_spices/app/exports/services.dart';/screen_navigation_service.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_geocoder/geocoder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:lottie/lottie.dart' as lottie;
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
// import 'package:provider/provider.dart';
// import '../../../data/model/location_model.dart';
// import '../../../data/model/themeModel.dart';
// import '../../../data/model/translations.dart';
// import '../../../global_widgets/circular_loading.dart';
// import '../../../global_widgets/custom_buttons.dart';
// import '../../../global_widgets/custom_card_icon_text.dart';
// import '../../../global_widgets/custom_two_text.dart';
//  import '../../../services/custom_dialog.dart';
// import '../../../services/custom_toast.dart';
// import '../../check_out/widget/location_details.dart';
//
// class EditeLocationScreen extends StatelessWidget {
//   final UserLocations locations;
//   const EditeLocationScreen({
//     Key? key,
//     required this.locations
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<AreaModel>(create: (context) => AreaModel(context),)
//       ],
//       child:   SubEditeLocation(locations: locations,),
//     );
//   }
// }
//
//
//
// class SubEditeLocation extends StatefulWidget {
//   final UserLocations locations;
//   const SubEditeLocation({
//     Key? key,
//     required this.locations
//   }) : super(key: key);
//
//   @override
//   State<SubEditeLocation> createState() => _SubEditeLocationState();
// }
//
// class _SubEditeLocationState extends State<SubEditeLocation> with WidgetsBindingObserver {
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
//
//   void getCurrentLocation() async {
//     Position res = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//     setState(() {
//       position = res;
//     });
//     final coordinators = Coordinates(position!.latitude, position!.longitude);
//     var address = await Geocoder.local.findAddressesFromCoordinates(coordinators);
//     var first = address.first;
//     placeName = ("${first.addressLine}").toString();
//   }
//
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
//     if (themeChange.darkTheme == true)
//       controller.setMapStyle(_darkMapStyle);
//     else
//       controller.setMapStyle(_lightMapStyle);
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
//
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
//   @override
//   void initState() {
//     super.initState();
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
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var areaModel = Provider.of<AreaModel>(context);
//
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Theme.of(context).backgroundColor,
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
//           child: const CustomAppBar(),
//         ),
//         body: ChangeNotifierProvider<LocationModel>(
//           create: (context) => LocationModel(context),
//           child: Consumer<LocationModel>(
//             builder: (context , model , child){
//               var defaultLocation = model.items.where((element) => element.location == 1).toList();
//               areaModel.getAreaList();
//               return GestureDetector(
//                 onTap: (){
//                   return FocusScope.of(context).unfocus();
//                 },
//                 child: Padding(
//                   padding: EdgeInsets.all(10.0.w),
//                   child: Form(
//                     key: formKey,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//
//                         /// choose region
//                         areaModel.isLoading || areaModel.loadingFailed
//                             ? const CircularLoading()
//                             : CustomCardIconText(
//                             color: Theme.of(context).primaryColor,
//                             icon: Icons.language,
//                             iconColor: Colors.grey,
//                             height: 40.h,
//                             width: 45.w,
//                             itemsName: allTranslations.text("chooseRegion"),
//                             subItemsName: chosenArea,
//                             itemsNameStyle: Theme.of(context).textTheme.bodyMedium!,
//                             secondIcon: Icons.arrow_forward_ios,
//                             secondIconColor: Colors.grey,
//                             onTap: () async{
//
//                               await showModalBottomSheet(
//                                   context: context,
//                                   elevation: 0.3,
//                                   isScrollControlled: false,
//                                   enableDrag: true,
//                                   shape:  RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.vertical(
//                                         top: Radius.circular(AppConstants.defaultBorderRadius.w)
//                                     ),
//                                   ),
//                                   builder: (context) {
//                                     return Padding(
//                                       padding: EdgeInsets.all(10.0.w),
//                                       child: Wrap(
//                                         crossAxisAlignment: WrapCrossAlignment.start,
//                                         runSpacing: 10.0.h,
//                                         runAlignment: WrapAlignment.spaceBetween,
//                                         children: [
//                                           Padding(
//                                             padding:  EdgeInsets.only(top: 10.0.w),
//                                             child: CustomTowText(
//                                               title: allTranslations.text("chooseRegion"),
//                                               subTitle: chosenArea,
//                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                               titleStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 22.sp
//
//                                               ),
//                                               subWidget: Padding(
//                                                 padding:  EdgeInsets.symmetric(horizontal: 5.0.w),
//                                                 child: InkWell(
//                                                   onTap: (){
//                                                     Navigator.of(context).pop();
//                                                   },
//                                                   child: Icon(
//                                                     Icons.close,
//                                                     size: 30,
//                                                     color: Theme.of(context).secondaryHeaderColor,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//
//                                           40.ph,
//
//                                           // DropdownSearch<String>(
//                                           //   popupProps:  PopupProps.modalBottomSheet(
//                                           //       isFilterOnline: true,
//                                           //       showSearchBox: true,
//                                           //       showSelectedItems: true,
//                                           //       searchFieldProps: TextFieldProps(
//                                           //           showCursor: true,
//                                           //           decoration: InputDecoration(
//                                           //             hintText: allTranslations.text("searchRegion"),
//                                           //             hintStyle: Theme.of(context).textTheme.caption,
//                                           //             border: OutlineInputBorder(
//                                           //                 borderRadius : BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                                           //                 borderSide: BorderSide(
//                                           //                     color: Theme.of(context).backgroundColor
//                                           //                 )
//                                           //             ),
//                                           //           )
//                                           //
//                                           //       )
//                                           //     // disabledItemFn: (String s) => s.startsWith('I'),
//                                           //   ),
//                                           //   items: areaModel.areaList,
//                                           //   dropdownDecoratorProps:  DropDownDecoratorProps(
//                                           //     dropdownSearchDecoration: InputDecoration(
//                                           //       border: OutlineInputBorder(
//                                           //           borderRadius : BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                                           //           borderSide: BorderSide(
//                                           //               color: Theme.of(context).secondaryHeaderColor
//                                           //           )
//                                           //       ),
//                                           //       // labelText: "Menu mode",
//                                           //       hintText: allTranslations.text("areas"),
//                                           //
//                                           //     ),
//                                           //   ),
//                                           //   onChanged: (value){
//                                           //
//                                           //     setState(() {
//                                           //       chosenArea = value;
//                                           //     });
//                                           //     for(var i = 0; i < areaModel.items.length; i++){
//                                           //       if(chosenArea == areaModel.items[i].name){
//                                           //         chosenAreaId = areaModel.items[i].stateId;
//                                           //
//                                           //       }
//                                           //     }
//                                           //
//                                           //     if(kDebugMode){
//                                           //       print("area id $chosenAreaId");
//                                           //       print("chosen area $chosenArea");
//                                           //     }
//                                           //   },
//                                           //   selectedItem: chosenArea,
//                                           // ),
//
//                                           // 20.ph,
//
//                                           CustomButtons(
//                                             height: 40.h,
//                                             text: allTranslations.text("save"),
//                                             buttonColor: Theme.of(context).secondaryHeaderColor,
//                                             onTap: () async {
//                                               Navigator.of(context).pop();
//                                             },
//                                           )
//                                         ],
//                                       ),
//                                     );
//                                   });
//
//                             }
//                         ),
//
//                         10.ph,
//
//
//                         /// phone text filed
//
//                         Container(
//                           padding: defaultLocation.isNotEmpty
//                               ? EdgeInsets.all(0.h)
//                               : EdgeInsets.symmetric(horizontal: 5.w , vertical: 5.h),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                               color: defaultLocation.isNotEmpty
//                                   ? Colors.transparent
//                                   : Theme.of(context).primaryColor
//                           ),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 4,
//                                 child: CustomTextFormField(
//                                   maxLines: 1,
//                                   // controller: phoneController,
//                                   initialValue: widget.locations.phone,
//                                   keyboardType: TextInputType.phone,
//                                   textInputAction: TextInputAction.next,
//                                   hintText: allTranslations.text("userPhone"),
//                                   contentPadding: EdgeInsets.symmetric(horizontal: 10.w , vertical: 5.h),
//                                   textStyle: Theme.of(context).textTheme.bodyMedium!!.copyWith(
//                                       fontFamily: "cairo",
//                                       fontSize: 12.sp
//                                   ),
//                                   validator: (value){
//                                     if (value.length == 0) {
//                                       return allTranslations.text('mostEnterPhone');
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                               ),
//
//
//
//
//
//                               model.isLoading || model.loadingFailed
//                                   ? const CircularLoading()
//                                   : defaultLocation.isNotEmpty
//                                   ? 0.ph
//                                   : StatefulBuilder(
//                                 builder: (context , mySetState){
//                                   return Expanded(
//                                     flex: 2,
//                                     child: CheckboxListTile(
//                                       dense: true,
//                                       contentPadding: EdgeInsets.all(0.h),
//                                       title: Text(
//                                         allTranslations.text("default"),
//                                         style: Theme.of(context).textTheme.caption,
//                                       ),
//                                       value: checkedValue,
//                                       checkboxShape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                                       ),
//                                       onChanged: (newValue) {
//                                         mySetState(() {
//                                           checkedValue = newValue!;
//                                           checkedValue == true
//                                               ? optionalValue = 1
//                                               : optionalValue = 0;
//                                         });
//                                         if(kDebugMode){
//                                           print("optional =  $optionalValue");
//                                         }
//                                       },
//                                       controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
//                                     ),
//                                   );
//                                 },
//                               )
//                             ],
//                           ),
//                         ),
//
//
//                         10.ph,
//                         /// description text filed
//
//                         CustomTextFormField(
//                           // controller: descriptionController,
//                           initialValue: widget.locations.desc,
//                           keyboardType: TextInputType.text,
//                           textInputAction: TextInputAction.done,
//                           hintText: allTranslations.text("locationDetailsHint"),
//                           contentPadding: EdgeInsets.symmetric(horizontal: 10.w , vertical: 5.h),
//                           validator: (value) {
//                             if (value.length == 0) {
//                               return allTranslations.text("fieldRequired");
//                             }
//                             return null;
//                           },
//                         ),
//
//                         10.ph,
//                         /// Google Maps
//                         Expanded(
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
//                         5.ph,
//                         CustomButtons(
//                           text: allTranslations.text("save"),
//                           textWidget: _isLoading == false
//                               ? null
//                               : const CircularLoading(),
//                           buttonColor: chosenArea == ""
//                               ? Colors.grey
//                               : _isLoading == true
//                               ? Theme.of(context).backgroundColor
//                               : Theme.of(context).secondaryHeaderColor,
//                           onTap: chosenArea == ""
//                               ? CustomToast.showFlutterToast(
//                             context: context,
//                             message: allTranslations.text("chooseRegion"),
//                           )
//                               : () async{
//                             setState((){
//                               _isLoading = true;
//                             });
//                             if(formKey.currentState!.validate()){
//
//                               if(isMarkerSelected == false){
//                                 if (kDebugMode) {
//                                   print("/// isMarkerSelected = false");
//                                 }
//                                 getCurrentLocation();
//                                 UserLocations location =
//                                 UserLocations(
//                                     name: placeName.toString(),
//                                     desc: descriptionController.text,
//                                     lat: position!.latitude.toString(),
//                                     long: position!.longitude.toString(),
//                                     areaId: chosenAreaId,
//                                     phone: phoneController.text.toString(),
//                                     location: optionalValue
//                                 );
//                                 await model.addLocation(location);
//
//                                 if (model.isLoaded) {
//
//                                   await showDialog(
//                                       context: context,
//                                       builder: (BuildContext context){
//
//                                         return  CustomDialogWidget(
//                                           title: Text(
//                                             allTranslations.text("locationSaved"),
//                                             style: Theme.of(context).textTheme.bodyMedium!!.copyWith(
//                                                 fontSize: 16.sp,
//                                                 fontWeight: FontWeight.bold
//                                             ),
//                                           ),
//                                           content: lottie.Lottie.asset(
//                                             AppLottie.checkMark,
//                                             width: 100.w,
//                                             height: 100.h,
//                                             repeat: false,
//                                           ),
//                                           withActions: true,
//                                           withYesButton: true,
//                                           onPressed: () {
//                                             pushScreenReplacement(context, const MyLocationsScreen(
//                                               fromAddUserLocation: true,
//                                             ));
//                                           },
//                                         );
//                                       }
//                                   );
//
//
//
//
//                                  //  Future.delayed(const Duration(seconds: 2) , () {
//                                  // PersistentNavBarNavigator.pushNewScreen(
//                                  //      context,
//                                  //      screen:  const MyLocationsScreen(),
//                                  //      withNavBar: false, // OPTIONAL VALUE. True by default.
//                                  //      pageTransitionAnimation: PageTransitionAnimation.cupertino,
//                                  //    );
//                                  //    Navigator.pop(context);
//                                  //  });
//
//
//
//                                 }else {
//                                   setState((){
//                                     _isLoading = false;
//                                   });
//                                 }
//                               } else{
//                                 _onTapMarker(_lastMapPosition!);
//                                 UserLocations location = UserLocations(
//                                     name: placeName,
//                                     desc:  descriptionController.text,
//                                     lat: _lastMapPosition!.latitude.toString(),
//                                     long:  _lastMapPosition!.longitude.toString(),
//                                     areaId: chosenAreaId,
//                                     phone: phoneController.text.toString(),
//                                     location: optionalValue
//                                 );
//
//                                 await model.addLocation(location);
//                                 if (model.isLoaded) {
//                                   CustomDialogWidget(
//                                     title: Text(
//                                       allTranslations.text("locationSaved"),
//                                       style: Theme.of(context).textTheme.bodyMedium!!.copyWith(
//                                           fontSize: 16.sp,
//                                           fontWeight: FontWeight.bold
//                                       ),
//                                     ),
//                                     content: lottie.Lottie.asset(
//                                       AppLottie.checkMark,
//                                       width: 100.w,
//                                       height: 100.h,
//                                       repeat: false,
//                                     ),
//                                   );
//
//                                   Future.delayed(const Duration(seconds: 2) , () {
//                               PersistentNavBarNavigator.pushNewScreen(
//                                       context,
//                                       screen:  const MyLocationsScreen(
//                                         fromAddUserLocation: true,
//                                       ),
//                                       withNavBar: false, // OPTIONAL VALUE. True by default.
//                                       pageTransitionAnimation: PageTransitionAnimation.cupertino,
//                                     );
//                                     Navigator.pop(context);
//                                   });
//                                 }
//                               }
//                             }
//                             else {
//                               setState((){
//                                 _isLoading = false;
//                               });
//                               formKey.currentState!.validate();
//                             }
//                           },
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:provider/provider.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';
import '../../../core/utils/constants.dart';
import '../../../core/values/app_lottie.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import '../../../services/screen_navigation_service.dart';
import '../../check_out/widget/location_details.dart';
import 'my_location_screen.dart';
import 'package:alalamia_spices/app/exports/model.dart';

class EditeLocationScreen extends StatelessWidget {
  final UserLocations locations;
  const EditeLocationScreen({super.key, required this.locations});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AreaModel>(
          create: (context) => AreaModel(context),
        )
      ],
      child: SubEditeLocation(
        locations: locations,
      ),
    );
  }
}

class SubEditeLocation extends StatefulWidget {
  final UserLocations locations;
  const SubEditeLocation({super.key, required this.locations});

  @override
  State<SubEditeLocation> createState() => _SubEditeLocationState();
}

class _SubEditeLocationState extends State<SubEditeLocation>
    with WidgetsBindingObserver {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GoogleMapController? mapController;
  Completer<GoogleMapController> mapControllerCompleter = Completer();
  late Position position;
  String? chosenArea;
  // String? chosenAreaId;
  String? _darkMapStyle;
  String? _lightMapStyle;
  LatLng? _lastMapPosition;
  String? placeName;
  bool _isLoading = false;
  int optionalValue = 0;
  bool checkedValue = false;
  String userPhone = '';
  bool isMarkerSelected = false;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  final GlobalKey<FormState> formKey = GlobalKey();
  var geolocation;

//   Future checkGps() async {
// //    isGpsEnabled = await geolocator.Geolocator().isLocationServiceEnabled();
//     bool isGpsEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!(isGpsEnabled)) {
//       if (Theme.of(context).platform == TargetPlatform.android) {
//         CustomDialog().showCustomDialog(
//             context: context,
//             title: Text(
//                 allTranslations.text('locationMessage'),
//               style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                 fontWeight: FontWeight.bold
//               ),
//             ),
//           content: Text(
//               allTranslations.text('locationMessageSub'),
//             style: Theme.of(context).textTheme.bodyMedium!,
//           ),
//           withActions: true,
//           withYesButton: true,
//           onPressed: () {
//             const  AndroidIntent intent =  AndroidIntent(
//                 action: 'android.settings.LOCATION_SOURCE_SETTINGS');
//             intent.launch();
//             Navigator.of(context, rootNavigator: true).pop();
//           }
//         );
//
//       }
//     }
//   }

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      throw Exception('Error');
    }
    return await Geolocator.getCurrentPosition();
  }

  // void locatePosition() async {
  //   bool islocationserviceenabled = await Geolocator.isLocationServiceEnabled();
  //
  //   await Geolocator.checkPermission();
  //   await Geolocator.requestPermission();
  //
  //   Position res = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   setState(() {
  //     position = res;
  //   });
  //   final coordinators = Coordinates(position!.latitude, position!.longitude);
  //   var address = await Geocoder.local.findAddressesFromCoordinates(coordinators);
  //   var first = address.first;
  //   placeName = ("${first.addressLine}").toString();
  //
  //   // ask permission from device
  //   // Future<void> requestPermission() async {
  //   //   await islocationserviceenabled.location.request();
  //   // }
  // }

  void getCurrentLocation() async {
    Position res = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      position = res;
    });
    var address =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    var first = address.first;
    placeName = ("${first.thoroughfare}").toString();
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
    final theme = WidgetsBinding.instance.window.platformBrightness;
    if (themeChange.darkTheme == true)
      controller.setMapStyle(_darkMapStyle);
    else
      controller.setMapStyle(_lightMapStyle);
  }

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

  void _onTapMarker(LatLng tapped) async {
    setState(() {
      isMarkerSelected = true;
      _lastMapPosition = tapped;

      debugPrint(tapped.longitude.toString() + tapped.latitude.toString());
    });

    getMarkers(tapped.latitude, tapped.longitude);
    var address =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    var first = address.first;
    placeName = ("${first.thoroughfare}").toString();
  }

  @override
  void initState() {
    super.initState();
    // checkGps();
    getCurrentLocation();
    determinePosition();
    // locatePosition();
    WidgetsBinding.instance.addObserver(this);
    _loadMapStyles();
    // position = Position(
    //     longitude: double.parse(widget.locations.long.toString()),
    //     latitude: double.parse(widget.locations.lat.toString()),
    //     timestamp: timestamp,
    //     accuracy: accuracy,
    //     altitude: altitude,
    //     heading: heading,
    //     speed: speed,
    //     speedAccuracy: speedAccuracy
    // );
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
    debugPrint("place name $placeName");
    debugPrint("idddddddd ${widget.locations.id.toString()}");

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
          child: const CustomAppBar(),
        ),
        body: ChangeNotifierProvider<LocationModel>(
          create: (context) => LocationModel(context),
          child: Consumer2<LocationModel, UserModel>(
            builder: (context, model, userModel, child) {
              var defaultLocation = model.items
                  .where((element) => element.location == 1)
                  .toList();
              userModel.isLoading || userModel.loadingFailed
                  ? ""
                  : userPhone = userModel.user.phone!.split("+967").last;
              return GestureDetector(
                onTap: () {
                  return FocusScope.of(context).unfocus();
                },
                child: Form(
                  key: formKey,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
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
                            tiltGesturesEnabled: false,
                            minMaxZoomPreference:
                                const MinMaxZoomPreference(13, 17),
                            initialCameraPosition: CameraPosition(
                                bearing: 192.8334901395799,
                                target: LatLng(
                                    double.parse(
                                        widget.locations.lat.toString()),
                                    double.parse(
                                        widget.locations.long.toString())),
                                tilt: 59.440717697143555,
                                zoom: 14),
                            markers: Set<Marker>.of(markers.values),
                            onTap: _onTapMarker,
                            onMapCreated: (GoogleMapController controller) {
                              mapController = controller;
                              mapControllerCompleter.complete(controller);
                              _setMapStyle(context);
                            },
                          ),
                        ),

                        /// phone text filed

                        Positioned(
                          top: 10,
                          left: 10,
                          right: 10,
                          child: CustomTextFormField(
                            maxLines: 1,
                            // controller: phoneController,
                            initialValue: widget.locations.phone,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            hintText: allTranslations.text("userPhone"),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontFamily: "cairo", fontSize: 12.sp),
                            onChanged: (value) {
                              phoneController.text = value;
                            },
                            validator: (value) {
                              if (value.length == 0) {
                                return allTranslations.text('mostEnterPhone');
                              }
                              return null;
                            },
                          ),
                        ),

                        /// description text filed

                        Positioned(
                          top: 70,
                          left: 10,
                          right: 10,
                          child: CustomTextFormField(
                            initialValue: widget.locations.desc,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            hintText:
                                allTranslations.text("locationDetailsHint"),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                            onChanged: (value) {
                              descriptionController.text = value;
                            },
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
                          left: 10,
                          right: 10,
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
                          right: 10,
                          left: 10,
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
                                      if (formKey.currentState!.validate()) {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        _onTapMarker(_lastMapPosition == null
                                            ? LatLng(
                                                double.parse(widget
                                                    .locations.lat
                                                    .toString()),
                                                double.parse(widget
                                                    .locations.long
                                                    .toString()))
                                            : _lastMapPosition!);

                                        UserLocations location = UserLocations(
                                            name: placeName.toString(),
                                            desc: descriptionController
                                                    .text.isEmpty
                                                ? widget.locations.desc
                                                : descriptionController.text,
                                            lat: _lastMapPosition!
                                                        .latitude !=
                                                    0.0
                                                ? _lastMapPosition!.latitude
                                                    .toString()
                                                : widget
                                                    .locations.lat
                                                    .toString(),
                                            long:
                                                _lastMapPosition!
                                                            .longitude !=
                                                        0.0
                                                    ? _lastMapPosition!
                                                        .longitude
                                                        .toString()
                                                    : widget.locations.long
                                                        .toString(),
                                            areaId: chosenAreaId ?? "4",
                                            phone: phoneController.text.isEmpty
                                                ? widget.locations.phone
                                                : phoneController.text,
                                            location:
                                                widget.locations.location);

                                        await model.edit(location,
                                            widget.locations.id.toString());
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
                                                pushScreenReplacement(context,
                                                    const MyLocationsScreen());
                                                CustomLoadingDialog.hideLoading(
                                                    context);
                                              });
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        } else {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        }
                                        // if(isMarkerSelected == false){
                                        //
                                        //   getCurrentLocation();
                                        //   UserLocations location =
                                        //   UserLocations(
                                        //       name: placeName.toString(),
                                        //       desc: descriptionController.text.isEmpty  ? widget.locations.desc : descriptionController.text,
                                        //       lat: position.latitude.toString() ,
                                        //       long: position.longitude.toString(),
                                        //       areaId: chosenAreaId ?? "4",
                                        //       phone: phoneController.text.isEmpty  ? widget.locations.phone : phoneController.text,
                                        //       location: optionalValue
                                        //   );
                                        //   await model.edit(location , location.id.toString());
                                        //
                                        //   if (model.isLoaded) {
                                        //
                                        //     setState((){
                                        //       _isLoading = false;
                                        //     });
                                        //
                                        //     await showDialog(
                                        //         context: context,
                                        //         builder: (BuildContext context){
                                        //
                                        //           return CustomDialogWidget(
                                        //               title: Text(
                                        //                 allTranslations.text("locationSaved"),
                                        //                 style: Theme.of(context).textTheme.bodyMedium!!.copyWith(
                                        //                     fontSize: 16.sp,
                                        //                     fontWeight: FontWeight.bold
                                        //                 ),
                                        //               ),
                                        //               content: lottie.Lottie.asset(
                                        //                 AppLottie.checkMark,
                                        //                 width: 100.w,
                                        //                 height: 100.h,
                                        //                 repeat: false,
                                        //               ),
                                        //
                                        //               withNoButton: false,
                                        //               withActions: true,
                                        //               withYesButton: true,
                                        //               onPressed: (){
                                        //                 pushScreenReplacement(context, const MyLocationsScreen(
                                        //                   fromAddUserLocation: true,
                                        //                 ));
                                        //               }
                                        //           );
                                        //         }
                                        //     );
                                        //
                                        //
                                        //
                                        //   }else {
                                        //     setState((){
                                        //       _isLoading = false;
                                        //     });
                                        //   }
                                        // }
                                        // else{
                                        //
                                        // }
                                      } else {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        formKey.currentState!.validate();
                                      }
                                    }),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
