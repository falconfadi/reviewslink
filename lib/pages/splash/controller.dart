import 'package:get/get.dart';

class SplashController extends GetxController {
  init() async {
    await Future.delayed(Duration(milliseconds: 2500)).then((_) {
      Get.offAllNamed('/login');
    });
  }

  @override
  void onInit() async {
    await init();
    super.onInit();
  }
}
