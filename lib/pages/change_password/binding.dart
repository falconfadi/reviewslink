import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/change_password/controller.dart';

class ChangePasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ChangePasswordController());
  }
}
