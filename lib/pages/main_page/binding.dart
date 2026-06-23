import 'package:reviews_link_v2/pages/main_page/controller.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/main_page/my_codes/controller.dart';
import 'package:reviews_link_v2/pages/main_page/services/controller.dart';

class MainPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MyCodesController());
    Get.put(MainPageController());
    Get.put(ServiceController());
  }
}
