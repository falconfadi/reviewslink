import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/services/models/service_model.dart';

class ServicesListProductsController extends GetxController {
  late final ListOfProductsData data;

  @override
  void onInit() {
    super.onInit();
    data = Get.arguments;
  }
}
