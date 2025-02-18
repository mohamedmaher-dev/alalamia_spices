import 'package:flutter/material.dart';
import '../../core/utils/url.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';

class VersionModel extends QueryModel {

  VersionModel (super.context);

  @override
  Future loadData([BuildContext? context]) async {
    if (await canLoadData()) {
      var data = await fetchData(AppUrl.updateApp);
      if (data != null) {
        Version versionData = Version.fromJson(data);
        items.add(versionData);
      }
    }
  }

  Version get version => items[0];
}
