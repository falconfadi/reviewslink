import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/change_password/controller.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/res/styles.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';
import 'package:reviews_link_v2/widgets/text_field/custom_text_field.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key});

  final ChangePasswordController changePasswordController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          shadowColor: lightGrey.withOpacity(0.2),
          surfaceTintColor: white,
          iconTheme: IconThemeData(color: primaryColor),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text("Change your password", style: textStyleForTitle),
                SizedBox(height: 20),
                Column(
                  children: [
                    CustomTextField(
                      width: 0.9,
                      height: 0.07,
                      controller: changePasswordController.oldPasswordController,
                      title: "Old password",
                      required: true,
                      obscureText: changePasswordController.showOldPassword.value,
                      minLines: 1,
                      maxLines: 1,
                      textColor: black,
                      titleStyle: textStyleForTextField,
                      fillColor: Colors.white,
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
                    SizedBox(height: 20),
                    CustomTextField(
                      width: 0.9,
                      height: 0.07,
                      controller: changePasswordController.newPasswordController,
                      title: "New password",
                      required: true,
                      textColor: black,
                      titleStyle: textStyleForTextField,
                      obscureText: changePasswordController.showPassword.value,
                      minLines: 1,
                      maxLines: 1,
                      fillColor: Colors.white,
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
                    SizedBox(height: 20),
                    CustomTextField(
                      width: 0.9,
                      height: 0.07,
                      controller: changePasswordController.confirmPasswordController,
                      title: "Confirm password",
                      required: true,
                      textColor: black,
                      titleStyle: textStyleForTextField,
                      obscureText:
                          changePasswordController.showConfirmPassword.value,
                      minLines: 1,
                      maxLines: 1,
                      fillColor: Colors.white,
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
                    SizedBox(height: 40),
                  ],
                ),
                CustomButton(
                  width: Get.width,
                  height: 0.075,
                  color: secondaryColor,
                  title: "Change",
                  onTap: () async {
                    await changePasswordController.changePasswordRequest(
                      context,
                    );
                  },
                  borderRadiusBottomLeft: 50,
                  borderRadiusBottomRight: 50,
                  borderRadiusTopLeft: 50,
                  borderRadiusTopRight: 50,
                  loadingColor: white,
                  loading: changePasswordController.loading.value,
                  textStyle: textStyleForPrimaryButton,
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      );
    });
  }
}
