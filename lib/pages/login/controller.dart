import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/controllers/app_storage.dart';
import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/data/models/body/auth/login_body.dart';
import 'package:reviews_link_v2/data/models/response/auth/login_response.dart';
import 'package:reviews_link_v2/data/repository/auth_repo.dart';
import 'package:reviews_link_v2/extensions/context_localization.dart';
import 'package:reviews_link_v2/widgets/snack_bar/top_snack_bar.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  InitController initController = Get.find();

  RxBool loading = false.obs;
  RxBool showPassword = true.obs;

  AuthRepo authRepo = AuthRepo();

  Future<void> loginRequest(BuildContext context) async {
    if (passwordController.text.isNotEmpty && emailController.text.isNotEmpty) {
      if (loading.value == false) {
        Constant.closeKeyBoard();
        loading.value = true;
        authRepo
            .login(
              LoginBody(
                email: emailController.text,
                password: passwordController.text,
              ),
            )
            .then((value) async {
              if (value.code == 200) {
                loading.value = false;
                await AppStorage.saveUser(User.fromJson(value.body['user']));
                initController.userData = await AppStorage.getUser();
                emailController.clear();
                passwordController.clear();
                Get.offAllNamed('/mainPage');
              } else if (value.code == 202) {
                loading.value = false;
                TopSnackBar.warning(context, value.message);
                Get.toNamed(
                  '/verificationCode',
                  arguments: {'email': emailController.text},
                );
              } else if (value.code == 401) {
                TopSnackBar.alert(
                  context,
                  context.localizations.mobile_password_wrong,
                );
                loading.value = false;
              } else {
                TopSnackBar.warning(context, value.message);
                loading.value = false;
              }
            });
      }
    } else {
      TopSnackBar.warning(context, context.localizations.empty_field);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
