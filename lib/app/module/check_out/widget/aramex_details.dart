import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/core/utils/input_validators.dart';
import 'package:alalamia_spices/app/data/providers/cartModel.dart';
import 'package:alalamia_spices/app/data/providers/translations.dart';
import 'package:alalamia_spices/app/data/providers/userModel.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/module/app_config/app_config_screen.dart';
import 'package:alalamia_spices/app/module/check_out/providers/checkout_form_provider.dart';
import 'package:alalamia_spices/app/module/check_out/widget/iata_codes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import '../../../data/model/aramex_shipment.dart';
import '../../../data/providers/shipping/aramex_provider.dart';
import '../../bill/bill_screen.dart';
import 'location_details.dart';

class AramexDetails extends StatelessWidget {
  final bool canChangeCountry;
  final bool selectedAramex;
  const AramexDetails(
      {super.key,
      required this.selectedAramex,
      required this.canChangeCountry});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CheckoutFormProvider()),
        ChangeNotifierProvider(create: (context) => AramexProvider()),
      ],
      child: AramexForm(
        selectedAramex: selectedAramex,
        canChangeCountry: canChangeCountry,
      ),
    );
  }
}

class AramexForm extends StatefulWidget {
  final bool canChangeCountry;
  final bool selectedAramex;
  const AramexForm(
      {super.key,
      required this.selectedAramex,
      required this.canChangeCountry});

  @override
  State<AramexForm> createState() => _AramexFormState();
}

class _AramexFormState extends State<AramexForm> {
  LatLng? _doneLocation;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserModel>(context)..getUserInfo();
    final formProvider = Provider.of<CheckoutFormProvider>(context);
    final aramexProvider = Provider.of<AramexProvider>(context);
    final cartModel = Provider.of<CartModel>(context);
    LatLng moviedLocation =
        LatLng(double.parse(chosenLat!), double.parse(chosenLong!));

    // debugPrint("tootal quantity ${cartModel.totalQuantity}");
    final starIcon = Icon(
      CupertinoIcons.staroflife_fill,
      color: Colors.red,
      size: 10.r,
    );
    String iso = "";
    String dialCode = '';
    if (userProvider.userCountry == "الإمارات - UAE") {
      iso = "AE";
      dialCode = "+971";
    } else if (userProvider.userCountry == "السعودية - KSA") {
      iso = "SA";
      dialCode = "+966";
    }
    return Form(
      key: formProvider.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          /// name
          // TextFormFieldWithName(
          //   controller: formProvider.recipientNameController,
          //   hintTextFormField: allTranslations.text("recipientName"),
          //   fieldName: allTranslations.text("recipientName"),
          //   keyboardType: TextInputType.text,
          //   textInputAction: TextInputAction.next,
          //   fieldRequired: starIcon,
          //   onFieldSubmitted: () {
          //     FocusScope.of(context).nextFocus();
          //   },
          //   validator: (value) => InputValidators.validateRequired(value),
          // ),
          // 15.ph,

          /// location
          if (!widget.canChangeCountry)
            TextFormFieldWithName(
              hintTextFormField: chosenLocationName.toString(),
              readOnly: true,
              fieldName: allTranslations.text("location"),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),

          if (!widget.canChangeCountry) 15.ph,

          /// country
          if (!widget.canChangeCountry)
            TextFormFieldWithName(
              readOnly: true,
              hintTextFormField: userProvider.userCountry,
              fieldName: allTranslations.text("currentCountry"),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),

          if (!widget.canChangeCountry) 15.ph,

          /// city
          if (!widget.canChangeCountry)
            TextFormFieldWithName(
              controller: formProvider.cityController,
              hintTextFormField: allTranslations.text("enterCityName"),
              fieldName: allTranslations.text("city"),
              keyboardType: TextInputType.text,
              fieldRequired: starIcon,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: () {
                FocusScope.of(context).nextFocus();
              },
              validator: (value) => InputValidators.validateRequired(value),
            ),
          if (!widget.canChangeCountry) 15.ph,
          if (widget.canChangeCountry)
            Center(
              child: FilledButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _doneLocation == null ? null : Colors.green),
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (context) => Scaffold(
                              floatingActionButtonLocation:
                                  FloatingActionButtonLocation.centerFloat,
                              floatingActionButton: FloatingActionButton(
                                child: const Icon(Icons.done_all),
                                onPressed: () {
                                  setState(() {
                                    _doneLocation = moviedLocation;
                                    chosenLat =
                                        moviedLocation.latitude.toString();
                                    chosenLong =
                                        moviedLocation.longitude.toString();
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                              body: Stack(
                                children: [
                                  GoogleMap(
                                    onCameraMove: (position) =>
                                        moviedLocation = position.target,
                                    initialCameraPosition: CameraPosition(
                                        zoom: 12, target: moviedLocation),
                                  ),
                                  Center(
                                    child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black.withAlpha(100)),
                                        child: CircleAvatar(radius: 5)),
                                  ),
                                ],
                              ),
                            ));
                    setState(() {});
                  },
                  icon:
                      Icon(_doneLocation == null ? Icons.add : Icons.done_all),
                  label: _doneLocation == null
                      ? Text("قم بتحديد الموقع")
                      : Text("تم تحديد الموقع بنجاح")),
            ),
          15.ph,

          /// phone
          // CustomInternationalPhoneNumber(
          //   textInputAction: TextInputAction.next,
          //   fieldName: true,
          //   textEditingController: formProvider.phoneController,
          //   fieldRequired: starIcon,
          //   onInputChanged: (PhoneNumber number) {
          //     debugPrint("$number");
          //   },
          //   initialValue: PhoneNumber(isoCode: iso, dialCode: dialCode),
          // ),

          // 15.ph,

          /// email
          // TextFormFieldWithName(
          //   controller: formProvider.emailController,
          //   hintTextFormField: allTranslations.text("email"),
          //   fieldName: allTranslations.text("email"),
          //   keyboardType: TextInputType.emailAddress,
          //   textInputAction: TextInputAction.next,
          //   fieldRequired: starIcon,
          //   onFieldSubmitted: () {
          //     FocusScope.of(context).nextFocus();
          //   },
          //   validator: (value) => InputValidators.validateEmail(value),
          // ),

          // 15.ph,

          /// address
          // TextFormFieldWithName(
          //   controller: formProvider.addressController,
          //   hintTextFormField: allTranslations.text("address"),
          //   fieldName: allTranslations.text("address"),
          //   keyboardType: TextInputType.text,
          //   textInputAction: TextInputAction.next,
          //   fieldRequired: starIcon,
          //   onFieldSubmitted: () {
          //     FocusScope.of(context).nextFocus();
          //   },
          //   validator: (value) => InputValidators.validateRequired(value),
          // ),

          // 15.ph,

          /// nearest landmark
          // TextFormFieldWithName(
          //   controller: formProvider.nearestLandmarkController,
          //   hintTextFormField: allTranslations.text("nearestLandmark"),
          //   fieldName: allTranslations.text("nearestLandmark"),
          //   keyboardType: TextInputType.text,
          //   textInputAction: TextInputAction.done,
          //   onFieldSubmitted: () {
          //     FocusScope.of(context).unfocus();
          //   },
          // ),

          // 15.ph,

          if (widget.selectedAramex == true)
            Visibility(
              visible: getVisible(),
              replacement: CustomButtons(
                text: "قم بتحديد الموقع",
                buttonColor: Colors.grey,
              ),
              child: CustomButtons(
                height: 45.h,
                isLoading: aramexProvider.calculateLoading,
                text: allTranslations.text("continuePurchasing"),
                buttonColor: Theme.of(context).secondaryHeaderColor,
                textStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: "cairo",
                      fontSize: 12.sp,
                    ),
                onTap: () async {
                  if (formProvider.formKey.currentState!.validate()) {
                    List<Placemark> placemarks = await placemarkFromCoordinates(
                        double.parse(chosenLat!), double.parse(chosenLong!));
                    final iata = iataCodes[
                        placemarks.first.isoCountryCode!.toUpperCase()];
                    final data = ShipmentData(
                      countryCode:
                          placemarks.first.isoCountryCode!.toUpperCase(),
                      stateOrProvinceCode: iata,
                      line1: !widget.canChangeCountry
                          ? chosenLocationName.toString()
                          : placemarks.first.street,
                      city: !widget.canChangeCountry
                          ? formProvider.cityController.text
                          : placemarks.first.locality,
                      longitude: double.parse(chosenLong.toString()),
                      latitude: double.parse(chosenLat.toString()),
                      title: chosenLocationName.toString(),
                      description: chosenLocationName.toString(),
                      personName: userProvider.userName,
                      phoneNumber1: userProvider.userPhone,
                      cellPhone: userProvider.userPhone,
                      emailAddress: userProvider.userEmail,
                      length: "5.0",
                      width: "5.0",
                      height: "5.0",
                      value: "5.0",
                      quantity: cartModel.totalQuantity.toString(),
                      descriptionOfGoods: "empty",
                      packageType: "empty",
                    );

                    final calculateRateData = CalculateRate(
                      line1: !widget.canChangeCountry
                          ? chosenLocationName.toString()
                          : 'Unknown',
                      city: !widget.canChangeCountry
                          ? formProvider.cityController.text
                          : 'Unknown',
                      longitude: double.parse(chosenLong.toString()),
                      latitude: double.parse(chosenLat.toString()),
                      description: chosenLocationName.toString(),
                      length: "5.0",
                      width: "5.0",
                      height: "5.0",
                      value: "5.0",
                      numberOfPieces: cartModel.totalQuantity.toString(),
                    );

                    await aramexProvider.calculateRate(calculateRateData);
                    debugPrint(
                        "deeeelivery price ${aramexProvider.deliveryPrice()}");

                    if (aramexProvider.calculateLoading != true) {
                      pushScreen(
                          context,
                          BillScreen(
                            shippingType: allTranslations.text("aramex"),
                            aramexDeliveryPrice: aramexProvider.deliveryPrice(),
                            shipmentData: data,
                          ));
                    }
                  } else {
                    formProvider.formKey.currentState!.validate();
                  }
                },
              ),
            )
        ],
      ),
    );
  }

  bool getVisible() {
    if (widget.canChangeCountry) {
      if (_doneLocation == null) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }
}
