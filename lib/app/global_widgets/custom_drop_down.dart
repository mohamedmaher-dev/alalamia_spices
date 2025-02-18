

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/utils/constants.dart';


class CustomDropDown extends StatelessWidget {

  final List<DropdownMenuItem<String>> listItem;
  final String value;
  final String hintText;
  final ValueChanged<String?> onChanged;
  final double? height;
  final Color? fillColor;
  const CustomDropDown({
    Key? key,
    required this.listItem,
    required this.value,
    required this.hintText,
    required this.onChanged,
    this.height,
    this.fillColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double effectiveHeight = height ?? 50.h;
    final Color effectiveFillColor = fillColor ?? Theme.of(context).colorScheme.background;
    return Center(
      child: Container(
          height: effectiveHeight ,
          padding:  EdgeInsets.all(5.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
              border: Border.all(color: Colors.grey[300]!),
              color: effectiveFillColor
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 5.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isDense: true,
                itemHeight: null,
                items: listItem,
                onChanged: onChanged,
                dropdownColor: Theme.of(context).colorScheme.background,
                isExpanded: true,
                style: Theme.of(context).textTheme.bodySmall,
                value: value,
                hint: Text(
                  hintText,
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ),
            ),
          )

      ),
    );
  }
}
