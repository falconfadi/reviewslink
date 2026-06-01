import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/data/dio/api_response.dart';
import 'package:reviews_link_v2/data/models/body/service/create_service_list_of_products_body.dart';
import 'package:reviews_link_v2/data/models/body/service/create_service_single_product.dart';
import 'package:reviews_link_v2/data/models/body/service/create_service_url_body.dart';
import 'package:reviews_link_v2/data/models/body/service/delete_service_body.dart';
import 'package:reviews_link_v2/data/models/body/service/get_services_body.dart';
import 'package:reviews_link_v2/data/models/body/service/update_service_list_of_product_body.dart';
import 'package:reviews_link_v2/data/models/body/service/update_service_single_product.dart';
import 'package:reviews_link_v2/data/models/body/service/update_service_url_body.dart';

import '../../data/constant/api_constant.dart';
import '../../data/dio/dio_client_new.dart';
import 'package:get/get.dart';

class ServiceRepo {
  ApiClient apiClient = ApiClient();
  InitController initController = Get.find();

  Future<ApiResponse> getMyServices(GetServicesBody getServicesBody) async {
    final res = await apiClient.post(
      GET_MY_SERVICES,
      data: getServicesBody.toJson(),
      headers: {'Authorization': 'Bearer ${initController.userData!.token}'},
    );
    if (res.code == 200) {
      print('get');
      return res;
    } else {
      print('Failed: ${res.status} - ${res.message}');
      return res;
    }
  }

  Future<ApiResponse> createServiceUrl(
    CreateServiceUrlBody createServiceUrlBody,
  ) async {
    final res = await apiClient.post(
      CREATE_SERVICES,
      data: createServiceUrlBody.toJson(),
      headers: {'Authorization': 'Bearer ${initController.userData!.token}'},
    );
    if (res.code == 201) {
      print('done');
      return res;
    } else {
      print('Failed: ${res.status} - ${res.message}');
      return res;
    }
  }

  Future<ApiResponse> createServiceSingleProduct(
    CreateServiceSingleProductBody createServiceSingleProductBody,
  ) async {
    final res = await apiClient.post(
      CREATE_SERVICES,
      data: createServiceSingleProductBody.toFormData(),
      headers: {'Authorization': 'Bearer ${initController.userData!.token}'},
    );
    if (res.code == 201) {
      print('done');
      return res;
    } else {
      print('Failed: ${res.status} - ${res.message}');
      return res;
    }
  }

  Future<ApiResponse> createServiceListOfProducts(
    CreateServiceListOfProductsBody createServiceListOfProductsBody,
  ) async {
    final res = await apiClient.post(
      CREATE_SERVICES,
      data: createServiceListOfProductsBody.toFormData(),
      headers: {
        'Authorization': 'Bearer ${initController.userData!.token}',
        'Content-Type': 'multipart/form-data',
      },
    );
    if (res.code == 201) {
      print('done');
      return res;
    } else {
      print('Failed: ${res.status} - ${res.message}');
      return res;
    }
  }

  Future<ApiResponse> updateServiceUrl(
    UpdateServiceUrlBody updateServiceUrlBody,
  ) async {
    final res = await apiClient.post(
      UPDATE_SERVICE,
      data: updateServiceUrlBody.toJson(),
      headers: {'Authorization': 'Bearer ${initController.userData!.token}'},
    );
    if (res.code == 200) {
      print('done');
      return res;
    } else {
      print('Failed: ${res.status} - ${res.message}');
      return res;
    }
  }

  Future<ApiResponse> updateServiceSingleProduct(
    UpdateServiceSingleProductBody updateServiceSingleProductBody,
  ) async {
    final res = await apiClient.post(
      UPDATE_SERVICE,
      data: updateServiceSingleProductBody.toFormData(),
      headers: {'Authorization': 'Bearer ${initController.userData!.token}'},
    );
    if (res.code == 200) {
      print('done');
      return res;
    } else {
      print('Failed: ${res.status} - ${res.message}');
      return res;
    }
  }

  Future<ApiResponse> updateServiceListOfProducts(
    UpdateServiceListOfProductsBody updateServiceListOfProductsBody,
  ) async {
    final res = await apiClient.post(
      UPDATE_SERVICE,
      data: updateServiceListOfProductsBody.toFormData(),
      headers: {
        'Authorization': 'Bearer ${initController.userData!.token}',
        'Content-Type': 'multipart/form-data',
      },
    );
    if (res.code == 200) {
      print('done');
      return res;
    } else {
      print('Failed: ${res.status} - ${res.message}');
      return res;
    }
  }

  Future<ApiResponse> deleteService(DeleteServiceBody deleteServiceBody) async {
    final res = await apiClient.post(
      DELETE_SERVICE,
      data: deleteServiceBody.toJson(),
      headers: {'Authorization': 'Bearer ${initController.userData!.token}'},
    );

    if (res.code == 200) {
      print('get');
      return res;
    } else {
      print('Failed: ${res.code} - ${res.message}');
      return res;
    }
  }
}
