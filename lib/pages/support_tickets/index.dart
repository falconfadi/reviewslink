import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/support_tickets/controller.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/card_row_item/card_row_item.dart';
import 'package:reviews_link_v2/widgets/header/internal_header.dart';
import 'package:reviews_link_v2/widgets/loading/custom_loading.dart';

class SupportTicketsPage extends StatelessWidget {

  SupportTicketsPage({super.key});

  final SupportTicketsController supportTicketsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: white,
        appBar: InternalHeader(title: "My Support Tickets"),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: supportTicketsController.loading.value
              ? LoadingIndicator()
              : supportTicketsController.supportTicketsList.isEmpty
              ? Center(
                  child: Text(
                    "No support tickets",
                    style: AppTheme.labelLarge
                  ),
                )
              : RefreshIndicator(
                  color: primaryColor,
                  onRefresh: () async {
                    await supportTicketsController.getSupportTickets();
                  },
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 35.h,top: 20.h),
                    itemCount: supportTicketsController.supportTicketsList.length,
                    itemBuilder: (context, index) {
                      final codeItem = supportTicketsController.supportTicketsList[index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed(
                            '/showSupportTicketDetails',
                            arguments: codeItem,
                          );
                        },
                        child: Card(
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
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: CardRowItem(
                                                title: "Full Name",
                                                subTitle: codeItem.fullName ?? "",
                                              ),
                                            ),
                                            SizedBox(width: codeItem.status == 0 ? 10.w : 0),
                                            codeItem.status == 0 ?
                                            InkWell(
                                              onTap: () {
                                                Get.toNamed(
                                                  '/createSupportTickets',
                                                  arguments: [true, codeItem]
                                                );
                                              },
                                              child: Icon(Icons.mode_edit_outline_outlined,size: 25.sp,color: white)
                                            ) : Center()
                                          ],
                                        ),
                                        SizedBox(height: 8.h),
                                        CardRowItem(
                                          title: "Email",
                                          subTitle: codeItem.email ?? "",
                                        ),
                                        SizedBox(height: 8.h),
                                        CardRowItem(
                                          title: "Mobile",
                                          subTitle: codeItem.mobilePhone ?? "",
                                        ),
                                        SizedBox(height: 8.h),
                                        CardRowItem(
                                          title: "Subject",
                                          subTitle: codeItem.subject ?? "",
                                        ),
                                        SizedBox(height: 8.h),
                                        CardRowItem(
                                          title: "Message",
                                          subTitle: codeItem.message ?? "",
                                        ),
                                        SizedBox(height: 8.h),
                                        CardRowItem(
                                          title: "Created at",
                                          subTitle: codeItem.createdAt ?? "",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ),
      );
    });
  }
}
