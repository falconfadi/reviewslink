import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/data/models/body/support_body.dart';
import 'package:reviews_link_v2/data/models/response/init/support_response.dart';
import 'package:reviews_link_v2/data/repository/supoort_repo.dart';
import 'package:reviews_link_v2/extensions/context_localization.dart';
import 'package:reviews_link_v2/pages/support_tickets/controller.dart';
import 'package:reviews_link_v2/widgets/snack_bar/top_snack_bar.dart';

class CreateSupportTicketsController extends getx.GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController subjectController = TextEditingController();

  InitController initController = getx.Get.find();
  SupportTicketsController? supportTicketsController;

  getx.RxBool loading = false.obs;
  getx.RxBool changeStatus = true.obs;
  bool? editStatus;
  SupportResponse? chosenToEdit;

  SupportRepo supportRepo = SupportRepo();

  String countryDialCode = "ae";

  Future<void> createSupport(BuildContext context) async {
    Constant.closeKeyBoard();
    if (!loading.value) {
      if (emailController.text.isNotEmpty &&
          messageController.text.isNotEmpty &&
          fullNameController.text.isNotEmpty &&
          mobileController.text.isNotEmpty &&
          subjectController.text.isNotEmpty) {
        loading.value = true;
        await supportRepo
            .addSupport(
              SupportBody(
                email: emailController.text,
                message: messageController.text,
                fullName: fullNameController.text,
                mobilePhone: countryDialCode + mobileController.text,
                subject: subjectController.text,
              ),
            )
            .then((value) {
              if (value.code == 201) {
                loading.value = false;
                emailController.clear();
                messageController.clear();
                fullNameController.clear();
                mobileController.clear();
                subjectController.clear();
                TopSnackBar.success(
                  context,
                  'The message was sent successfully',
                );
              } else {
                loading.value = false;
                TopSnackBar.warning(
                  context,
                  context.localizations.something_wrong,
                );
              }
            });
      } else {
        loading.value = false;
        TopSnackBar.warning(context, context.localizations.empty_field);
      }
    }
  }

  Future<void> updateSupport(BuildContext context,int id) async {
    Constant.closeKeyBoard();
    if (!loading.value) {
      if (emailController.text.isNotEmpty &&
          messageController.text.isNotEmpty &&
          fullNameController.text.isNotEmpty &&
          mobileController.text.isNotEmpty &&
          subjectController.text.isNotEmpty) {
        loading.value = true;
        await supportRepo.updateSupport(
          SupportBody(
            id: id,
            email: emailController.text,
            message: messageController.text,
            fullName: fullNameController.text,
            mobilePhone: mobileController.text,
            subject: subjectController.text,
          ),
        ).then((value) async {
          if (value.code == 200) {
            await supportTicketsController!.getSupportTickets();
            loading.value = false;
            getx.Get.back();
            TopSnackBar.success(context, value.message);
          } else {
            loading.value = false;
            TopSnackBar.warning(
              context,
              context.localizations.something_wrong,
            );
          }
        });
      } else {
        loading.value = false;
        TopSnackBar.warning(context, context.localizations.empty_field);
      }
    }
  }

  fillSupportFields() {
    mobileController.text = (chosenToEdit as SupportResponse).mobilePhone!;
    subjectController.text = (chosenToEdit as SupportResponse).subject!;
    messageController.text = (chosenToEdit as SupportResponse).message!;
  }

  @override
  void onInit() {
    if (getx.Get.isRegistered<SupportTicketsController>()) {
      supportTicketsController = getx.Get.find<SupportTicketsController>();
    }

    if (initController.userData != null) {
      changeStatus.value = false;
      emailController.text = initController.userData!.userEmail ?? "";
      fullNameController.text = initController.userData!.userName ?? "";
      mobileController.text = initController.userData!.mobile ?? "";
      countryDialCode = initController.userData!.mobileCode ?? "ae";
    }

    if (getx.Get.arguments != null) {
      editStatus = getx.Get.arguments[0];

      if (editStatus == true) {
        print('@@@@@@@@@@@');
        chosenToEdit = getx.Get.arguments[1];
        fillSupportFields();
        print('@@@@@@@@@@@');
      }
    }
    super.onInit();
  }
}
