import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/controller.dart';

class CreateServiceBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CreateServiceController());
  }
}
