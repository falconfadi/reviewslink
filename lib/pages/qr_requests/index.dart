import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reviews_link_v2/pages/qr_requests/controller.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/card_row_item/card_row_item.dart';
import 'package:reviews_link_v2/widgets/header/internal_header.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/widgets/loading/custom_loading.dart';

class QrRequestsPage extends StatelessWidget {

  QrRequestsPage({super.key});

  final QrRequestsController qrRequestsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: white,
        appBar: InternalHeader(title: 'My QRs Requests'),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: qrRequestsController.loading.value ?
            LoadingIndicator()
                : qrRequestsController.codesList.isEmpty ?
            Center(
              child: Text("No codes requests yet",
                  style: AppTheme.labelLarge
              ),
            ) : RefreshIndicator(
              color: primaryColor,
              onRefresh: () async {
                await qrRequestsController.getMyCodesList();
              },
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: 35.h,top: 20.h),
                itemCount: qrRequestsController.codesList.length,
                itemBuilder: (context, index) {
                  final codeItem = qrRequestsController.codesList[index];
                  return Card(
                    color: darkBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CardRowItem(
                                    title: "#",
                                    subTitle: (index + 1).toString(),
                                  ),
                                  SizedBox(height: 8.h),
                                  CardRowItem(
                                    title: "Date",
                                    subTitle: codeItem.createdAt
                                        .toString(),
                                  ),
                                  SizedBox(height: 8.h),
                                  CardRowItem(
                                    title: "Quantity",
                                    subTitle: codeItem.quantity
                                        .toString(),
                                  ),
                                  SizedBox(height: 8.h),
                                  CardRowItem(
                                    title: "Status",
                                    subTitle: qrRequestsController
                                        .showStatus(codeItem.status),
                                  ),
                                  SizedBox(height: 8.h),
                                  CardRowItem(
                                    title: "Admin note",
                                    subTitle: codeItem.adminNote ?? "-",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}
