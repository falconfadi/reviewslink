import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:reviews_link_v2/pages/forget_password/controller.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/res/styles.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';
import 'package:reviews_link_v2/widgets/footer/auth_footer.dart';
import 'package:reviews_link_v2/widgets/header/internal_header.dart';
import 'package:reviews_link_v2/widgets/text_field/custom_text_field.dart';

class ForgetPasswordPage extends StatelessWidget {
  ForgetPasswordPage({super.key});

  final ForgetPasswordController forgetPasswordController = Get.find();
  static PinTheme defaultPinTheme = PinTheme(
    width: 50,
    height: 60,
    textStyle: textStyleForTitle,
    decoration: BoxDecoration(
      color: white,
      border: Border.all(color: lightGrey),
      borderRadius: BorderRadius.circular(10),
    ),
  );
  static PinTheme focusedPinTheme = defaultPinTheme.copyDecorationWith(
    color: white,
    border: Border.all(color: lightGrey),
    borderRadius: BorderRadius.circular(10),
  );
  static PinTheme submittedPinTheme = defaultPinTheme.copyWith(
    decoration: defaultPinTheme.decoration?.copyWith(color: white),
  );

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: white,
        appBar: InternalHeader(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(!forgetPasswordController.otpStatus.value ?
                  "forgot password".toUpperCase() : "reset password".toUpperCase(),
                  style: textStyleForSmallGraySemiBoldText,
                ),
                SizedBox(height: 15),
                Text(
                  !forgetPasswordController.otpStatus.value
                      ? "Check your email"
                      : "Verify code & update password",
                  style: textStyleForTitle,
                ),
                SizedBox(height: 10),
                !forgetPasswordController.otpStatus.value
                    ? Text(
                        "We’ll send a 6-digit verification code to your email if it’s associated with a ReviewsLink account.",
                        style: textStyleForTinyGrayRegularText,
                      )
                    : Text(
                        "We’ve sent a 6-digit code to ${forgetPasswordController.emailController.text}",
                        style: textStyleForTinyGrayRegularText,
                      ),
                if (forgetPasswordController.otpStatus.value)
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: Get.width,
                    child: Center(
                      child: Text(
                        "A reset code has been sent to your email",
                        style: textStyleForSmallGreenSemiBoldText,
                      ),
                    ),
                  ),
                if (!forgetPasswordController.otpStatus.value)
                  Column(
                    children: [
                      SizedBox(height: 30),
                      CustomTextField(
                        width: 0.9,
                        height: 0.07,
                        controller: forgetPasswordController.emailController,
                        title: "Email address",
                        textColor: black,
                        required: true,
                        titleStyle: textStyleForTextField,
                        fillColor: Colors.white,
                        textInputType: TextInputType.text,
                        icon: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(Icons.person),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                if (forgetPasswordController.otpStatus.value)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Verification code",
                        style: textStyleForSmallBlackRegularText,
                      ),
                      SizedBox(height: 10),
                      Pinput(
                        length: 6,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        controller: forgetPasswordController.otpController,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: submittedPinTheme,
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        keyboardType: TextInputType.phone,
                        showCursor: true,
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        width: 0.9,
                        height: 0.07,
                        controller: forgetPasswordController.passwordController,
                        title: "New password",
                        required: true,
                        textColor: black,
                        titleStyle: textStyleForTextField,
                        obscureText:
                            forgetPasswordController.showPassword.value,
                        maxLines: 1,
                        minLines: 1,
                        fillColor: Colors.white,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            forgetPasswordController.showPassword.value =
                                !forgetPasswordController.showPassword.value;
                          },
                          child: forgetPasswordController.showPassword.value
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
                      SizedBox(height: 20),
                      CustomTextField(
                        width: 0.9,
                        height: 0.07,
                        controller:
                            forgetPasswordController.confirmPasswordController,
                        title: "Confirm password",
                        required: true,
                        textColor: black,
                        titleStyle: textStyleForTextField,
                        obscureText:
                            forgetPasswordController.showConfirmPassword.value,
                        maxLines: 1,
                        minLines: 1,
                        fillColor: Colors.white,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            forgetPasswordController.showConfirmPassword.value =
                                !forgetPasswordController
                                    .showConfirmPassword
                                    .value;
                          },
                          child:
                              forgetPasswordController.showConfirmPassword.value
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
                      SizedBox(height: 20),
                    ],
                  ),
                CustomButton(
                  width: Get.width,
                  height: 0.075,
                  color: secondaryColor,
                  title: !forgetPasswordController.otpStatus.value
                      ? "Send reset code"
                      : "Update password",
                  icon: Icon(
                    Icons.arrow_forward_outlined,
                    size: 20,
                    color: Colors.white,
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
                  borderRadiusBottomLeft: 50,
                  borderRadiusBottomRight: 50,
                  borderRadiusTopLeft: 50,
                  borderRadiusTopRight: 50,
                  loadingColor: white,
                  loading: forgetPasswordController.loading.value,
                  textStyle: textStyleForPrimaryButton,
                ),
                SizedBox(height: 20),
                AuthFooterWidget(
                  text: "Remembered your password?",
                  link: "Back to sign in",
                  linkTap: () {
                    Get.back();
                    // Get.off(CreateAccountPage());
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
    });
  }
}
