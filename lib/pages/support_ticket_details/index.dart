import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/support_ticket_details/controller.dart';
import 'package:reviews_link_v2/pages/support_ticket_details/widget/support_ticket_item.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/res/styles.dart';
import 'package:reviews_link_v2/widgets/header/internal_header.dart';

class SupportTicketDetailsPage extends StatelessWidget {

  SupportTicketDetailsPage({super.key});

  final SupportTicketDetailsController supportTicketDetailsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InternalHeader(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(supportTicketDetailsController.data.statusLabel!, style: textStyleForMediumBlackRegularText.copyWith(
                                    color: secondaryColor
                                )),
                              ],
                            ),
                            SizedBox(height: 8),
                            SupportTicketItem(
                              title: "Full Name",
                              subTitle: supportTicketDetailsController.data.fullName ?? "",
                            ),
                            SizedBox(height: 8),
                            SupportTicketItem(
                              title: "Email",
                              subTitle: supportTicketDetailsController.data.email ?? "",
                            ),
                            SizedBox(height: 8),
                            SupportTicketItem(
                              title: "Mobile",
                              subTitle: supportTicketDetailsController.data.mobilePhone ?? "",
                            ),
                            SizedBox(height: 8),
                            SupportTicketItem(
                              title: "Subject",
                              subTitle: supportTicketDetailsController.data.subject ?? "",
                            ),
                            SizedBox(height: 8),
                            SupportTicketItem(
                              title: "Message",
                              subTitle: supportTicketDetailsController.data.message ?? "",
                            ),
                            SizedBox(height: 8),
                            supportTicketDetailsController.data.adminReply == null ? Center() :
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: SupportTicketItem(
                                title: "Admin reply",
                                subTitle: supportTicketDetailsController.data.adminReply!,
                              ),
                            ),
                            SizedBox(height: 8),
                            supportTicketDetailsController.data.updatedAt == null ? Center() :
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: SupportTicketItem(
                                title: "Updated at",
                                subTitle: supportTicketDetailsController.data.updatedAt!,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
