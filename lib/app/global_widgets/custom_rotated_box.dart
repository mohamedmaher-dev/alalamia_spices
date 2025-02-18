

import 'package:flutter/material.dart';


class CustomRotatedBox extends StatelessWidget {
  final String text ;
  final TextStyle? textStyle;

  const CustomRotatedBox({
    super.key,
    required this.text,
    this.textStyle
  });

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: Center(
          child: Text(
            text,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            style:  textStyle ??  Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold
            )
          )
      ),
    );
  }
}
