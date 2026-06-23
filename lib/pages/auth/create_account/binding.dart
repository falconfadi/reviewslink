import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/auth/create_account/controller.dart';

class CreateAccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CreateAccountController());
  }
}
