import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/data/models/body/codes/create_qr_request_body.dart';
import 'package:reviews_link_v2/data/repository/codes_repo.dart';
import 'package:reviews_link_v2/extensions/context_localization.dart';
import 'package:reviews_link_v2/widgets/snack_bar/top_snack_bar.dart';

class CreateQRRequestController extends GetxController {

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController numberOfQRsController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  RxBool loading = false.obs;
  RxString countryDialCode = "+971".obs;

  final InitController initController = Get.find();
  CodesRepo codesRepo = CodesRepo();

  @override
  void onInit() {
    fullNameController.text = initController.userData!.userName ?? "";
    emailController.text = initController.userData!.userEmail ?? "";
    phoneNumberController.text = initController.userData!.mobile ?? "";
    countryDialCode.value = initController.userData!.mobileCode ?? "+971";
    companyController.text = initController.userData!.companyName ?? "";
    super.onInit();
  }

  bool validateInputs() {
    if (fullNameController.text.trim().isEmpty) {
      return false;
    }
    if (emailController.text.trim().isEmpty) {
      return false;
    }
    if (!GetUtils.isEmail(emailController.text.trim())) {
      return false;
    }
    if (numberOfQRsController.text.trim().isEmpty) {
      return false;
    }

    return true;
  }

  createQrRequest(BuildContext context) async {
    if (!loading.value) {
      if (validateInputs()) {
        loading.value = true;
        await codesRepo
            .createQrRequest(
              CreateCodeRequestBody(
                contactName: fullNameController.text,
                contactEmail: emailController.text,
                contactPhone: countryDialCode + phoneNumberController.text,
                companyName: companyController.text,
                notes: notesController.text,
                quantity: int.parse(numberOfQRsController.text),
              ),
            ).then((value) {
              if (value.code == 201) {
                loading.value = false;
                Get.back();
                TopSnackBar.success(context, value.message);
              } else {
                loading.value = false;
                TopSnackBar.warning(context, value.message);
              }
            });
      } else {
        TopSnackBar.warning(context, context.localizations.empty_field);
      }
    }
  }
}
