import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomBottomSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget Function(BuildContext) builder,
    bool isDismissible = false,
    bool enableDrag = false,
  }) {
    return showModalBottomSheet(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      barrierColor : Colors.black54,
      isScrollControlled: true,
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.w)
        ),
      ),
      useRootNavigator: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
        ),
        child: builder(context),
      ),
    );
  }
}