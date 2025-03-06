import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/core/utils/input_validators.dart';
import 'package:alalamia_spices/app/data/providers/cartModel.dart';
import 'package:alalamia_spices/app/data/providers/translations.dart';
import 'package:alalamia_spices/app/data/providers/userModel.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/module/check_out/providers/checkout_form_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import '../../../data/model/aramex_shipment.dart';
import '../../../data/providers/shipping/aramex_provider.dart';
import '../../bill/bill_screen.dart';
import 'location_details.dart';

class AramexDetails extends StatelessWidget {
  final bool selectedAramex;
  const AramexDetails({super.key, required this.selectedAramex});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CheckoutFormProvider()),
        ChangeNotifierProvider(create: (context) => AramexProvider()),
      ],
      child: AramexForm(
        selectedAramex: selectedAramex,
      ),
    );
  }
}

class AramexForm extends StatelessWidget {
  final bool selectedAramex;
  const AramexForm({super.key, required this.selectedAramex});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserModel>(context)..getUserInfo();
    final formProvider = Provider.of<CheckoutFormProvider>(context);
    final aramexProvider = Provider.of<AramexProvider>(context);
    final cartModel = Provider.of<CartModel>(context);

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
          TextFormFieldWithName(
            controller: formProvider.recipientNameController,
            hintTextFormField: allTranslations.text("recipientName"),
            fieldName: allTranslations.text("recipientName"),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            fieldRequired: starIcon,
            onFieldSubmitted: () {
              FocusScope.of(context).nextFocus();
            },
            validator: (value) => InputValidators.validateRequired(value),
          ),
          15.ph,

          /// location
          TextFormFieldWithName(
            hintTextFormField: chosenLocationName.toString(),
            readOnly: true,
            fieldName: allTranslations.text("location"),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),

          15.ph,

          /// country
          TextFormFieldWithName(
            readOnly: true,
            hintTextFormField: userProvider.userCountry,
            fieldName: allTranslations.text("currentCountry"),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),

          15.ph,

          /// city
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

          if (selectedAramex == true)
            CustomButtons(
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
                  final data = ShipmentData(
                    line1: chosenLocationName.toString(),
                    city: formProvider.cityController.text,
                    longitude: double.parse(chosenLat.toString()),
                    latitude: double.parse(chosenLong.toString()),
                    title: chosenLocationName.toString(),
                    description: chosenLocationName.toString(),
                    personName: formProvider.recipientNameController.text,
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
                    line1: chosenLocationName.toString(),
                    city: formProvider.cityController.text,
                    longitude: double.parse(chosenLat.toString()),
                    latitude: double.parse(chosenLong.toString()),
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
            )
        ],
      ),
    );
  }
}
