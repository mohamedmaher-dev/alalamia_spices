// ignore_for_file: use_build_context_synchronously

import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/module/app_config/provider/app_config_provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../core/utils/route.dart';
import '../../core/values/app_images.dart';
import 'package:alalamia_spices/app/exports/provider.dart';

import '../../services/screen_navigation_service.dart';

String? countryName;
String? countryImage;
String countryId = "";

class AppConfigScreen extends StatefulWidget {
  const AppConfigScreen({super.key});

  @override
  State<AppConfigScreen> createState() => _AppConfigScreenState();
}

class _AppConfigScreenState extends State<AppConfigScreen> {
  bool isSwitched = false;
  int selectedCountry = -1;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      Provider.of<AppConfigProvider>(context, listen: false).saveFirstSeen();
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeChange = Provider.of<ThemeModel>(context);
    var countriesModel = Provider.of<CountriesModel>(context);
    return ChangeNotifierProvider<ConnectivityNotifier>(
      create: (context) => ConnectivityNotifier(),
      child: Consumer<ConnectivityNotifier>(
        builder: (context, connection, child) {
          void selectCountryIfMethod(Placemark place) {
            if (place.isoCountryCode == 'SA') {
              selectedCountry = 0;
              countryName = 'السعودية - KSA';
              countryId = '3';
              countryImage =
                  'https://api.alalamiastore.com/storage/country/360/Alalamia_1715783858.png';
              countriesModel.saveCountryCode(
                initialCountry: 'SA',
                dialCode: '550197770',
                countryId: countryId,
              );
            } else {
              selectedCountry = 1;
              countryName = 'الإمارات - UAE';
              countryId = '2';
              countryImage =
                  'https://api.alalamiastore.com/storage/country/360/Alalamia_1715783396.png';
              countriesModel.saveCountryCode(
                initialCountry: 'AE',
                dialCode: '503360777',
                countryId: countryId,
              );
            }
          }

          Future<bool> selectCountry(BuildContext context) async {
            bool permission = await checkPermission(context);
            if (permission) {
              Position position = await Geolocator.getCurrentPosition();
              List<Placemark> placemarks = await placemarkFromCoordinates(
                  position.latitude, position.longitude);
              Placemark place = placemarks.first;
              selectCountryIfMethod(place);
              countriesModel.saveCountryDetails(
                id: countryId,
                name: countryName!,
                image: countryImage!,
              );
              countriesModel.getCountryCode();
              countriesModel.getCountryDetails();
              return true;
            } else {
              return false;
            }
          }

          return SafeArea(
            child: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              body: Padding(
                padding: EdgeInsets.only(top: 50.0.h, left: 10.w, right: 10.w),
                child: ListView(
                  children: [
                    Text(
                      allTranslations.text("welcome"),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 26.sp),
                    ),
                    3.ph,
                    Text(
                      allTranslations.text("appConfigSubTitle"),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),

                    20.ph,
                    Image.asset(
                      AppImages.logo,
                      height: 200.h,
                    ),
                    10.ph,
                    CustomCardIconText(
                        color: Theme.of(context).primaryColor,
                        icon: Icons.sign_language_rounded,
                        iconColor: Colors.grey,
                        height: 40.h,
                        width: 45.w,
                        itemsName: allTranslations.text("language"),
                        subItemsName: allTranslations.currentLanguage == "ar"
                            ? "العربية"
                            : "English",
                        secondIcon: Icons.arrow_forward_ios,
                        secondIconColor: Colors.grey,
                        onTap: () async {
                          await LanguageBottomSheet()
                              .showLanguageBottomSheet(context: context);
                        }),

                    20.ph,

                    /// theme mode
                    CustomCardIconText(
                        color: Theme.of(context).primaryColor,
                        icon: Icons.theater_comedy,
                        iconColor: Colors.grey,
                        height: 40.h,
                        width: 45.w,
                        itemsName: allTranslations.text("themeMode"),
                        secondWidget: FlutterSwitch(
                            width: 60.0.w,
                            height: 30.0.h,
                            toggleSize: 35.0,
                            value: themeChange.darkTheme,
                            borderRadius: 30.0,
                            padding: 2.0,
                            inactiveIcon: const Icon(CupertinoIcons.sun_max),
                            activeIcon: const Icon(CupertinoIcons.moon),
                            toggleColor: Theme.of(context)
                                .secondaryHeaderColor
                                .withOpacity(0.5),
                            activeColor:
                                Theme.of(context).colorScheme.secondary,
                            inactiveColor:
                                Theme.of(context).colorScheme.surface,
                            onToggle: (val) {
                              setState(() {
                                themeChange.darkTheme = val;
                              });
                              if (kDebugMode) {
                                print(val);
                              }
                            })),
                  ],
                ),
              ),
              bottomNavigationBar: connection.hasConnection
                  ? Padding(
                      padding: EdgeInsets.all(10.0.w),
                      child: CustomButtons(
                          height: 45.h,
                          text: allTranslations.text("continue"),
                          textStyle: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(fontSize: 18.sp),
                          buttonColor: Theme.of(context).secondaryHeaderColor,
                          onTap: () async {
                            final bool isSelected =
                                await selectCountry(context);
                            if (isSelected) {
                              pushNamedReplacement(
                                  context, Routes.onboardingScreen);
                            }
                          }),
                    )
                  : const NoInternetMessage(),
            ),
          );
        },
      ),
    );
  }
}

Future<bool> checkPermission(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (serviceEnabled) {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      await openAppSettings();
      permission = await Geolocator.checkPermission();
      return await _perrmissionToBool(permission);
    } else if (permission == LocationPermission.denied) {
      await Geolocator.openAppSettings();
      permission = await Geolocator.requestPermission();
      return await _perrmissionToBool(permission);
    } else {
      return true;
    }
  } else {
    await Geolocator.openLocationSettings();
    return false;
  }
}

Future<bool> _perrmissionToBool(LocationPermission permission) async {
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    return false;
  } else {
    return true;
  }
}
