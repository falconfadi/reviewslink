import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/controllers/app_storage.dart';
import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/data/models/body/auth/forget_password_body.dart';
import 'package:reviews_link_v2/data/models/body/auth/verify_code_body.dart';
import 'package:reviews_link_v2/data/models/response/auth/login_response.dart';
import 'package:reviews_link_v2/data/repository/auth_repo.dart';
import 'package:reviews_link_v2/extensions/context_localization.dart';
import 'package:reviews_link_v2/widgets/snack_bar/top_snack_bar.dart';

class VerificationCodeController extends GetxController {
  TextEditingController codeController = TextEditingController();

  RxBool loading = false.obs;
  RxBool loadingOtp = false.obs;
  late String email;

  AuthRepo authRepo = AuthRepo();
  InitController initController = Get.find();

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments['email'];
  }

  Future<void> verifyCodeRequest(BuildContext context) async {
    Constant.closeKeyBoard();
    if (!loading.value) {
      if (codeController.text.isNotEmpty) {
        loading.value = true;
        await authRepo
            .verifyCode(VerifyCodeBody(email: email, otp: codeController.text))
            .then((value) async {
              if (value.code == 200) {
                loading.value = false;
                await AppStorage.saveUser(User.fromJson(value.body['user']));
                initController.userData = await AppStorage.getUser();
                Get.offAllNamed('/mainPage');
              } else {
                TopSnackBar.alert(context, value.message);
                loading.value = false;
              }
            });
      } else {
        loading.value = false;
        TopSnackBar.warning(context, context.localizations.empty_field);
      }
    }
  }

  resendCodeOTP(BuildContext context) async {
    if (!loadingOtp.value) {
      loadingOtp.value = true;
      await authRepo.resendCode(ForgetPasswordBody(email: email)).then((value) {
        if (value.code == 200) {
          loadingOtp.value = false;
          TopSnackBar.success(context, value.message);
        } else {
          loadingOtp.value = false;
          TopSnackBar.warning(context, value.message);
        }
      });
    }
  }
}
