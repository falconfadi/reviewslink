import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/home/widgets/home_card.dart';
import 'package:reviews_link_v2/pages/home/widgets/scan_pop_up.dart';
import 'package:reviews_link_v2/pages/main_page/controller.dart';
import 'package:reviews_link_v2/res/app_images.dart';
import 'package:reviews_link_v2/widgets/pop_up/custom_pop_up.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final MainPageController mainPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            child: Column(
              children: [
                HomeCard(
                  title: 'Request QRs',
                  imagePath: REQUEST_QR_ICON,
                  onTap: () {
                    Get.toNamed('/createQrRequest');
                  },
                ),
                HomeCard(
                  title: 'Claim QR',
                  imagePath: QR_ICON,
                  onTap: () {
                    mainPageController.scanPopUpStatus.value = true;
                  },
                ),
                HomeCard(
                  title: 'Add Service',
                  imagePath: SERVICES_ICON,
                  onTap: () {
                    Get.toNamed('/createService', arguments: [false, null]);
                  },
                ),
              ],
            ),
          ),
          CustomPopUp(
            open: mainPageController.scanPopUpStatus.value,
            outSideOnTap: () {
              mainPageController.scanPopUpStatus.value = false;
            },
            child: ScanPopUp(),
          ),
        ],
      );
    });
  }
}
