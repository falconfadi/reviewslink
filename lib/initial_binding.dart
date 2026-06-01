import '../../controllers/init_controller.dart';
import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(InitController());
    // Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
