import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/main_page/controller.dart';
import 'package:reviews_link_v2/pages/scan_qr/qr_scanner.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/res/styles.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';
import 'package:reviews_link_v2/widgets/text_field/custom_text_field.dart';

class ScanPopUp extends StatelessWidget {
  ScanPopUp({super.key});
  final MainPageController mainPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: Get.width * 0.8,
        height: Get.height * 0.4,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              width: 0.7,
              height: 0.06,
              title: 'Claim QR',
              required: true,
              controller: mainPageController.qrTextController,
              textInputType: TextInputType.text,
              labelText: 'Example:  W1EE3RFA48',
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () async {
                await mainPageController.claimCode(context);
              },
              child: Container(
                width: Get.width * 0.7,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      mainPageController.loading.value ? Center(
                        child: SizedBox(
                          height: Get.height * 0.03,
                          width: Get.height * 0.03,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ) : Expanded(
                            child: Text("Adding the code manually",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: textStyleForPrimaryButton,
                            ),
                          ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            CustomButton(
              width: 0.4,
              height: 0.06,
              color: secondaryColor,
              title: 'Scan QR',
              onTap: () {
                mainPageController.scanPopUpStatus.value = false;
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const QRViewPage()),
                );
              },
              textStyle: textStyleForPrimaryButton,
            ),
          ],
        ),
      );
    });
  }
}
