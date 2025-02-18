

import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:flutter/material.dart';


class CustomTowText extends StatelessWidget {
  final String title;
  final String? subTitle;
  final Widget? subWidget;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  final MainAxisAlignment? mainAxisAlignment;
  final int? maxLines;
  final TextOverflow? textOverflow;
  const CustomTowText({
    Key? key,
    required this.title,
    this.subTitle,
    this.titleStyle,
    this.subTitleStyle,
    this.subWidget,
    this.mainAxisAlignment,
    this.maxLines,
    this.textOverflow
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment == null ? MainAxisAlignment.start : mainAxisAlignment!,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          subWidget!= null ? title : "$title: ",
          maxLines: maxLines ?? 1,
          overflow: textOverflow ?? TextOverflow.ellipsis,
          style: titleStyle ?? Theme.of(context).textTheme.bodySmall,
        ),

        3.pw,


        subWidget ?? Text(
          subTitle!,
          maxLines: maxLines,
          overflow: textOverflow,
          style: subTitleStyle ??  Theme.of(context).textTheme.bodySmall,
        ),

      ],
    );
  }
}
