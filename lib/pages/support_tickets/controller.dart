import 'package:get/get.dart';
import 'package:reviews_link_v2/data/models/response/support/support_response.dart';
import 'package:reviews_link_v2/data/repository/supoort_repo.dart';

class SupportTicketsController extends GetxController {

  RxBool loading = false.obs;
  RxList<SupportResponse> supportTicketsList = <SupportResponse>[].obs;

  SupportRepo supportRepo = SupportRepo();

  @override
  void onInit() async {
    await getSupportTickets();
    super.onInit();
  }

  getSupportTickets() async {
    supportTicketsList.clear();
    loading.value = true;
    await supportRepo.getSupportTickets().then((value) async {
      if (value.code == 200) {
        final List ticketsJson = value.body['tickets'] as List;
        final codes = ticketsJson
            .map((e) => SupportResponse.fromJson(e)).toList();
        supportTicketsList.addAll(codes);
        loading.value = false;
      } else {
        loading.value = false;
      }
    });
  }
}
