import 'package:get/get.dart';

class SplashController extends GetxController {

  @override
  void onInit() async {
    await init();
    super.onInit();
  }

  init() async {
    await Future.delayed(Duration(seconds: 2)).then((_) {
      Get.offAllNamed('/login');
    });
  }

}
