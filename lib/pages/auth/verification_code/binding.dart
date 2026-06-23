import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/auth/verification_code/controller.dart';

class VerificationCodeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(VerificationCodeController());
  }
}
