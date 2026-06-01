import 'package:flutter/material.dart';
import 'package:reviews_link_v2/pages/my_codes/widget/code_card_item.dart';
import 'package:reviews_link_v2/pages/my_codes_requests/controller.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/res/styles.dart';
import 'package:reviews_link_v2/widgets/header/internal_header.dart';
import 'package:get/get.dart';

class MyCodesRequestsPage extends StatelessWidget {

  MyCodesRequestsPage({super.key});

  final MyQrRequestsController myQrRequestsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: white,
        appBar: InternalHeader(title: 'My QRs Requests'),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: myQrRequestsController.loading.value
                ? Center(child: CircularProgressIndicator(color: primaryColor))
                : myQrRequestsController.codesList.isEmpty
                ? Center(
                    child: Text(
                      "No codes requests yet",
                      style: textStyleForSmallBlackRegularText,
                    ),
                  )
                : RefreshIndicator(
                    color: primaryColor,
                    onRefresh: () async {
                      await myQrRequestsController.getMyCodesList();
                    },
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: 30,top: 20),
                      itemCount: myQrRequestsController.codesList.length,
                      itemBuilder: (context, index) {
                        final codeItem =
                            myQrRequestsController.codesList[index];
                        return Card(
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
                                        CodeCardItem(
                                          title: "#",
                                          subTitle: (index + 1).toString(),
                                        ),
                                        SizedBox(height: 8),
                                        CodeCardItem(
                                          title: "Date",
                                          subTitle: codeItem.createdAt
                                              .toString(),
                                        ),
                                        SizedBox(height: 8),
                                        CodeCardItem(
                                          title: "Quantity",
                                          subTitle: codeItem.quantity
                                              .toString(),
                                        ),
                                        SizedBox(height: 8),
                                        CodeCardItem(
                                          title: "Status",
                                          subTitle: myQrRequestsController
                                              .showStatus(codeItem.status),
                                        ),
                                        SizedBox(height: 8),
                                        CodeCardItem(
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
