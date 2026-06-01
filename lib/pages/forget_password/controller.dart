import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/data/models/body/auth/forget_password_body.dart';
import 'package:reviews_link_v2/data/models/body/auth/reset_password_body.dart';
import 'package:reviews_link_v2/data/repository/auth_repo.dart';
import 'package:reviews_link_v2/extensions/context_localization.dart';
import 'package:reviews_link_v2/widgets/snack_bar/top_snack_bar.dart';

class ForgetPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final InitController initController = Get.find();

  RxBool loading = false.obs;
  RxBool showPassword = false.obs;
  RxBool showConfirmPassword = false.obs;
  RxBool otpStatus = false.obs;

  AuthRepo authRepo = AuthRepo();

  sendForgetPasswordRequest(BuildContext context) async {
    if (!loading.value) {
      if (emailController.text.isNotEmpty) {
        if (isValidEmail(emailController.text)) {
          loading.value = true;
          authRepo
              .forgetPassword(ForgetPasswordBody(email: emailController.text))
              .then((value) {
                if (value.code == 200) {
                  loading.value = false;
                  otpStatus.value = true;
                  TopSnackBar.success(context, value.message);
                } else if (value.code == 404) {
                  loading.value = false;
                  TopSnackBar.alert(context, value.message);
                } else {
                  loading.value = false;
                  TopSnackBar.warning(context, value.message);
                }
              });
        } else {
          TopSnackBar.warning(context, 'Please enter a valid email address');
        }
      } else {
        TopSnackBar.warning(context, 'Email field is empty');
      }
    }
  }

  resetPasswordRequest(BuildContext context) async {
    if (!loading.value) {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty &&
          otpController.text.isNotEmpty) {
        if (passwordController.text == confirmPasswordController.text) {
          loading.value = true;
          authRepo
              .resetPassword(
                ResetPasswordBody(
                  email: emailController.text,
                  otp: otpController.text,
                  password: passwordController.text,
                  passwordConfirm: confirmPasswordController.text,
                ),
              )
              .then((value) {
                if (value.code == 200) {
                  loading.value = false;
                  Get.back();
                  TopSnackBar.success(context, value.message);
                } else {
                  loading.value = false;
                  TopSnackBar.warning(context, value.message);
                }
              });
        } else {
          TopSnackBar.warning(
            context,
            'The password and password confirmation do not match',
          );
        }
      } else {
        TopSnackBar.warning(context, context.localizations.empty_field);
      }
    }
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  void onInit() {
    emailController.text = Get.arguments;
    super.onInit();
  }
}
