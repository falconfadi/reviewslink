import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/data/dio/api_response.dart';
import 'package:reviews_link_v2/data/models/body/auth/change_password_body.dart';
import 'package:reviews_link_v2/data/models/body/auth/forget_password_body.dart';
import 'package:reviews_link_v2/data/models/body/auth/login_body.dart';
import 'package:reviews_link_v2/data/models/body/auth/reset_password_body.dart';
import 'package:reviews_link_v2/data/models/body/auth/sign_up_body.dart';
import 'package:reviews_link_v2/data/models/body/auth/update_profile_body.dart';
import 'package:reviews_link_v2/data/models/body/auth/verify_code_body.dart';
import '../../data/constant/api_constant.dart';
import '../../data/dio/api_client.dart';
import 'package:get/get.dart';

class AuthRepo {
  ApiClient apiClient = ApiClient();
  InitController initController = Get.find();

  Future<ApiResponse> login(LoginBody loginBody) async {
    final res = await apiClient.post(LOGIN, data: loginBody.toJson());
    if (res.code == 200) {
      print('get');
      return res;
    } else {
      print('Failed: ${res.status} - ${res.message}');
      return res;
    }
  }

  Future<ApiResponse> signUp(SignUpBody signUpBody) async {
    final res = await apiClient.post(REGISTER, data: signUpBody.toJson());

    if (res.code == 201) {
      print('get');
      return res;
    } else {
      print('Failed: ${res.code} - ${res.message}');
      return res;
    }
  }

  Future<ApiResponse> verifyCode(VerifyCodeBody verifyCodeBody) async {
    final res = await apiClient.post(
      VERIFY_CODE,
      data: verifyCodeBody.toJson(),
    );

    if (res.code == 201) {
      print('get');
      return res;
    } else {
      print('Failed: ${res.code} - ${res.message}');
      return res;
    }
  }

  Future<ApiResponse> forgetPassword(
    ForgetPasswordBody forgetPasswordBody,
  ) async {
    final res = await apiClient.post(
      FORGET_PASSWORD,
      data: forgetPasswordBody.toJson(),
    );

    if (res.code == 200) {
      print('get');
      return res;
    } else {
      print('Failed: ${res.code} - ${res.message}');
      return res;
    }
  }

  Future<ApiResponse> resetPassword(ResetPasswordBody resetPasswordBody) async {
    final res = await apiClient.post(
      RESET_PASSWORD,
      data: resetPasswordBody.toJson(),
    );

    if (res.code == 200) {
      print('get');
      return res;
    } else {
      print('Failed: ${res.code} - ${res.message}');
      return res;
    }
  }

  Future<ApiResponse> changePassword(
    ChangePasswordBody changePasswordBody,
  ) async {
    final res = await apiClient.post(
      CHANGE_PASSWORD,
      data: changePasswordBody.toJson(),
      headers: {'Authorization': 'Bearer ${initController.userData!.token}'},
    );

    if (res.code == 200) {
      print('get');
      return res;
    } else {
      print('Failed: ${res.code} - ${res.message}');
      return res;
    }
  }

  Future<ApiResponse> resendCode(ForgetPasswordBody forgetPasswordBody) async {
    final res = await apiClient.post(
      RESEND_CODE,
      data: forgetPasswordBody.toJson(),
    );

    if (res.code == 200) {
      print('get');
      return res;
    } else {
      print('Failed: ${res.code} - ${res.message}');
      return res;
    }
  }

  Future<ApiResponse> updateProfile(UpdateProfileBody updateProfileBody) async {
    final res = await apiClient.post(
      UPDATE_PROFILE,
      headers: {
        'Authorization': 'Bearer ${initController.userData!.token}',
        'Content-Type': 'application/json',
      },
      data: updateProfileBody.toFormData(),
    );

    if (res.code == 200) {
      print('get');
      return res;
    } else {
      print('Failed: ${res.code} - ${res.message}');
      return res;
    }
  }
}
