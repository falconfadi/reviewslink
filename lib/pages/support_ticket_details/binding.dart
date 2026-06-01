import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/support_ticket_details/controller.dart';
import 'package:reviews_link_v2/pages/support_tickets/controller.dart';

class SupportTicketDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SupportTicketDetailsController());
  }
}
