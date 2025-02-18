import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constants.dart';
import '../../user/my_locations/add_new_location_screen.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';

String? chosenAreaId;
String? currentLocationId;
String? chosenLocationId;
String? chosenLocationName;
String? chosenLat;
String? chosenLong;

class LocationDetails extends StatefulWidget {
  const LocationDetails({
    super.key,
  });

  @override
  State<LocationDetails> createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  bool isLocationHidden = false;
  String chosenLocation = '';
  String? chosenLocationAreaId;
  // String? chosenLocationId;
  String? currentLocationName;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<LocationModel>(
      create: (context) => LocationModel(context),
      child: Consumer<LocationModel>(
        builder: (context, locationModel, child) {
          locationModel.getLocationsList(context);
          _setDefLocation(locationModel);
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCardIconText(
                  icon: CupertinoIcons.location,
                  iconColor: Colors.grey,
                  itemsName: allTranslations.text("shippingDetails"),
                  borderRadius: BorderRadius.only(
                    topRight:
                        Radius.circular(AppConstants.defaultBorderRadius.w),
                    topLeft:
                        Radius.circular(AppConstants.defaultBorderRadius.w),
                  ),
                  onTap: _toggleLocation),

              /// choose location
              Container(
                width: size.width,
                padding: EdgeInsets.all(10.0.w),
                color: Theme.of(context).primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                allTranslations.text("chooseYourLocation"),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              CustomButtons(
                                text: allTranslations.text("addNewLocation"),
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        decoration: TextDecoration.underline),
                                buttonColor: Colors.transparent,
                                onTap: () {
                                  pushScreenReplacement(
                                      context,
                                      const AddNewLocationScreen(
                                        isFromCheckOut: true,
                                      ));
                                },
                              ),
                            ],
                          ),
                          15.ph,
                          locationModel.isLoading || locationModel.loadingFailed
                              ? const CircularLoading()
                              : CustomDropDown(
                                  listItem: locationModel
                                      .uniqueLocations.reversed
                                      .toList(),
                                  value: chosenLocationName ?? "",
                                  hintText: locationModel.items.isEmpty
                                      ? allTranslations.text("noLocation")
                                      : allTranslations.text("myLocations"),
                                  fillColor: Theme.of(context).primaryColor,
                                  onChanged: (value) {
                                    setState(() {
                                      chosenLocation = value.toString();
                                      chosenLocationName = value.toString();
                                      locationModel.currentLocation =
                                          value.toString();
                                    });

                                    for (var i = 0;
                                        i < locationModel.items.length;
                                        i++) {
                                      if (chosenLocation ==
                                          locationModel.items[i].name) {
                                        chosenLocationAreaId =
                                            locationModel.items[i].areaId;
                                        chosenLocation =
                                            locationModel.items[i].name;
                                        chosenLocationId =
                                            locationModel.items[i].id;
                                        chosenAreaId = chosenLocationAreaId;
                                        currentLocationId = null;
                                        chosenLat = locationModel.items[i].lat
                                            .toString();
                                        chosenLong = locationModel.items[i].long
                                            .toString();
                                      }
                                    }

                                    if (kDebugMode) {
                                      // debugPrint("**** selected area id $chosenLocationAreaId");
                                      debugPrint(
                                          "**** selected location id $chosenLocationId");
                                      debugPrint(
                                          "**** selected location  $chosenLocation");
                                    }
                                  })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _setDefLocation(LocationModel locationModel) {
    if (locationModel.defaultLocation != null) {
      chosenLocation = locationModel.defaultLocation.toString();
      chosenLocationName = locationModel.defaultLocation.toString();
      locationModel.currentLocation = locationModel.defaultLocation.toString();
    } else {
      if (locationModel.currentLocation != null) {
        chosenLocation = locationModel.currentLocation.toString();
        chosenLocationName = locationModel.currentLocation.toString();
        locationModel.currentLocation =
            locationModel.currentLocation.toString();
      }
    }
    for (var i = 0; i < locationModel.items.length; i++) {
      if (chosenLocation == locationModel.items[i].name) {
        chosenLocationAreaId = locationModel.items[i].areaId;
        chosenLocation = locationModel.items[i].name;
        chosenLocationId = locationModel.items[i].id;
        chosenAreaId = chosenLocationAreaId;
        currentLocationId = null;
        chosenLat = locationModel.items[i].lat.toString();
        chosenLong = locationModel.items[i].long.toString();
      }
    }
  }

  void _toggleLocation() {
    setState(() {
      isLocationHidden = !isLocationHidden;
    });
  }
}
