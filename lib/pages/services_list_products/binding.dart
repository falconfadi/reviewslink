import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/services_list_products/controller.dart';

class ServicesListProductsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ServicesListProductsController());
  }
}
