import 'package:get/get.dart';
import 'package:reviews_link_v2/data/models/body/codes/get_my_codes_body.dart';
import 'package:reviews_link_v2/data/models/response/codes/qr_request_response.dart';
import 'package:reviews_link_v2/data/repository/codes_repo.dart';

class QrRequestsController extends GetxController {

  RxList<MyQrRequestResponse> codesList = <MyQrRequestResponse>[].obs;
  RxBool loading = false.obs;

  CodesRepo codesRepo = CodesRepo();

  @override
  void onInit() async {
    await getMyCodesList();
    super.onInit();
  }

  getMyCodesList() async {
    codesList.clear();
    loading.value = true;
    await codesRepo
        .getMyCodesRequests(GetMyCodesBody(page: 1, perPage: 100))
        .then((value) async {
          if (value.code == 200) {
            final List codesJson = value.body['requests'] as List;
            final codes = codesJson
                .map((e) => MyQrRequestResponse.fromJson(e))
                .toList();
            codesList.addAll(codes);
            loading.value = false;
          } else {
            loading.value = false;
          }
        });
  }

  showStatus(title) {
    if (title == 0) return 'Pending';
    if (title == 1) return 'Approved';
    if (title == 2) return 'Rejected';
    if (title == 3) return 'Fulfilled';
  }
}
