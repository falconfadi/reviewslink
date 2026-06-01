import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/create_qr_request/controller.dart';

class QRRequestBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(QRRequestController());
  }
}
