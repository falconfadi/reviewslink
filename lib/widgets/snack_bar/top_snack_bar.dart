import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/extensions/context_localization.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';

class TopSnackBar {

  static void success(BuildContext context, String message) {
    _show(
      context: context,
      title: context.localizations.success,
      message: message,
      backgroundColor: Colors.green.withOpacity(0.5),
    );
  }

  static void alert(BuildContext context, String message) {
    _show(
      context: context,
      title: context.localizations.alert,
      message: message,
      backgroundColor: Colors.redAccent,
    );
  }

  static void warning(BuildContext context, String message) {
    _show(
      context: context,
      title: context.localizations.warning,
      message: message,
      backgroundColor: Colors.grey.withOpacity(0.8),
    );
  }

  static void _show({
    required BuildContext context, required String title,
    required String message, required Color backgroundColor}) {
    final bool isTablet = Constant.isTablet(context);

    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      duration: const Duration(milliseconds: 4000),
      margin: EdgeInsets.only(top: 15.h, right: 15.w, left: 15.w),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      titleText: isTablet ? Text(title, style: AppTheme.bodyLarge.copyWith(color: white)) : null,
      messageText: isTablet ? Text(message, style: AppTheme.labelMedium.copyWith(color: white)) : null,
    );
  }
}

