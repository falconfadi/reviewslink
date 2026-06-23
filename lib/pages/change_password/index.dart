import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/change_password/controller.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';
import 'package:reviews_link_v2/widgets/header/internal_header.dart';
import 'package:reviews_link_v2/widgets/text_field/custom_text_field.dart';

class ChangePasswordPage extends StatelessWidget {

  ChangePasswordPage({super.key});

  final ChangePasswordController changePasswordController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: white,
        appBar: InternalHeader(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25.h),
                Text("Change your password",
                    style: AppTheme.displayLarge.copyWith(fontSize: 22.sp)
                ),
                SizedBox(height: 25.h),
                CustomTextField(
                  controller: changePasswordController.oldPasswordController,
                  title: "Old password",
                  required: true,
                  obscureText: changePasswordController.showOldPassword.value,
                  minLines: 1,
                  maxLines: 1,
                  textInputType: TextInputType.visiblePassword,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      changePasswordController.showOldPassword.value =
                      !changePasswordController.showOldPassword.value;
                    },
                    child: changePasswordController.showOldPassword.value
                        ? Icon(
                      Icons.visibility_off,
                      color: primaryColor.withOpacity(0.7),
                    )
                        : Icon(
                      Icons.visibility,
                      color: primaryColor.withOpacity(0.7),
                    ),
                  ),
                ),
                SizedBox(height: 25.h),
                CustomTextField(
                  controller: changePasswordController.newPasswordController,
                  title: "New password",
                  required: true,
                  obscureText: changePasswordController.showPassword.value,
                  minLines: 1,
                  maxLines: 1,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      changePasswordController.showPassword.value =
                      !changePasswordController.showPassword.value;
                    },
                    child: changePasswordController.showPassword.value
                        ? Icon(
                      Icons.visibility_off,
                      color: primaryColor.withOpacity(0.7),
                    )
                        : Icon(
                      Icons.visibility,
                      color: primaryColor.withOpacity(0.7),
                    ),
                  ),
                  textInputType: TextInputType.visiblePassword,
                ),
                SizedBox(height: 25.h),
                CustomTextField(
                  controller: changePasswordController.confirmPasswordController,
                  title: "Confirm password",
                  required: true,
                  obscureText: changePasswordController.showConfirmPassword.value,
                  minLines: 1,
                  maxLines: 1,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      changePasswordController.showConfirmPassword.value =
                      !changePasswordController
                          .showConfirmPassword
                          .value;
                    },
                    child:
                    changePasswordController.showConfirmPassword.value
                        ? Icon(
                      Icons.visibility_off,
                      color: primaryColor.withOpacity(0.7),
                    )
                        : Icon(
                      Icons.visibility,
                      color: primaryColor.withOpacity(0.7),
                    ),
                  ),
                  textInputType: TextInputType.visiblePassword,
                ),
                SizedBox(height: 50.h),
                CustomButton(
                  width: 1.sw,
                  height: 0.07,
                  title: "Change",
                  onTap: () async {
                    await changePasswordController.changePasswordRequest(context);
                  },
                  borderRadius: 50.r,
                  loading: changePasswordController.loading.value,
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      );
    });
  }
}
