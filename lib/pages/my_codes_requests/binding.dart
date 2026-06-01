import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/my_codes_requests/controller.dart';

class MyCodeRequestsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MyQrRequestsController());
  }
}
