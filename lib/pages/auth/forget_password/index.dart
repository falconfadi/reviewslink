import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/pages/auth/forget_password/controller.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';
import 'package:reviews_link_v2/widgets/footer/custom_footer.dart';
import 'package:reviews_link_v2/widgets/header/internal_header.dart';
import 'package:reviews_link_v2/widgets/text_field/custom_text_field.dart';

class ForgetPasswordPage extends StatelessWidget {

  ForgetPasswordPage({super.key});

  final ForgetPasswordController forgetPasswordController = Get.find();

  @override
  Widget build(BuildContext context) {
    final isTablet = Constant.isTablet(context);
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
                Text(!forgetPasswordController.otpStatus.value ?
                  "forgot password".toUpperCase() : "reset password".toUpperCase(),
                  style: AppTheme.bodyLarge.copyWith(color: grey),
                ),
                SizedBox(height: 20.h),
                Text(
                  !forgetPasswordController.otpStatus.value
                      ? "Check your email"
                      : "Verify code & update password",
                  style: AppTheme.displayLarge.copyWith(fontSize: 22.sp),
                ),
                SizedBox(height: 15.h),
                 Text(!forgetPasswordController.otpStatus.value ?
                 "We’ll send a 6-digit verification code to your email if it’s associated with a ReviewsLink account." :
                 "We’ve sent a 6-digit code to ${forgetPasswordController.emailController.text}",
                        style: AppTheme.labelMedium.copyWith(color: grey),
                      ),
                if (forgetPasswordController.otpStatus.value)
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    width: 1.sw,
                    child: Center(
                      child: Text(
                        "A reset code has been sent to your email",
                        style: AppTheme.bodyLarge.copyWith(color: green),
                      ),
                    ),
                  ),
                if (!forgetPasswordController.otpStatus.value)
                  Column(
                    children: [
                      SizedBox(height: 30.h),
                      CustomTextField(
                        controller: forgetPasswordController.emailController,
                        title: "Email address",
                        required: true,
                        textInputType: TextInputType.text,
                        icon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Icon(Icons.person,size: isTablet ? 20.sp : null),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 25.h),
                if (forgetPasswordController.otpStatus.value)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Verification code",
                        style: AppTheme.labelLarge,
                      ),
                      SizedBox(height: 15.h),
                      Pinput(
                        length: 6,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        controller: forgetPasswordController.otpController,
                        defaultPinTheme: Constant.defaultPinTheme,
                        focusedPinTheme: Constant.focusedPinTheme,
                        submittedPinTheme: Constant.submittedPinTheme,
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        keyboardType: TextInputType.phone,
                        showCursor: true,
                      ),
                      SizedBox(height: 25.h),
                      CustomTextField(
                        controller: forgetPasswordController.passwordController,
                        title: "New password",
                        required: true,
                        obscureText: forgetPasswordController.showPassword.value,
                        maxLines: 1,
                        minLines: 1,
                        suffixIcon: Padding(
                          padding: isTablet
                              ? EdgeInsets.symmetric(horizontal: 10.w)
                              : EdgeInsets.zero,
                          child: GestureDetector(
                            onTap: () {
                              forgetPasswordController.showPassword.value =
                                  !forgetPasswordController.showPassword.value;
                            },
                            child: forgetPasswordController.showPassword.value
                                ? Icon(
                                Icons.visibility_off,
                                color: primaryColor.withOpacity(0.7),
                                size: isTablet ? 20.sp : null
                                  )
                                : Icon(
                                Icons.visibility,
                                color: primaryColor.withOpacity(0.7),
                                size: isTablet ? 20.sp : null
                            ),
                          ),
                        ),
                        textInputType: TextInputType.visiblePassword,
                      ),
                      SizedBox(height: 25.h),
                      CustomTextField(
                        controller: forgetPasswordController.confirmPasswordController,
                        title: "Confirm password",
                        required: true,
                        obscureText: forgetPasswordController.showConfirmPassword.value,
                        maxLines: 1,
                        minLines: 1,
                        suffixIcon: Padding(
                          padding: isTablet
                              ? EdgeInsets.symmetric(horizontal: 10.w)
                              : EdgeInsets.zero,
                          child: GestureDetector(
                            onTap: () {
                              forgetPasswordController.showConfirmPassword.value =
                                  !forgetPasswordController.showConfirmPassword.value;
                            },
                            child:
                                forgetPasswordController.showConfirmPassword.value
                                ? Icon(
                                    Icons.visibility_off,
                                    color: primaryColor.withOpacity(0.7),
                                    size: isTablet ? 20.sp : null
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: primaryColor.withOpacity(0.7),
                                    size: isTablet ? 20.sp : null
                                  ),
                          ),
                        ),
                        textInputType: TextInputType.visiblePassword,
                      ),
                      SizedBox(height: 25.h),
                    ],
                  ),
                SizedBox(height: 25.h),
                CustomButton(
                  width: 1.sw,
                  height: 0.07,
                  title: !forgetPasswordController.otpStatus.value
                      ? "Send reset code"
                      : "Update password",
                  icon: Icon(
                    Icons.arrow_forward_outlined,
                    size: 22.sp,
                    color: white,
                  ),
                  onTap: () {
                    if (forgetPasswordController.otpStatus.value) {
                      forgetPasswordController.resetPasswordRequest(context);
                    } else {
                      forgetPasswordController.sendForgetPasswordRequest(
                        context,
                      );
                    }
                  },
                  borderRadius: 50.r,
                  loading: forgetPasswordController.loading.value,
                ),
                SizedBox(height: 30.h),
                CustomFooterWidget(
                  text: "Remembered your password?",
                  link: "Back to sign in",
                  linkTap: () {
                    Get.back();
                  },
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
