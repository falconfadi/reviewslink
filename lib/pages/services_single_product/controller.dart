import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/services/models/service_model.dart';

class ServicesSingleProductController extends GetxController {
  late final SingleProductData data;

  @override
  void onInit() {
    super.onInit();
    data = Get.arguments;
  }
}
