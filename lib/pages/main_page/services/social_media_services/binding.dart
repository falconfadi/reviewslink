import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/main_page/services/social_media_services/controller.dart';

class SocialMediaServicesBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SocialMediaServicesController());
  }
}
