import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/data/models/body/codes/claim_code_body.dart';
import 'package:reviews_link_v2/data/models/response/init/init_response.dart';
import 'package:reviews_link_v2/data/repository/codes_repo.dart';
import 'package:reviews_link_v2/data/repository/init_repo.dart';
import 'package:reviews_link_v2/extensions/context_localization.dart';
import 'package:reviews_link_v2/pages/my_codes/controller.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/snack_bar/top_snack_bar.dart';

class MainPageController extends GetxController {
  final pageController = PageController(initialPage: 1);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final MyCodesController myCodesController = Get.find();
  InitController initController = Get.find();
  RxBool scanPopUpStatus = false.obs;

  RxInt pageIndex = 1.obs;
  bool backButtonStatus = false;
  DateTime timeBackPressed = DateTime.now();

  TextEditingController qrTextController = TextEditingController();
  RxBool loading = false.obs;
  CodesRepo codesRepo = CodesRepo();

  Future<void> moveBetweenPages(index) async {
    pageIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 600),
      curve: Curves.fastOutSlowIn,
    );
  }

  Future<bool> backButton(BuildContext context) async {
    scanPopUpStatus.value = false;
    if (pageIndex.value != 1) {
      moveBetweenPages(1);
      return false;
    } else {
      final difference = DateTime.now().difference(timeBackPressed);
      final isExitWarning = difference >= const Duration(seconds: 2);
      timeBackPressed = DateTime.now();
      if (isExitWarning) {
        Fluttertoast.showToast(
          msg: context.localizations.press_back_to_exit,
          fontSize: 14,
          textColor: white,
          backgroundColor: secondaryColor,
        );
        return false;
      } else {
        Fluttertoast.cancel();
        return true;
      }
    }
  }

  InitRepo initRepo = InitRepo();

  getInitData() async {
    initController.servicesTypeList.clear();
    initController.currencyList.clear();
    await initRepo.initData().then((value) {
      if (value.code == 200) {
        initController.servicesTypeList.addAll(
          (value.body['services_types'] as List)
              .map((e) => ServiceType.fromJson(e))
              .toList(),
        );
        initController.currencyList.addAll(
          (value.body['currencies'] as List)
              .map((e) => Currencies.fromJson(e))
              .toList(),
        );
      } else {
        print('wrong ------>');
      }
    });
  }

  claimCode(BuildContext context) async {
    Constant.closeKeyBoard();
    if (!loading.value) {
      if (qrTextController.text.isNotEmpty) {
        loading.value = true;
        await codesRepo
            .claimCode(ClaimCodeBody(claimCode: qrTextController.text))
            .then((value) async {
              if (value.code == 200) {
                await myCodesController.getCodesList();
                loading.value = false;
                qrTextController.clear();
                scanPopUpStatus.value = false;
                TopSnackBar.success(context, value.message);
              } else {
                loading.value = false;
                TopSnackBar.warning(context, value.message);
              }
            });
      } else {
        TopSnackBar.warning(context, 'QR field is empty');
      }
    }
  }

  claimCodeScan(BuildContext context, data) async {
    String code = data.split('/').last;
    print('i am here');
    if (!loading.value) {
      loading.value = true;
      await codesRepo.claimCode(ClaimCodeBody(claimCode: code)).then((
        value,
      ) async {
        if (value.code == 200) {
          await myCodesController.getCodesList();
          loading.value = false;
          Get.back();
          TopSnackBar.success(context, value.message);
        } else {
          loading.value = false;
          Get.back();
          TopSnackBar.warning(context, value.message);
        }
      });
    }
  }

  @override
  void onInit() async {
    await getInitData();
    super.onInit();
  }
}
