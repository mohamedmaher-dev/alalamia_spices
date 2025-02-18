
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import '../core/utils/constants.dart';
import 'package:alalamia_spices/app/exports/provider.dart';

class CustomInternationalPhoneNumber extends StatelessWidget {
  final ValueChanged<PhoneNumber>? onInputChanged;
  final TextEditingController textEditingController;
  final bool fieldName;
  final Widget? fieldRequired;
  final PhoneNumber? initialValue;
  final TextInputAction textInputAction;
  const CustomInternationalPhoneNumber({
    super.key,
    this.onInputChanged,
    required this.textEditingController,
    this.fieldName = false,
    this.fieldRequired,
    this.initialValue,
    required this.textInputAction
  });

  @override
  Widget build(BuildContext context) {
    var countriesModel = Provider.of<CountriesModel>(context);
    countriesModel.getCountryCode();

    InputDecoration inputDecorationFormField = InputDecoration(
      hintText: allTranslations.text("enterUserPhone"),
      hintTextDirection: allTranslations.currentLanguage == "ar" ? TextDirection.rtl : TextDirection.ltr,
      hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(fontFamily: "cairo"),
      contentPadding:  EdgeInsets.symmetric(vertical: 10.h , horizontal: 10.w),
      fillColor: Theme.of(context).primaryColor,
      filled: true,
      border:   OutlineInputBorder(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(AppConstants.defaultBorderRadius.w)
        ),
        borderSide: const BorderSide(color: Colors.transparent, width: 0),
      ),
      enabledBorder:   OutlineInputBorder(
        borderRadius: BorderRadius.horizontal(
            right: Radius.circular(AppConstants.defaultBorderRadius.w)
        ),
        borderSide: BorderSide(color: Colors.grey[400]!, width: 0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.horizontal(
            right: Radius.circular(AppConstants.defaultBorderRadius.w)
        ),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1.w),
      ),
    );


    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        fieldName == false
        ? 0.ph
        : Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              allTranslations.text("userPhone"),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w700
              ),
            ),
            5.pw,
            fieldRequired ?? 0.ph
          ],
        ),
        10.ph,
        Container(
          padding: EdgeInsets.only(left: 10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: InternationalPhoneNumberInput(
              keyboardAction: textInputAction,
              keyboardType: TextInputType.phone,
              textAlign: allTranslations.currentLanguage == "ar" ? TextAlign.right : TextAlign.left,
              initialValue: initialValue ?? PhoneNumber(
                  isoCode: countriesModel.chosenInitialCountry == ''
                      ? countriesModel.initialCountry
                      : countriesModel.chosenInitialCountry,
                  dialCode: countriesModel.dialCode),
              selectorConfig: const SelectorConfig(
                  selectorType:
                  PhoneInputSelectorType.BOTTOM_SHEET,
                  useEmoji: true),
              onInputChanged: onInputChanged,
              onInputValidated: (bool value) {
                if (kDebugMode) {
                  print(value);
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return allTranslations.text('enterUserPhone');
                }
                return null;
              },
              ignoreBlank: true,
              inputDecoration: inputDecorationFormField,
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontFamily: "cairo"),
              selectorTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontFamily: "cairo"),
              textFieldController: textEditingController,
            ),
          ),
        ),
      ],
    );
  }
}
