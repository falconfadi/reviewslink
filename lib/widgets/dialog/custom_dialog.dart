import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/res/Keys.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';

class Dialogs {
  static void show(
    BuildContext context, {
    String? title,
    bool? cancelBtn,
    Widget? okBtn,
    Widget? content,
  }) {
    final isCustom = content != null;
    final cancelButton = cancelBtn != null;
    AwesomeDialog(
      dialogBackgroundColor: white,
      context: Keys.navigatorKey.currentContext!,
      dialogType: DialogType.noHeader,
      dismissOnTouchOutside: false,
      headerAnimationLoop: false,
      animType: AnimType.scale,
      body: isCustom ? content : null,
      btnCancel: cancelButton
          ? CustomButton(
              width: Get.width,
              height: 0.05,
              border: Border.all(color: lightGrey, width: 1.5),
              title: "Cancel",
              textStyle: AppTheme.labelLarge.copyWith(fontSize: 18.sp),
              color: white,
              onTap: () {
                Get.back();
              },
            )
          : null,
      btnOk: okBtn,
      title: isCustom ? null : title,
      titleTextStyle: AppTheme.labelLarge.copyWith(fontSize: 18.sp),
    ).show();
  }
}
