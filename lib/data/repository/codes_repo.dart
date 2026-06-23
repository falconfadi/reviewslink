import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/data/dio/api_response.dart';
import 'package:reviews_link_v2/data/models/body/codes/assign_code_to_service_body.dart';
import 'package:reviews_link_v2/data/models/body/codes/claim_code_body.dart';
import 'package:reviews_link_v2/data/models/body/codes/create_qr_request_body.dart';
import 'package:reviews_link_v2/data/models/body/codes/get_my_codes_body.dart';
import '../../data/constant/api_constant.dart';
import '../../data/dio/api_client.dart';
import 'package:get/get.dart';

class CodesRepo {
  ApiClient apiClient = ApiClient();
  InitController initController = Get.find();

  Future<ApiResponse> getMyCodes(GetMyCodesBody getMyCodesBody) async {
    final res = await apiClient.post(
      GET_MY_CODES,
      data: getMyCodesBody.toJson(),
      headers: {'Authorization': 'Bearer ${initController.userData!.token}'},
    );
    if (res.code == 200) {
      print('get');
      return res;
    } else {
      print('Failed: ${res.status} - ${res.message}');
      return res;
    }
  }

  Future<ApiResponse> getMyCodesRequests(GetMyCodesBody getMyCodesBody) async {
    final res = await apiClient.post(
      MY_QR_REQUESTS,
      data: getMyCodesBody.toJson(),
      headers: {'Authorization': 'Bearer ${initController.userData!.token}'},
    );
    if (res.code == 200) {
      print('get');
      return res;
    } else {
      print('Failed: ${res.status} - ${res.message}');
      return res;
    }
  }

  Future<ApiResponse> assignCodeToService(
    AssignCodeToServiceBody assignCodeToServiceBody,
  ) async {
    final res = await apiClient.post(
      ASSIGN_CODES,
      data: assignCodeToServiceBody.toJson(),
      headers: {'Authorization': 'Bearer ${initController.userData!.token}'},
    );
    if (res.code == 200) {
      print('get');
      return res;
    } else {
      print('Failed: ${res.status} - ${res.message}');
      return res;
    }
  }

  Future<ApiResponse> claimCode(ClaimCodeBody claimCodeBody) async {
    final res = await apiClient.post(
      CLAIM_CODE,
      data: claimCodeBody.toJson(),
      headers: {'Authorization': 'Bearer ${initController.userData!.token}'},
    );
    if (res.code == 200) {
      print('get');
      return res;
    } else {
      print('Failed: ${res.status} - ${res.message}');
      return res;
    }
  }

  Future<ApiResponse> createQrRequest(
    CreateCodeRequestBody createCodeRequestBody,
  ) async {
    final res = await apiClient.post(
      QR_REQUEST,
      data: createCodeRequestBody.toJson(),
      headers: {'Authorization': 'Bearer ${initController.userData!.token}'},
    );
    if (res.code == 200) {
      print('get');
      return res;
    } else {
      print('Failed: ${res.status} - ${res.message}');
      return res;
    }
  }
}
