
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/utils/url.dart';
import '../../module/app_config/app_config_screen.dart';

class NoteModel extends QueryModel {
  NoteModel(super.context);

  @override
  Future loadData([BuildContext? context]) async {

    if (appModel.token != '') {
      List noteList = await fetchData(
          appModel.token == "visitor"
              ? "${AppUrl.noteVisitor}?country_id=$countryId"
              : AppUrl.note
      );
      items.addAll(noteList.map((note) => Note.fromJson(note)).toList());

    }
      if (kDebugMode) {
        print ("=====NoteModel api url ===== ${AppUrl.noteVisitor}?country_id=$countryId");
      }
    finishLoading();
  }

  Note get note => items[0];
}