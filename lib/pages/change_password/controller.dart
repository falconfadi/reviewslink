import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/data/models/body/auth/change_password_body.dart';
import 'package:reviews_link_v2/data/repository/auth_repo.dart';
import 'package:reviews_link_v2/extensions/context_localization.dart';
import 'package:reviews_link_v2/widgets/snack_bar/top_snack_bar.dart';

class ChangePasswordController extends GetxController {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final InitController initController = Get.find();

  RxBool loading = false.obs;
  RxBool showOldPassword = false.obs;
  RxBool showPassword = false.obs;
  RxBool showConfirmPassword = false.obs;

  AuthRepo authRepo = AuthRepo();

  changePasswordRequest(BuildContext context) async {
    if (!loading.value) {
      if (oldPasswordController.text.trim().isNotEmpty &&
          newPasswordController.text.trim().isNotEmpty &&
          confirmPasswordController.text.trim().isNotEmpty) {
        Constant.closeKeyBoard();
        loading.value = true;
        authRepo
            .changePassword(
              ChangePasswordBody(
                oldPassword: oldPasswordController.text,
                newPassword: newPasswordController.text,
                newPasswordConfirm: confirmPasswordController.text,
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
        TopSnackBar.warning(context, context.localizations.empty_field);
      }
    }
  }
}
