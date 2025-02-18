import 'package:alalamia_spices/app/core/utils/url.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:alalamia_spices/app/exports/model.dart';

class LocationModel extends QueryModel {
  String? id;

  LocationModel(super.context, {this.id});
  String? currentLocation;
  String? defaultLocation;
  String? areaId;
  final bool _isFetching = false;
  bool _deleting = false;
  bool get isFetching => _isFetching;
  bool get deleting => _deleting;
  // String? get currentLocation => _currentLocation;
  List<DropdownMenuItem<String>> _locationsItems = [];
  List<DropdownMenuItem<String>> get locationsItems => _locationsItems;
  final Set<String> _uniqueValues = {};
  Set<String> get uniqueValues => _uniqueValues;
  List<DropdownMenuItem<String>> _uniqueLocations = [];
  List<DropdownMenuItem<String>> get uniqueLocations => _uniqueLocations;

  set deleting(bool newValue) {
    _deleting = newValue;
    notifyListeners();
  }

  @override
  Future loadData([BuildContext? context]) async {
    if (appModel.token != '' && await canLoadData()) {
      List userLocation = await fetchData(AppUrl.userLocation);
      items.addAll(userLocation
          .map((userLocation) => UserLocations.fromJson(userLocation))
          .toList());
    }
    finishLoading();
  }

  UserLocations get userLocation => items[0];

  Future addLocation(UserLocations location, [BuildContext? context]) async {
    if (await canLoadData()) {
      Map<String, dynamic> postData = location.toJson();
      try {
        if (items.isNotEmpty) items.clear();
        await saveData(AppUrl.userLocation, parameters: postData);
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  edit(UserLocations userLocation, String id) async {
    if (await canLoadData()) {
      Map<String, dynamic> postData = userLocation.toJson();
      try {
        await editData(AppUrl.editUserLocation + id, parameters: postData);
        debugPrint(postData.toString());
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  delete(UserLocations userLocation, String id) async {
    if (await canLoadData()) {
      Map<String, dynamic> postData = userLocation.toJson();
      try {
        await deleteData(AppUrl.deleteUserLocation + id, parameters: postData);
      } catch (e) {
        if (kDebugMode) {
          debugPrint(e.toString());
        }
      }
    }
    notifyListeners();
  }

  getLocationsList(BuildContext context) {
    _locationsItems = [];
    _uniqueValues.clear();

    for (var i = 0; i < items.length; i++) {
      _locationsItems.add(DropdownMenuItem(
        value: "${items[i].name}",
        child: Text(
          "${items[i].name} " "( ${items[i].desc} )",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ));
      currentLocation = items[i].name;

      areaId = "${items[i].areaId}";
    }

    _locationsItems.add(DropdownMenuItem(
      value: '',
      child: Text(allTranslations.text("selectLocation")),
    ));

    /// filter duplicate
    _uniqueLocations = _locationsItems.where((item) {
      bool isNewValue = _uniqueValues.add(item.value!);
      return isNewValue;
    }).toList();
  }

  Future changeDefaultLocation({required String locationId}) async {
    if (appModel.token != '') {
      List userLocation = await fetchData("${AppUrl.changeAddress}$locationId");
      items.addAll(userLocation
          .map((userLocation) => UserLocations.fromJson(userLocation))
          .toList());
    }
    finishLoading();
  }
}
