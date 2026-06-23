import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/support_tickets/support_ticket_details/controller.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/card_row_item/card_row_item.dart';
import 'package:reviews_link_v2/widgets/header/internal_header.dart';

class SupportTicketDetailsPage extends StatelessWidget {

  SupportTicketDetailsPage({super.key});

  final SupportTicketDetailsController supportTicketDetailsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InternalHeader(),
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(supportTicketDetailsController.data.statusLabel!,
                                style: AppTheme.labelLarge.copyWith(
                                    color: secondaryColor,
                                    fontSize: 18.sp
                                )
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        CardRowItem(
                          title: "Full Name",
                          subTitle: supportTicketDetailsController.data.fullName ?? "",
                          titleColor: primaryColor,
                          subtitleColor: black,
                        ),
                        SizedBox(height: 10.h),
                        CardRowItem(
                          title: "Email",
                          subTitle: supportTicketDetailsController.data.email ?? "",
                          titleColor: primaryColor,
                          subtitleColor: black,
                        ),
                        SizedBox(height: 10.h),
                        CardRowItem(
                          title: "Mobile",
                          subTitle: supportTicketDetailsController.data.mobilePhone ?? "",
                          titleColor: primaryColor,
                          subtitleColor: black,
                        ),
                        SizedBox(height: 10.h),
                        CardRowItem(
                          title: "Subject",
                          subTitle: supportTicketDetailsController.data.subject ?? "",
                          titleColor: primaryColor,
                          subtitleColor: black,
                        ),
                        SizedBox(height: 10.h),
                        CardRowItem(
                          title: "Message",
                          subTitle: supportTicketDetailsController.data.message ?? "",
                          titleColor: primaryColor,
                          subtitleColor: black,
                        ),
                        SizedBox(height: 10.h),
                        supportTicketDetailsController.data.adminReply == null ? Center() :
                        CardRowItem(
                          title: "Admin reply",
                          subTitle: supportTicketDetailsController.data.adminReply!,
                          titleColor: primaryColor,
                          subtitleColor: black,
                        ),
                        SizedBox(height: 10.h),
                        supportTicketDetailsController.data.updatedAt == null ? Center() :
                        CardRowItem(
                          title: "Updated at",
                          subTitle: supportTicketDetailsController.data.updatedAt!,
                          titleColor: primaryColor,
                          subtitleColor: black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
