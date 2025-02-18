
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utils/constants.dart';

class CustomTextFormField extends StatelessWidget {

  final TextEditingController? controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextStyle? textStyle;
  final bool autofocus;
  final bool obscureText ;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final VoidCallback? onEditingComplete;
  final GestureTapCallback? onFieldSubmitted;
  final FormFieldValidator? validator;
  final Function? onSave;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode autoValidateMode;
  final String  hintText;
  final TextStyle?  hintStyle;
  final InputBorder? inputBorder;
  final InputBorder? focusedBorder;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? height ;
  final double? width;
  final bool? readOnly;
  final InputDecoration? decoration;
  final Color? fillColor;
  final String? initialValue;
  final int? maxLines;
  final EdgeInsetsGeometry? contentPadding;
  final TextDirection? textDirection;
  final String? label;
  final BorderRadius? borderRadius;
  final String? labelText;
  const CustomTextFormField({
    Key? key,
     this.controller,
    required this.keyboardType,
    required this.textInputAction,
    this.textStyle,
    this.autofocus = false,
    this.obscureText = false,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.validator,
    this.onSave,
    this.inputFormatters,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.inputBorder,
    this.focusedBorder,
    required this.hintText,
     this.hintStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.width,
    this.height,
    this.readOnly,
    this.decoration,
    this.fillColor,
    this.initialValue,
    this.maxLines,
    this.contentPadding,
    this.textDirection,
    this.label,
    this.borderRadius,
    this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines ?? 1,
      controller: controller,
      textDirection: textDirection,
      initialValue: initialValue,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      style:  textStyle ?? Theme.of(context).textTheme.bodyLarge!.copyWith(
        fontFamily: 'cairo' ),
      autofocus: autofocus,
      obscureText: obscureText,
      readOnly: readOnly ?? false,
      obscuringCharacter: "*",
      onChanged:  onChanged,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: (value) => onFieldSubmitted,
      validator:  validator,
      onSaved: (save) => onSave,
      inputFormatters: inputFormatters,
      autovalidateMode: autoValidateMode,
      decoration: decoration ?? InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle ?? Theme.of(context).textTheme.bodySmall,
        labelText: labelText ?? null,
        labelStyle: hintStyle ?? Theme.of(context).textTheme.labelMedium!.copyWith(
            fontWeight: FontWeight.bold
        ),
        contentPadding: contentPadding ??  EdgeInsets.symmetric(vertical: 20.h , horizontal: 10.w),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        label: label != null ?  Text(label.toString()) : null,
        fillColor: fillColor ?? Theme.of(context).primaryColor,
        filled: true,
        enabled: true,
        border:  inputBorder ?? OutlineInputBorder(
          borderRadius: borderRadius ??  BorderRadius.circular(AppConstants.defaultBorderRadius.w),
          borderSide: const BorderSide(color: Colors.transparent, width: 0),
        ),
        enabledBorder:  inputBorder ?? OutlineInputBorder(
          borderRadius: borderRadius ??  BorderRadius.circular(AppConstants.defaultBorderRadius.w),
          borderSide: BorderSide(color: Colors.grey[400]!, width: 0),
        ),
        focusedBorder: focusedBorder ??  OutlineInputBorder(
          borderRadius: borderRadius ??  BorderRadius.circular(AppConstants.defaultBorderRadius.w),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1.w),
        ),
      ),






    );
  }
}
