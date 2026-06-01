import 'package:get/get.dart';
import 'package:reviews_link_v2/data/models/response/init/support_response.dart';
import 'package:reviews_link_v2/data/repository/supoort_repo.dart';

class SupportTicketsController extends GetxController {
  SupportRepo supportRepo = SupportRepo();
  RxBool loading = false.obs;
  RxList<SupportResponse> supportTicketsList = <SupportResponse>[].obs;

  getSupportTickets() async {
    supportTicketsList.clear();
    loading.value = true;
    await supportRepo.getSupportTickets().then((value) async {
      if (value.code == 200) {
        final List ticketsJson = value.body['tickets'] as List;

        final codes = ticketsJson
            .map((e) => SupportResponse.fromJson(e))
            .toList();

        supportTicketsList.addAll(codes);

        loading.value = false;
      } else {
        loading.value = false;
      }
    });
  }

  @override
  void onInit() async {
    await getSupportTickets();
    super.onInit();
  }
}
