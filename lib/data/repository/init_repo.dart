import 'package:get/get.dart';
import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/data/constant/api_constant.dart';
import 'package:reviews_link_v2/data/dio/api_response.dart';
import 'package:reviews_link_v2/data/dio/api_client.dart';

class InitRepo {
  ApiClient apiClient = ApiClient();
  InitController initController = Get.find();

  Future<ApiResponse> initData() async {
    final res = await apiClient.post(
      INIT,
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
