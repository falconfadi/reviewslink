import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/forget_password/controller.dart';

class ForgetPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ForgetPasswordController());
  }
}
