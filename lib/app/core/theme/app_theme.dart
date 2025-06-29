import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../values/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData getLightTheme() {
    return ThemeData(
        drawerTheme:
            const DrawerThemeData(backgroundColor: AppColors.secondDark),
        primaryColor: AppColors.mainLight,
        primaryColorLight: AppColors.secondLight,
        primaryColorDark: AppColors.thirdLight,
        canvasColor: AppColors.mainLight,
        secondaryHeaderColor: AppColors.buttonLight,
        hintColor: AppColors.buttonLight,
        fontFamily: 'Alalamia',
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: AppColors.mainLight),
        checkboxTheme: CheckboxThemeData(
          checkColor: WidgetStateProperty.all(Colors.white),
          fillColor: WidgetStateProperty.all(AppColors.accent),
        ),
        cardTheme: const CardThemeData(color: AppColors.mainLight),
        dividerTheme: const DividerThemeData(
          color: Colors.black54,
        ),
        dialogTheme: DialogThemeData(
            backgroundColor: AppColors.mainLight,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))),
        shadowColor: Colors.grey.withOpacity(0.5),
        radioTheme: RadioThemeData(
            fillColor: WidgetStateProperty.all<Color>(AppColors.blackColor2)),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0.0,
          centerTitle: true,
          color: AppColors.mainLight,
          titleTextStyle: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        scaffoldBackgroundColor: AppColors.mainLight,
        cardColor: AppColors.mainLight,
        brightness: Brightness.light,
        dividerColor: AppColors.accent.withOpacity(0.1),
        focusColor: AppColors.accent,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: AppColors.accent),
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
              fontSize: 14.0.sp,
              color: Colors.white,
              fontWeight: FontWeight.w300),
          displayMedium: TextStyle(
              fontSize: 14.0.sp,
              color: Colors.white,
              fontWeight: FontWeight.w300),
          displaySmall: TextStyle(
              fontSize: 35.0.sp,
              color: Colors.black,
              fontWeight: FontWeight.w400),
          headlineMedium: TextStyle(
              fontSize: 34.0.sp,
              color: Colors.black,
              fontWeight: FontWeight.w400),
          headlineSmall: TextStyle(
              fontSize: 24.0.sp,
              color: Colors.black,
              fontWeight: FontWeight.w400),
          titleLarge: TextStyle(
              fontSize: 20.0.sp,
              color: Colors.black,
              fontWeight: FontWeight.w500),
          titleMedium: TextStyle(
              fontSize: 16.0.sp,
              color: Colors.black,
              fontWeight: FontWeight.w400),
          titleSmall: TextStyle(
              fontSize: 14.0.sp,
              color: Colors.black,
              fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(
              fontSize: 16.0.sp,
              color: Colors.black,
              fontWeight: FontWeight.w400),
          bodyMedium: TextStyle(
              fontSize: 14.0.sp,
              color: Colors.black,
              fontWeight: FontWeight.w400),
          bodySmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          labelSmall: TextStyle(
              fontSize: 10.0.sp,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.lineThrough,
              decorationColor: Colors.grey,
              decorationThickness: 1.5),
        ),
        bottomAppBarTheme: BottomAppBarThemeData(color: AppColors.mainLight),
        colorScheme: const ColorScheme.light(
          primary: AppColors.accent,
          secondary: AppColors.accent,
          surface: AppColors.accent,
        )
            .copyWith(surface: AppColors.secondLight)
            .copyWith(secondary: AppColors.accent));
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
        drawerTheme:
            const DrawerThemeData(backgroundColor: AppColors.secondDark),
        primaryColor: AppColors.mainDark,
        primaryColorLight: AppColors.secondDark,
        primaryColorDark: AppColors.secondDark,
        canvasColor: AppColors.mainDark,
        secondaryHeaderColor: AppColors.buttonDark,
        hintColor: AppColors.mainLight2,
        fontFamily: 'Alalamia',
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.secondDark,
        ),
        checkboxTheme: CheckboxThemeData(
          checkColor: WidgetStateProperty.all(Colors.white),
          fillColor: WidgetStateProperty.all(AppColors.accent),
        ),
        dividerTheme: const DividerThemeData(
          color: Colors.grey,
        ),
        cardTheme: const CardThemeData(color: AppColors.secondDark),
        shadowColor: AppColors.accent.withOpacity(0.2),
        dialogTheme: DialogThemeData(
            backgroundColor: AppColors.mainLight,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))),
        radioTheme: RadioThemeData(
            fillColor: WidgetStateProperty.all<Color>(AppColors.mainLight)),
        appBarTheme: const AppBarTheme().copyWith(
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0.0,
            color: AppColors.mainDark,
            centerTitle: true,
            titleTextStyle: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        scaffoldBackgroundColor: AppColors.mainDark,
        cardColor: AppColors.mainDark,
        applyElevationOverlayColor: true,
        dividerColor: AppColors.accent.withOpacity(0.1),
        focusColor: AppColors.accent,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.accent,
          ),
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
              fontSize: 14.0.sp,
              color: Colors.black,
              fontWeight: FontWeight.w300),
          displayMedium: TextStyle(
              fontSize: 14.0.sp,
              color: Colors.black,
              fontWeight: FontWeight.w300),
          displaySmall: TextStyle(
              fontSize: 48.0.sp,
              color: Colors.white,
              fontWeight: FontWeight.w400),
          headlineMedium: TextStyle(
              fontSize: 34.0.sp,
              color: Colors.white,
              fontWeight: FontWeight.w400),
          headlineSmall: TextStyle(
              fontSize: 24.0.sp,
              color: Colors.white,
              fontWeight: FontWeight.w400),
          titleLarge: TextStyle(
              fontSize: 20.0.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500),
          titleMedium: TextStyle(
              fontSize: 16.0.sp,
              color: Colors.white,
              fontWeight: FontWeight.w400),
          titleSmall: TextStyle(
              fontSize: 14.0.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(
              fontSize: 16.0.sp,
              color: Colors.white,
              fontWeight: FontWeight.w400),
          bodyMedium: TextStyle(
              fontSize: 14.0.sp,
              color: Colors.white,
              fontWeight: FontWeight.w400),
          bodySmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          labelSmall: TextStyle(
              fontSize: 10.0.sp,
              color: Colors.white,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.lineThrough,
              decorationColor: Colors.grey,
              decorationThickness: 1.5),
        ),
        bottomAppBarTheme: BottomAppBarThemeData(color: AppColors.mainDark),
        colorScheme: const ColorScheme.dark(
          primary: AppColors.accent,
          surface: AppColors.secondDark,
          secondary: AppColors.accent,
        )
            .copyWith(surface: AppColors.secondDark)
            .copyWith(secondary: AppColors.accentDark));
  }
}
