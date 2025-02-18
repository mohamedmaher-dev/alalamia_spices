
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:alalamia_spices/app/exports/provider.dart';

class NoInternetMessage extends StatelessWidget {
  const NoInternetMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
      padding: EdgeInsets.all(5.w),
      child: Center(
        child: Text(
          allTranslations.text("noInternet"),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
