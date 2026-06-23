import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/data/constant/api_constant.dart';
import 'package:reviews_link_v2/data/dio/api_response.dart';
import 'package:reviews_link_v2/data/dio/api_client.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/data/models/body/support/support_body.dart';

class SupportRepo {
  ApiClient apiClient = ApiClient();
  InitController initController = Get.find();

  Future<ApiResponse> addSupport(SupportBody supportBody) async {
    final res = await apiClient.post(
      ADD_SUPPORT,
      data: supportBody.toJson(),
      headers: initController.userData != null
          ? {'Authorization': 'Bearer ${initController.userData!.token}'}
          : {},
    );
    if (res.code == 201) {
      print('get');
      return res;
    } else {
      print('Failed: ${res.status} - ${res.message}');
      return res;
    }
  }

  Future<ApiResponse> updateSupport(SupportBody supportBody) async {
    final res = await apiClient.post(
      UPDATE_SUPPORT,
      data: supportBody.toJson(),
      headers: initController.userData != null
          ? {'Authorization': 'Bearer ${initController.userData!.token}'}
          : {},
    );
    if (res.code == 200) {
      print('get');
      return res;
    } else {
      print('Failed: ${res.status} - ${res.message}');
      return res;
    }
  }

  Future<ApiResponse> getSupportTickets() async {
    final res = await apiClient.post(
      GET_SUPPORT_TICKETS,
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
