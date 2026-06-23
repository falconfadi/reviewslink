import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/qr_requests/create_qr_request/controller.dart';

class CreateQRRequestBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CreateQRRequestController());
  }
}
