import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reviews_link_v2/res/color.dart';

class AppTheme {
  static const String font = 'Poppins';

  static AppBarTheme get appBarTheme => AppBarTheme(
    color: primaryColor,
  );

  static TextTheme get textTheme => TextTheme(
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
  );

  static TextStyle get headlineLarge => TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w700,
    fontSize: 22.sp,
    color: black,
  );

  static TextStyle get headlineMedium => TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w700,
    fontSize: 20.sp,
    color: black,
  );

  static TextStyle get headlineSmall => TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w700,
    fontSize: 18.sp,
    color: black,
  );

  static TextStyle get titleLarge => TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w700,
    fontSize: 16.sp,
    color: black,
  );

  static TextStyle get titleMedium => TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w700,
    fontSize: 14.sp,
    color: black,
  );

  static TextStyle get titleSmall => TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w700,
    fontSize: 12.sp,
    color: black,
  );

  static TextStyle get bodyLarge => TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
    color: black,
  );

  static TextStyle get bodyMedium => TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w600,
    fontSize: 14.sp,
    color: black,
  );

  static TextStyle get bodySmall => TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w600,
    fontSize: 12.sp,
    color: black,
  );

  static TextStyle get labelLarge => TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    color: black,
  );

  static TextStyle get labelMedium => TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    color: black,
  );

  static TextStyle get labelSmall => TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    color: black,
  );

  static TextStyle get displayLarge => TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w300,
    fontSize: 16.sp,
    color: black,
  );

  static TextStyle get displayMedium => TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w300,
    fontSize: 14.sp,
    color: black,
  );

  static TextStyle get displaySmall => TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w300,
    fontSize: 12.sp,
    color: black,
  );
}