
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class CustomToast {

 static showFlutterToast({ required BuildContext context ,required message , Toast? toastLength , ToastGravity? toastGravity}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: toastLength ?? Toast.LENGTH_LONG,
        gravity: toastGravity ??  ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        textColor: Theme.of(context).primaryColor,
        fontSize: 16.0.sp
    );
  }

}