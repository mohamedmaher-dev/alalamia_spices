import 'package:alalamia_spices/app/core/values/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import '../../../data/model/shipping_type.dart';


class ShippingTypeProvider {
  List<DropdownMenuItem<String>> _shippingItems = [];
  List<DropdownMenuItem<String>> get shippingItems => _shippingItems;
  final normalDelivery = ShippingTypeData(
      id: "1",
      name:  allTranslations.text("normalDelivery"),
      icon: AppIcons.truck
  );

  final aramex = ShippingTypeData(
    id: "2",
    name:  allTranslations.text("aramex"),
    icon: AppIcons.aramex,
  );
  List<ShippingTypeData> shippingTypeList = [];

  getShippingList(BuildContext context) {
    shippingTypeList = [
      normalDelivery,
      aramex
    ];
    _shippingItems = [];
    for (var i = 0; i < shippingTypeList.length; i++) {
      _shippingItems.add(DropdownMenuItem(
        value: "${shippingTypeList[i].name}",
        child: Text(
          "${shippingTypeList[i].name}",
          style: Theme.of(context).textTheme.bodyMedium!,
        ),
      ));
      // currentLocation = items[0].name;
    }

  }

}