import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/main_page/services/services_restaurant_menu/controller.dart';

class ServicesRestaurantMenuBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ServicesRestaurantMenuController());
  }
}
