import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrencyView extends StatelessWidget {
  const CurrencyView({
    super.key,
    required this.currency,
    this.color,
  });
  final String? currency;
  final Color? color;
  static const _saudiCurrencySymbols = {'SAR', 'ريال', 'RS'};
  @override
  Widget build(BuildContext context) {
    final textColor = color ?? Theme.of(context).textTheme.titleSmall!.color!;

    if (_saudiCurrencySymbols.contains(currency)) {
      return SvgPicture.asset(
        'assets/icons/ksa_currency.svg',
        colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
        height: 15.h,
        width: 15.w,
      );
    } else {
      return Text(
        currency ?? 'Unknown Currency',
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontFamily: "cairo",
              fontSize: 10.sp,
            ),
      );
    }
  }
}
