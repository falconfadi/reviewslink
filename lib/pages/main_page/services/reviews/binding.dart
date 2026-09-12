import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/main_page/services/reviews/controller.dart';

class ReviewsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ReviewsController());
  }
}
