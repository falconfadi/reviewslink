import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/data/models/body/service/delete_service_review_body.dart';
import 'package:reviews_link_v2/data/models/response/service/service_response.dart';
import 'package:reviews_link_v2/data/repository/service_repo.dart';
import 'package:reviews_link_v2/pages/main_page/services/controller.dart';
import 'package:reviews_link_v2/widgets/snack_bar/top_snack_bar.dart';

class ReviewsController extends GetxController {

  late final ServiceResponse data;
  RxnInt deletingItemId = RxnInt(null);

  ServiceController serviceController = Get.find();
  ServiceRepo serviceRepo = ServiceRepo();

  @override
  void onInit() {
    super.onInit();
    data = Get.arguments as ServiceResponse;
  }

  deleteServiceReview(id, BuildContext context) async {
    deletingItemId.value = id;
    await serviceRepo.deleteServiceReview(
        DeleteServiceReviewBody(reviewId: id)).then((value) async {
          if (value.code == 200) {
            Get.back();
            deletingItemId.value = null;
            await serviceController.getServicesList();
          } else {
            TopSnackBar.warning(context, value.message);
            deletingItemId.value = null;
          }
        });
  }
}
