import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/data/models/body/auth/sign_up_body.dart';
import 'package:reviews_link_v2/data/repository/auth_repo.dart';
import 'package:reviews_link_v2/extensions/context_localization.dart';
import 'package:reviews_link_v2/widgets/snack_bar/top_snack_bar.dart';

class CreateAccountController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxString countryDialCode = "+971".obs;
  RxBool loading = false.obs;
  RxBool showPassword = true.obs;

  AuthRepo authRepo = AuthRepo();

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> signUpRequest(BuildContext context) async {
    Constant.closeKeyBoard();
    if (!loading.value) {
      if (fullNameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          phoneNumberController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        if (isValidEmail(emailController.text)) {
          loading.value = true;
          await authRepo
              .signUp(
                SignUpBody(
                  email: emailController.text,
                  password: passwordController.text,
                  name: fullNameController.text,
                  companyName: companyNameController.text,
                  mobile: phoneNumberController.text,
                  mobileCode: countryDialCode.value,
                ),
              )
              .then((value) async {
                if (value.code == 201) {
                  loading.value = false;
                  TopSnackBar.success(
                    context,
                    'Please enter verification code',
                  );
                  Get.toNamed(
                    '/verificationCode',
                    arguments: {'email': emailController.text},
                  );
                } else {
                  TopSnackBar.alert(context, value.message);
                  loading.value = false;
                }
              });
        } else {
          TopSnackBar.warning(context, 'Please enter a valid email address');
        }
      } else {
        loading.value = false;
        TopSnackBar.warning(context, context.localizations.empty_field);
      }
    }
  }
}
