import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/data/dio/api_response.dart';
import 'package:reviews_link_v2/data/models/body/service/create/create_service_rating_form_body.dart';
import 'package:reviews_link_v2/data/models/body/service/create/create_service_social_media_body.dart';
import 'package:reviews_link_v2/data/models/body/service/create/create_service_url_body.dart';
import 'package:reviews_link_v2/data/models/body/service/delete_service_review_body.dart';
import 'package:reviews_link_v2/data/models/body/service/delete_service_body.dart';
import 'package:reviews_link_v2/data/models/body/service/get_services_body.dart';
import 'package:reviews_link_v2/data/models/body/service/update/update_service_rating_form_body.dart';
import 'package:reviews_link_v2/data/models/body/service/update/update_service_social_media_body.dart';
import 'package:reviews_link_v2/data/models/body/service/update/update_service_url_body.dart';
import '../../data/constant/api_constant.dart';
import '../../data/dio/api_client.dart';
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

  Future<ApiResponse> createServiceUrl(CreateServiceUrlBody createServiceUrlBody) async {
    final res = await apiClient.post(
      CREATE_SERVICE,
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

  Future<ApiResponse> updateServiceUrl(UpdateServiceUrlBody updateServiceUrlBody) async {
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

  Future<ApiResponse> createServiceRatingForm(CreateServiceRatingFormBody createServiceRatingFormBody) async {
    final res = await apiClient.post(
      CREATE_SERVICE,
      data: createServiceRatingFormBody.toJson(),
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

  Future<ApiResponse> updateServiceRatingForm(UpdateServiceRatingFormBody updateServiceRatingFormBody) async {
    final res = await apiClient.post(
      UPDATE_SERVICE,
      data: updateServiceRatingFormBody.toJson(),
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

  Future<ApiResponse> deleteServiceReview(DeleteServiceReviewBody deleteServiceReviewBody) async {
    final res = await apiClient.post(
      DELETE_SERVICE_REVIEW,
      data: deleteServiceReviewBody.toJson(),
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

  Future<ApiResponse> createServiceSocialMedia(CreateServiceSocialMediaBody createServiceSocialMediaBody) async {
    final formData = await createServiceSocialMediaBody.toFormData();

    final res = await apiClient.post(
      CREATE_SERVICE,
      data: formData,
      headers: {
        'Authorization': 'Bearer ${initController.userData!.token}',
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

  Future<ApiResponse> updateServiceSocialMedia(UpdateServiceSocialMediaBody updateServiceSocialMediaBody) async {
    final formData = await updateServiceSocialMediaBody.toFormData();

    final res = await apiClient.post(
      UPDATE_SERVICE,
      data: formData,
      headers: {
        'Authorization': 'Bearer ${initController.userData!.token}',
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

}
