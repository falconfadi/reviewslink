import 'package:get/get.dart';
import 'package:reviews_link_v2/data/models/response/service/service_response.dart';

class ServicesListProductsController extends GetxController {

  late final ListOfProductsData data;

  @override
  void onInit() {
    super.onInit();
    data = Get.arguments;
  }
}
