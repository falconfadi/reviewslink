import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/profile/controller.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ProfileController());
  }
}
