import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/core/utils/url.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/exports/services.dart';

class CountriesModel extends QueryModel {
  CountriesModel(super.context);

  String _selectedCountryImage = '';
  String _selectedCountryName = '';
  String _selectedCountryId2 = '';

  String get selectedCountryImage => _selectedCountryImage;
  String get selectedCountryName => _selectedCountryName;
  String get selectedCountryId2 => _selectedCountryId2;

  String? currentCountry;
  String _initialCountry = 'AE';
  String _chosenInitialCountry = '';
  String _selectedCountryId = '';
  String _dialCode = '+971';
  bool _isSaving = false;
  String get initialCountry => _initialCountry;
  String get chosenInitialCountry => _chosenInitialCountry;
  String get dialCode => _dialCode;
  String get selectedCountryId => _selectedCountryId;
  bool get isSaving => _isSaving;
  List<DropdownMenuItem<String>> _countriesItems = [];
  List<DropdownMenuItem<String>> get countriesItems => _countriesItems;

  set chosenInitialCountry(String newValue) {
    _chosenInitialCountry = newValue;
    notifyListeners();
  }

  set dialCode(String newValue) {
    _dialCode = newValue;
    notifyListeners();
  }

  set isSaving(bool newValue) {
    _isSaving = newValue;
    notifyListeners();
  }

  @override
  Future loadData([BuildContext? context]) async {
    var data;
    try {
      data = await fetchDataa(AppUrl.countryVisitor, "");
    } catch (error) {
      if (kDebugMode) {
        print("countries model errors =  $errors");
      }
    }

    if (data != null) {
      CountriesData countriesData = CountriesData.fromJson(data);
      List countriesList = countriesData.countries!;
      items.addAll(countriesList);
      finishLoading();

      // if (kDebugMode) {
      //   print ("=====countries model=====$data");
      //   print ("=====countries api url ===== ${AppUrl.countryVisitor}");
      // }
    }
  }

  Countries get country => items[0];

  // set newCountryId(String value) {
  //   currentCountryId = value;
  //   sharedPreferenceService.setStringValue(AppConstants.countryId , value);
  //   notifyListeners();
  // }

  // Future<void> saveCountryId(String value) async {
  //   currentCountryId = value;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString("country_id", value );
  //   notifyListeners();
  // }
  //
  // Future<void> getCountryId() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   savedCountryId = prefs.getString("country_id");
  //   notifyListeners();
  // }

  // set newCountryName(String value) {
  //   currentCountryName = value;
  //   sharedPreferenceService.setStringValue( AppConstants.countryName ,value);
  //   notifyListeners();
  // }
  //
  // set newCountryImage(String value) {
  //   currentCountryImage = value;
  //   sharedPreferenceService.setStringValue(AppConstants.countryImage , value);
  //   notifyListeners();
  // }

  Future saveCountryDetails(
      {required String id, required String image, required String name}) async {
    SharedPrefsService.putString("countryId", id);
    SharedPrefsService.putString("countryImage", image);
    SharedPrefsService.putString("countryName", name);
  }

  Future getCountryDetails() async {
    _selectedCountryImage = SharedPrefsService.getString("countryImage");
    _selectedCountryName = SharedPrefsService.getString("countryName");
    _selectedCountryId2 = SharedPrefsService.getString("countryName");
  }

  Future saveCountryCode(
      {required String initialCountry,
      required String dialCode,
      required countryId}) async {
    SharedPrefsService.putString("countryCode", initialCountry);
    SharedPrefsService.putString("dialCode", dialCode);
    SharedPrefsService.putString("SELECTED_COUNTRY_ID", countryId);
  }

  Future getCountryCode() async {
    _initialCountry = SharedPrefsService.getString("countryCode") ?? "AE";
    _dialCode = SharedPrefsService.getString("dialCode") ?? "+971";
    _selectedCountryId =
        SharedPrefsService.getString("SELECTED_COUNTRY_ID") ?? "1";

    RegExp regex = RegExp(r'\d{3}');
    List<RegExpMatch> matches = regex.allMatches(_dialCode).toList();
    String? firstThreeNumbers = matches.isNotEmpty ? matches[0].group(0) : '';

    _dialCode = firstThreeNumbers.toString();
    // notifyListeners();
  }

  removeCountryCode() async {
    SharedPrefsService.remove("countryCode");
    SharedPrefsService.remove("dialCode");
    SharedPrefsService.remove("SELECTED_COUNTRY_ID");
  }

  getCountriesList() {
    _countriesItems = [];

    for (var i = 0; i < items.length; i++) {
      _countriesItems.add(DropdownMenuItem(
        value: "${items[i].name}",
        child: Padding(
          padding: EdgeInsets.all(5.0.w),
          child: Row(
            children: [
              CustomCachedNetworkImage(
                imageUrl: items[i].imagePath.toString(),
                fit: BoxFit.contain,
                width: 30.w,
                height: 30.h,
              ),
              10.pw,
              Text("${items[i].name}"),
            ],
          ),
        ),
      ));
      currentCountry = items[0].name.toString();
      // currentCountryId = items[0].id.toString();
    }
  }

  /// this function to change the country of user

  Future changeCountry(String countryId, [BuildContext? context]) async {
    if (appModel.token != '' && await canLoadData()) {
      Map<String, dynamic> postData = {};
      postData.addAll({"country_id": countryId});
      if (items.isNotEmpty) items.clear();
      await saveData(AppUrl.changeCountry, parameters: postData);
      if (kDebugMode) {
        print(postData.toString());
      }
    }
  }
}
