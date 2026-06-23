import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/auth/login/controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
