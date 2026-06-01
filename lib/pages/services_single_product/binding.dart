import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/services_single_product/controller.dart';

class ServicesSingleProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ServicesSingleProductController());
  }
}
