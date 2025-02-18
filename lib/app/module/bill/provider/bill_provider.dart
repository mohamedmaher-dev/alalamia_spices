
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/core/values/app_images.dart';
import 'package:alalamia_spices/app/global_widgets/svg_picture_assets.dart';
import 'package:flutter/material.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/values/app_icons.dart';


class BillProvider with ChangeNotifier {

  final List<Map<String , dynamic>> deliveryType = [
    {"id" : "1" , "name" : allTranslations.text('freeShipping') , "icon" : AppIcons.truck},
    {"id" : "2" , "name" : allTranslations.text("conditionShipping") , "icon" : AppIcons.deliveryDelay}
  ];
  List<DropdownMenuItem<String>> _deliveryTypeItems = [];
  List<DropdownMenuItem<String>> get deliveryTypeItems => _deliveryTypeItems;


  String _selectedDate = '';
  String _selectedHour = '';
  String _selectedMinute = '';
  String _shippingType = '';
  String  _currentShippingType = allTranslations.text("internalRequest");
  String _selectedShippingType = '';
  int _currentIndex = -1;
  String _mustSelectDateError = '';

  String get selectedDate => _selectedDate;
  String get selectedHour => _selectedHour;
  String get selectedMinute => _selectedMinute;
  String get shippingType => _shippingType;
  String get selectedShippingType => _selectedShippingType;
  String get currentShippingType => _currentShippingType;
  String get mustSelectDateError => _mustSelectDateError;
  int get currentIndex => _currentIndex;

  set selectedDate (String date) {
    _selectedDate = date;
    notifyListeners();
  }

  set selectedHour (String hour) {
    _selectedHour = hour;
    notifyListeners();
  }

  set selectedMinute (String minute) {
    _selectedMinute = minute;
    notifyListeners();
  }

  set shippingType (String shippingType) {
    _shippingType = shippingType;
    notifyListeners();
  }

  set selectedShippingType (String selectedShippingType) {
    _selectedShippingType = selectedShippingType;
    notifyListeners();
  }

  set currentShippingType (String current) {
    _currentShippingType = current;
    notifyListeners();
  }

  set currentIndex (int index) {
    _currentIndex = index;
    notifyListeners();
  }

  set mustSelectDateError (String date){
    _mustSelectDateError = date;
    notifyListeners();
  }

  getDeliveryTypeList(BuildContext context) {
    _deliveryTypeItems = [];

    for (int i = 0; i < deliveryType.length; i++) {
      _deliveryTypeItems.add(
        DropdownMenuItem(
          value: deliveryType[i]['name'],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SVGPictureAssets(
                image: deliveryType[i]['icon'],
                width: 25.w,
                height: 25.h,
              ),
              10.pw,
              Text(
                deliveryType[i]['name'],
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
      );
    }
    _deliveryTypeItems.add(DropdownMenuItem(
      value: '',
      child: Text(allTranslations.text("shippingDate")),
    ));
  }
}