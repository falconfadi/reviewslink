import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/support_tickets/controller.dart';

class SupportTicketsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SupportTicketsController());
  }
}
