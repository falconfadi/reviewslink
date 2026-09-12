import 'package:get/get.dart';
import 'package:reviews_link_v2/data/models/response/service/service_response.dart';

class SocialMediaServicesController extends GetxController {

  late final SocialMediaServiceData data;

  @override
  void onInit() {
    super.onInit();
    data = Get.arguments;
  }
}
