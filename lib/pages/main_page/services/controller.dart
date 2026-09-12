import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/data/models/body/service/delete_service_body.dart';
import 'package:reviews_link_v2/data/models/body/service/get_services_body.dart';
import 'package:reviews_link_v2/data/models/response/service/service_response.dart';
import 'package:reviews_link_v2/data/repository/service_repo.dart';
import 'package:reviews_link_v2/widgets/snack_bar/top_snack_bar.dart';

class ServiceController extends GetxController implements GetxService {

  RxBool loading = false.obs;
  RxBool loadingDelete = false.obs;
  RxList<ServiceResponse> allServices = <ServiceResponse>[].obs;
  RxInt selectedTab = 0.obs;
  RxInt selectedTabId = 0.obs;
  RxString selectedTabText = ''.obs;

  ServiceRepo serviceRepo = ServiceRepo();

  @override
  void onInit() async {
    await getServicesList();
    super.onInit();
  }

  final allowedTypes = [
    "url",
    "social_media_cards_4",
    "social_media_cards_8",
    "social_media_cards_unlimited",
    "rating_form"
  ];

  void handleServices(List servicesJson) {
    final services = servicesJson.map((e) => ServiceResponse.fromJson(e)).toList();
    allServices.assignAll(services);
  }

  List<ServiceResponse> get filteredServices {
    return allServices
        .where((service) => service.serviceType.id == selectedTabId.value)
        .toList();
  }

  getServicesList() async {
    loading.value = true;
    await serviceRepo.getMyServices(GetServicesBody(page: 1, perPage: 100))
        .then((value) async {
      if (value.code == 200) {
        handleServices(value.body['services']);
        loading.value = false;
      } else {
        loading.value = false;
      }
    });
  }

  deleteService(id, BuildContext context) async {
    loadingDelete.value = true;
    await serviceRepo.deleteService(
        DeleteServiceBody(serviceId: id))
        .then((value,
        ) async {
      if (value.code == 200) {
        Get.back();
        loadingDelete.value = false;
        await getServicesList();
      } else {
        TopSnackBar.warning(context, value.message);
        loadingDelete.value = false;
      }
    });
  }
}
