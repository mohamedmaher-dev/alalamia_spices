
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';


class CustomSwitchWidget extends StatelessWidget {

  final bool isSwitched;
  final String? textValue ;
  final Function onChanged;

  const CustomSwitchWidget({
    Key? key,
     this.isSwitched = false,
    this.textValue,
    required this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: 60.0.w,
      height: 30.0.h,
      toggleSize: 35.0,
      value: isSwitched,
      borderRadius: 30.0,
      padding: 2.0,
      toggleColor: Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
      // switchBorder: Border.all(
      //   color: const Color.fromRGBO(2, 107, 206, 1),
      //   width: 6.0,
      // ),
      // toggleBorder: Border.all(
      //   color: const Color.fromRGBO(2, 107, 206, 1),
      //   width: 5.0,
      // ),
      activeColor: Theme.of(context).colorScheme.surface,
      inactiveColor: Theme.of(context).colorScheme.surface,
      onToggle: (val) => onChanged
    );
  }
}
