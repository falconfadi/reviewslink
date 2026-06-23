import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/main_page/controller.dart';
import 'package:reviews_link_v2/pages/scan_qr/qr_scanner.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';
import 'package:reviews_link_v2/widgets/loading/custom_loading.dart';
import 'package:reviews_link_v2/widgets/text_field/custom_text_field.dart';

class ScanPopUp extends StatelessWidget {

  ScanPopUp({super.key});

  final MainPageController mainPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 25.h),
        width: 1.sw * 0.8,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              title: 'Claim QR',
              required: true,
              controller: mainPageController.qrTextController,
              textInputType: TextInputType.text,
              labelText: 'Example:  W1EE3RFA48',
            ),
            SizedBox(height: 25.h),
            GestureDetector(
              onTap: () async {
                await mainPageController.claimCode(context);
              },
              child: Container(
                width: 1.sw * 0.7,
                padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(12.r)
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      mainPageController.loading.value ? Center(
                        child: LoadingIndicator(
                          height: 0.03.sh,
                          width: 0.03.sh,
                          color: white,
                        ),
                      ) : Expanded(
                            child: Text("Adding the code manually",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: AppTheme.headlineSmall.copyWith(color: white),
                            ),
                          ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 35.h),
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
            ),
          ],
        ),
      );
    });
  }
}
