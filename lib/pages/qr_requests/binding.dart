import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/qr_requests/controller.dart';

class QrRequestsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(QrRequestsController());
  }
}
