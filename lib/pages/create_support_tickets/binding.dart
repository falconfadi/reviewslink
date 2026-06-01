import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/create_support_tickets/controller.dart';

class CreateSupportTicketsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CreateSupportTicketsController());
  }
}
