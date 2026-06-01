import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/data/models/body/service/delete_service_body.dart';
import 'package:reviews_link_v2/data/models/body/service/get_services_body.dart';
import 'package:reviews_link_v2/data/repository/service_repo.dart';
import 'package:reviews_link_v2/pages/services/models/service_model.dart';
import 'package:reviews_link_v2/widgets/snack_bar/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceController extends GetxController implements GetxService {
  RxBool loading = false.obs;
  RxBool loadingDelete = false.obs;
  ServiceRepo serviceRepo = ServiceRepo();

  // RxList<ListOfProductsData> listOfProducts = <ListOfProductsData>[].obs;
  // RxList<SingleProductData> products = <SingleProductData>[].obs;
  // RxList<UrlServiceData> urls = <UrlServiceData>[].obs;
  // RxList<RestaurantMenuData> menus = <RestaurantMenuData>[].obs;
  RxList<ServiceModel> allServices = <ServiceModel>[].obs;

  @override
  void onInit() async {
    await getServicesList();
    super.onInit();
  }

  void handleServices(List servicesJson) {
    final services = servicesJson.map((e) => ServiceModel.fromJson(e)).toList();

    // final tempListOfProducts = <ListOfProductsData>[];
    // final tempProducts = <SingleProductData>[];
    // final tempUrls = <UrlServiceData>[];
    // final tempMenus = <RestaurantMenuData>[];

    // for (var service in services) {
    //   switch (service.serviceTypeId) {
    //     case 4:
    //       tempListOfProducts.add(service.jsonData as ListOfProductsData);
    //       break;
    //
    //     case 3:
    //       tempProducts.add(service.jsonData as SingleProductData);
    //       break;
    //
    //     case 2:
    //       tempUrls.add(service.jsonData as UrlServiceData);
    //       break;
    //
    //     case 1:
    //       tempMenus.add(service.jsonData as RestaurantMenuData);
    //       break;
    //   }
    // }
    //
    // listOfProducts.assignAll(tempListOfProducts);
    // products.assignAll(tempProducts);
    // urls.assignAll(tempUrls);
    // menus.assignAll(tempMenus);
    allServices.assignAll(services);
  }

  /// services
  RxInt selectedTab = 0.obs;
  RxInt selectedTabId = 0.obs;
  RxString selectedTabText = ''.obs;

  String getServiceTypeFromTab(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return "list_of_products";
      case 1:
        return "product";
      case 2:
        return "restaurant_menu";
      case 3:
        return "url";
      default:
        return "";
    }
  }

  final allowedTypes = [
    "url",
    "restaurant_menu",
    "product",
    "list_of_products",
  ];

  List<ServiceModel> getFilteredServices() {
    // final selectedType = getServiceTypeFromTab(selectedTab.value);
    // print(selectedType);
    print(selectedTabId.value);
    return allServices
        .where((service) => service.serviceType.id == selectedTabId.value)
        .toList();
  }

  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  getServicesList() async {
    // listOfProducts.clear();
    // urls.clear();
    // menus.clear();
    // products.clear();
    loading.value = true;
    await serviceRepo
        .getMyServices(GetServicesBody(page: 1, perPage: 100))
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
    await serviceRepo.deleteService(DeleteServiceBody(serviceId: id)).then((
      value,
    ) async {
      if (value.code == 200) {
        Get.back();
        loadingDelete.value = false;
        // TopSnackBar.success(context, value.message);
        await getServicesList();
      } else {
        TopSnackBar.warning(context, value.message);
        loadingDelete.value = false;
      }
    });
  }
}
