import 'dart:ui';

import 'package:reviews_link_v2/pages/services/models/service_model.dart';
import 'package:get/get.dart';

class ServicesRestaurantMenuController extends GetxController {
  late final RestaurantMenuData data;

  @override
  void onInit() {
    super.onInit();
    data = Get.arguments;
  }

  Color hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex'; // add opacity
    }
    return Color(int.parse(hex, radix: 16));
  }
}
