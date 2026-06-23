import 'package:get/get.dart';
import 'package:reviews_link_v2/data/models/response/support/support_response.dart';

class SupportTicketDetailsController extends GetxController {

  late final SupportResponse data;

  @override
  void onInit() {
    super.onInit();
    data = Get.arguments;
  }
}
