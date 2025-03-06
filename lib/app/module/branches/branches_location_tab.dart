import 'dart:async';
import 'dart:ui' as ui;
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/core/values/app_icons.dart';
import 'package:alalamia_spices/app/core/values/app_images.dart';
import 'package:alalamia_spices/app/core/values/app_lottie.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../core/utils/constants.dart';
import 'package:alalamia_spices/app/exports/model.dart';

class BranchesLocationTab extends StatefulWidget {
  const BranchesLocationTab({super.key});

  @override
  State<BranchesLocationTab> createState() => _BranchesLocationTabState();
}

class _BranchesLocationTabState extends State<BranchesLocationTab>
    with WidgetsBindingObserver {
  final Completer<GoogleMapController> _controller = Completer();
  Position? position;
  BitmapDescriptor? sourceIcon;
  BitmapDescriptor? destinationIcon;
  BitmapDescriptor? pinLocationIcon;
  String? _darkMapStyle;
  String? _lightMapStyle;

  double pinPillPosition = -100;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  late Marker marker;
  Branches? currentlySelectedPin = Branches(name: '', phone: "988", email: "");
  Branches? branchInfo;
  Set<Marker> allMarkers = {};
  String? lat;
  String? long;
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  // List<AlalmiaBranches> allBranch = [
  //   AlalmiaBranches(
  //     id: "1",
  //     email: "alamiamatjer@gmail.com",
  //     phone: "+97142398885 - +971503360777",
  //     lat: " 25.114831805359607",
  //     long: "55.21343802471618",
  //     name: "البرشاء2",
  //     address: "شارع أم سقيم الشرقي - دبي",
  //   ),
  //
  //   AlalmiaBranches(
  //     id: "2",
  //     email: "alamiamatjer@gmail.com",
  //     phone: " +97124411339 - +971501154016",
  //     lat: "23.650849955469457",
  //     long: "53.70378735537919",
  //     name: "منطقة الظفرة",
  //     address: "مدينة زايد - ابوظبي",
  //   ),
  //
  //
  //   AlalmiaBranches(
  //     id: "3",
  //     email: "alamiamatjer@gmail.com",
  //     phone: "+97142216667  -  +971501156015",
  //     lat: "25.28554819943272",
  //     long: "55.351707640059075",
  //     name: "الممزر",
  //     address: "دبي",
  //   ),
  //
  //
  //   AlalmiaBranches(
  //     id: "4",
  //     email: "alamiamatjer@gmail.com",
  //     phone: "+13475000006",
  //     lat: "39.90274569217786",
  //     long: "-101.05408338804777",
  //     name: "نيويورك",
  //     address: "امريكا",
  //   ),
  //
  // ];
  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 2.0),
      AppIcons.marker,
    );
  }

  Future _loadMapStyles() async {
    _darkMapStyle =
        await rootBundle.loadString('assets/map_style/darkMapStyle.json');
    _lightMapStyle =
        await rootBundle.loadString('assets/map_style/lightMapStyle.json');
  }

  Future _setMapStyle(BuildContext context) async {
    var themeChange = Provider.of<ThemeModel>(context, listen: false);
    final controller = await _controller.future;
    // final theme = WidgetsBinding.instance.window.platformBrightness;
    if (themeChange.darkTheme == true) {
      controller.setMapStyle(_darkMapStyle);
    } else {
      controller.setMapStyle(_lightMapStyle);
    }
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {
      _setMapStyle(context);
    });
  }

  @override
  void initState() {
    super.initState();
    setCustomMapPin();
    setSourceAndDestinationIcons();
    marker = const Marker(markerId: MarkerId("2"));
    WidgetsBinding.instance.addObserver(this);
    _loadMapStyles();

    //fetchBranches();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void setSourceAndDestinationIcons() async {
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5, size: Size(100.w, 100.h)),
        AppImages.logo);
  }

  @override
  Widget build(BuildContext context) {
    // var networkStatus = Provider.of<NetworkStatus>(context);
    return Consumer<ConnectivityNotifier>(
      builder: (context, connection, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
            child: const CustomAppBar(
              isBranchesScreen: true,
            ),
          ),
          body: ChangeNotifierProvider<BranchesModel>(
            create: (context) => BranchesModel(context),
            child: Consumer<BranchesModel>(
              builder: (context, model, child) {
                return Stack(
                  children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0.w, vertical: 20.0.h),
                          child: Text(
                            allTranslations.text('sitesAndBranches'),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        )),
                    Positioned(
                      top: 70,
                      bottom: 10.0,
                      width: MediaQuery.of(context).size.width,
                      child: model.isLoading || model.loadingFailed
                          ? const CircularLoading()
                          : model.items.isEmpty
                              ? Center(
                                  child: CustomMessage(
                                    message: allTranslations.text("noData"),
                                    appLottieIcon: AppLottie.noData,
                                    repeat: false,
                                  ),
                                )
                              // : GoogleMap(
                              //     compassEnabled: true,
                              //     tiltGesturesEnabled: false,
                              //     mapType: MapType.normal,
                              //     markers: Set.from(allMarkers),
                              //     initialCameraPosition: CameraPosition(
                              //       target: position == null
                              //           ? LatLng(
                              //               double.parse(
                              //                   model.branch.lat.toString()),
                              //               double.parse(
                              //                   model.branch.long.toString()))
                              //           : LatLng(position!.latitude,
                              //               position!.longitude),
                              //       zoom: 8,
                              //     ),
                              //     onMapCreated:
                              //         (GoogleMapController controller) async {
                              //       _controller.complete(controller);
                              //       _setMapStyle(context);
                              //       for (int i = 0;
                              //           i < model.items.length;
                              //           i++) {
                              //         var markerIdval = model.items[i].id;
                              //         final MarkerId markerId =
                              //             MarkerId(markerIdval!);
                              //         final Uint8List markerIcon =
                              //             await getBytesFromAsset(
                              //                 AppIcons.marker, 120);
                              //         allMarkers.add(Marker(
                              //           markerId: markerId,
                              //           icon: BitmapDescriptor.fromBytes(
                              //               markerIcon),
                              //           position: LatLng(
                              //               double.parse(
                              //                   model.items[i].lat.toString()),
                              //               double.parse(model.items[i].long
                              //                   .toString())),
                              //           onTap: () {
                              //             branchInfo = Branches(
                              //                 name: model.items[i].name,
                              //                 email: model.items[i].email,
                              //                 phone: model.items[i].phone);
                              //             setState(() {
                              //               lat = model.items[i].lat;
                              //               long = model.items[i].long;
                              //               currentlySelectedPin = branchInfo;
                              //               pinPillPosition = 0;
                              //             });
                              //           },
                              //         ));
                              //         setState(() {
                              //           markers[markerId] = marker;
                              //         });
                              //       }
                              //     },
                              //     onTap: (LatLng location) {
                              //       setState(() {
                              //         pinPillPosition = -100;
                              //       });
                              //     },
                              //   ),
                              : ListView.builder(
                                  itemCount: model.items.length,
                                  itemBuilder: (context, index) => Card(
                                    child: ExpansionTile(
                                      leading: Icon(
                                        Icons.location_on_outlined,
                                      ),
                                      title: Text(
                                        "${model.items[index].name}",
                                      ),
                                      subtitle: Text(
                                        'اسم الفرع',
                                      ),
                                      children: [
                                        ListTile(
                                          leading: Icon(
                                            Icons.phone,
                                          ),
                                          title: Text(
                                            "${model.items[index].phone}",
                                          ),
                                          subtitle: Text(
                                            'رقم الهاتف',
                                          ),
                                        ),
                                        ListTile(
                                          leading: Icon(
                                            Icons.email,
                                          ),
                                          title: Text(
                                            "${model.items[index].email}",
                                          ),
                                          subtitle: Text(
                                            'البريد الالكتروني',
                                          ),
                                        ),
                                        // FilledButton(
                                        //     onPressed: () {
                                        //       branchInfo = Branches(
                                        //           name: model.items[index].name,
                                        //           email:
                                        //               model.items[index].email,
                                        //           phone:
                                        //               model.items[index].phone);
                                        //       lat = model.items[index].lat;
                                        //       long = model.items[index].long;
                                        //       currentlySelectedPin = branchInfo;
                                        //       MapsLauncher.launchCoordinates(
                                        //           double.parse(lat!),
                                        //           double.parse(long!));
                                        //     },
                                        //     child: Text("الذهاب للفرع"))
                                      ],
                                    ),
                                  ),
                                ),
                    ),
                    MapPinPillComponent(
                      pinPillPosition: pinPillPosition,
                      branch: currentlySelectedPin!,
                      onTap: () {
                        // for (int i = 0; i < allBranch.length; i++){
                        //
                        // }

                        MapsLauncher.launchCoordinates(
                            double.parse(lat!), double.parse(long!));
                      },
                    )
                  ],
                );
              },
            ),
          ),
          bottomNavigationBar:
              connection.hasConnection ? 0.ph : const NoInternetMessage(),
        );
      },
    );
  }
}
