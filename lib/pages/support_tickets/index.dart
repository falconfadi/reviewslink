import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/my_codes/widget/code_card_item.dart';
import 'package:reviews_link_v2/pages/support_tickets/controller.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/res/styles.dart';
import 'package:reviews_link_v2/widgets/header/internal_header.dart';

class SupportTicketsPage extends StatelessWidget {

  SupportTicketsPage({super.key});

  final SupportTicketsController supportTicketsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: InternalHeader(title: "My Support Tickets"),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: supportTicketsController.loading.value
              ? Center(child: CircularProgressIndicator(color: primaryColor))
              : supportTicketsController.supportTicketsList.isEmpty
              ? Center(
                  child: Text(
                    "No support tickets",
                    style: textStyleForSmallBlackRegularText,
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
                    padding: EdgeInsets.only(bottom: 30,top: 20),
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
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: CodeCardItem(
                                                title: "Full Name",
                                                subTitle: codeItem.fullName ?? "",
                                              ),
                                            ),
                                            SizedBox(width: codeItem.status == 0 ? 5 : 0),
                                            codeItem.status == 0 ?
                                            InkWell(
                                              onTap: () {
                                                Get.toNamed(
                                                  '/createSupportTickets',
                                                  arguments: [true, codeItem]
                                                );
                                              },
                                              child: Icon(Icons.mode_edit_outline_outlined,size: 20,color: white)
                                            ) : Center()
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        CodeCardItem(
                                          title: "Email",
                                          subTitle: codeItem.email ?? "",
                                        ),
                                        SizedBox(height: 8),
                                        CodeCardItem(
                                          title: "Mobile",
                                          subTitle: codeItem.mobilePhone ?? "",
                                        ),
                                        SizedBox(height: 8),
                                        CodeCardItem(
                                          title: "Subject",
                                          subTitle: codeItem.subject ?? "",
                                        ),
                                        SizedBox(height: 8),
                                        CodeCardItem(
                                          title: "Message",
                                          subTitle: codeItem.message ?? "",
                                        ),
                                        SizedBox(height: 8),
                                        CodeCardItem(
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
