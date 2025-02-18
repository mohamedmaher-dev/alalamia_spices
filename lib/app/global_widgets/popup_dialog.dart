import 'package:alalamia_spices/app/exports/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import '../module/ads_popup_dialog/ads_popup_dialog.dart';


class PopupDialog {
  static Future<void> showPopupDialog(BuildContext context) async {
    bool hasShownDialog = SharedPrefsService.getBool('hasShownDialog');
    if (!hasShownDialog) {
      final model = Provider.of<AdsPopupModel>(context, listen: false);
      await model.loadData();
      if (model.loadingFailed || model.items.isEmpty) {
        // Handle loading failure
        return;
      }

      showDialog(
        context: context,
        builder: (context) => AdsPopupDialog(adsPopup: model.items[0], ),
      );
      SharedPrefsService.putBool('hasShownDialog', true);
      // print("poooooooo $hasShownDialog + items length ${model.items.length}");
    }

  }

}

