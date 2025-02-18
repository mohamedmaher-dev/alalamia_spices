/// a dialog without the icon
// import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
// import 'package:flutter/material.dart';
// import '../data/model/translations.dart';
// import '../global_widgets/custom_buttons.dart';
//
// class CustomDialog {
//   static void showCustomDialog({
//     required BuildContext context,
//     required Widget title,
//     bool? withActions,
//     bool? withYesButton,
//     bool? withNoButton,
//     required bool barrierDismissible,
//     VoidCallback? onPressed,
//     VoidCallback? onNoPressed,
//     Widget? content,
//   }) {
//     showDialog(
//       context: context,
//       barrierDismissible: barrierDismissible,
//       builder: (BuildContext context) {
//         return CustomDialog._buildDialog(
//             context, title , withActions , withYesButton ,withNoButton, onPressed , onNoPressed , content);
//       },
//     );
//   }
//
//   static void hideCustomDialog(BuildContext context) {
//     Navigator.of(context, rootNavigator: true).pop();
//   }
//
//   static Widget _buildDialog(
//   BuildContext context,
//   Widget title,
//    bool? withActions,
//     bool? withYesButton,
//    bool? withNoButton,
//    VoidCallback? onPressed,
//    VoidCallback? onNoPressed,
//    Widget? content) {
//     return AlertDialog(
//         backgroundColor: Theme.of(context).backgroundColor,
//         elevation: 0.5,
//         title:  Center(
//             child: title
//         ),
//         content: content,
//         actions: withActions == true
//             ? <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               withYesButton == true
//                   ? Expanded(
//                 child: CustomButtons(
//                   text: allTranslations.text("agree"),
//                   buttonColor: Theme.of(context).secondaryHeaderColor,
//                   onTap: onPressed,
//
//                 ),
//               )
//
//                   : 0.ph,
//
//               10.pw,
//              withNoButton == true
//                   ? Expanded(
//                 child: CustomButtons(
//                   text: allTranslations.text("cancel"),
//                   buttonColor: Theme.of(context).secondaryHeaderColor,
//                   onTap: onNoPressed ??  (){
//                     Navigator.pop(context);
//                   },
//                 ),
//               )
//                   : 0.ph,
//             ],
//           ),
//
//
//
//
//         ]
//             : <Widget> [],
//
//     );
//   }
// }

import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'custom_buttons.dart';


class CustomDialog {
  static void showCustomDialog({
    required BuildContext context,
    required String title,
    Widget? description,
    bool? withActions,
    bool? withYesButton,
    bool? withNoButton,
    required bool barrierDismissible,
    VoidCallback? onPressed,
    VoidCallback? onNoPressed,
    Widget? icon,
    
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return CustomDialog._buildDialog(
            context,
            title ,
            description ,
            withActions ,
            withYesButton,
            withNoButton,
            onPressed ,
            onNoPressed ,
            icon
        );
      },
    );
  }

  static void hideCustomDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static Widget _buildDialog(
      BuildContext context,
      String title,
      Widget? description,
      bool? withActions,
      bool? withYesButton,
      bool? withNoButton,
      VoidCallback? onPressed,
      VoidCallback? onNoPressed,
      Widget? icon) {

    double padding = 10.0.w;
    double avatarRadius = 50.0.w;
    final themeModel = Provider.of<ThemeModel>(context , listen: false);
    return WillPopScope(
      onWillPop: () async {
        return false ;
      },
      child: Dialog(
        backgroundColor: themeModel.darkTheme == false
            ? Colors.transparent
            : Colors.grey[400],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(padding),
        ),
        elevation: 0.0,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: 300.w,
              margin: EdgeInsets.only( top: icon != null ? avatarRadius + padding : 0),
              decoration: BoxDecoration(
                color: themeModel.darkTheme == false
                    ? Theme.of(context).primaryColor
                    : Colors.grey[400],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(padding),
                // boxShadow: const [
                //   BoxShadow(
                //     color: Colors.black26,
                //     blurRadius: 10.0,
                //     offset: Offset(0.0, 10.0),
                //   ),
                // ],
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(padding, icon != null ? avatarRadius + padding * 2 : padding , padding, padding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'cairo'
                      ),
                    ),
                    20.ph,
                    description ?? 0.ph,
                    20.ph,

                    withActions == true
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        withYesButton == true
                            ? Expanded(
                          child: CustomButtons(
                            text: allTranslations.text("agree"),
                            buttonColor: Theme.of(context).secondaryHeaderColor,
                            onTap: onPressed,

                          ),
                        )

                            : 0.ph,

                        10.pw,
                        withNoButton == true
                            ? Expanded(
                          child: CustomButtons(
                            text: allTranslations.text("cancel"),
                            buttonColor: Theme.of(context).secondaryHeaderColor,
                            onTap: onNoPressed ??  (){
                              Navigator.pop(context);
                            },
                          ),
                        )
                            : 0.ph,
                      ],
                    )
                        : 0.ph,
                  ],
                ),
              ),
            ),

            icon != null
                ? Positioned(
              top: padding,
              child: CircleAvatar(
                backgroundColor: themeModel.darkTheme == false
                    ? Theme.of(context).primaryColor
                    : Colors.grey[400],
                radius: avatarRadius,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(avatarRadius),
                  child: icon,
                ),
              ),
            )
                : 0.ph,
          ],
        ),
      ),
    );
  }
}

