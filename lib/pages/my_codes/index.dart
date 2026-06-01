import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/my_codes/controller.dart';

import 'package:reviews_link_v2/pages/my_codes/widget/code_card_item.dart';
import 'package:reviews_link_v2/pages/services/controller.dart';
import 'package:reviews_link_v2/pages/services/models/service_model.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/res/styles.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';
import 'package:reviews_link_v2/widgets/dialog/custom_dialog.dart';
import 'package:reviews_link_v2/widgets/dropdown/custom_drop_down.dart';
import 'package:reviews_link_v2/widgets/snack_bar/top_snack_bar.dart';
import 'package:reviews_link_v2/widgets/text_field/custom_text_field.dart';

class MyCodesPage extends StatefulWidget {
  const MyCodesPage({super.key});

  @override
  State<MyCodesPage> createState() => _MyCodesPageState();
}

class _MyCodesPageState extends State<MyCodesPage> {
  final MyCodesController myCodesController = Get.find();
  final ServiceController serviceController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: Get.height * 0.1,
            ),
            child: myCodesController.loading.value
                ? Center(child: CircularProgressIndicator(color: primaryColor))
                : myCodesController.codesList.isEmpty
                ? Center(
                    child: Text(
                      "No codes available yet",
                      style: textStyleForSmallBlackRegularText,
                    ),
                  )
                : RefreshIndicator(
                    color: primaryColor,
                    onRefresh: () async {
                      await myCodesController.getCodesList();
                    },
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: 30),
                      itemCount: myCodesController.filteredList.length,
                      itemBuilder: (context, index) {
                        final codeItem = myCodesController.filteredList[index];
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
                                          title: "Code",
                                          subTitle: codeItem.code,
                                        ),
                                        SizedBox(height: 8),
                                        CodeCardItem(
                                          title: "Service",
                                          subTitle:
                                              codeItem.service.name.isEmpty
                                              ? 'No service'
                                              : codeItem.service.name,
                                        ),
                                        SizedBox(height: 8),
                                        CodeCardItem(
                                          title: "Scan counter",
                                          subTitle: codeItem.scans.toString(),
                                        ),
                                        SizedBox(height: 8),
                                        CodeCardItem(
                                          title: "Claim date",
                                          subTitle: codeItem.claimDate,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                PopupMenuButton(
                                  icon: Icon(Icons.more_vert, color: white),
                                  offset: const Offset(0, 40),
                                  onSelected: (value) {},
                                  color: white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  elevation: 5,
                                  shadowColor: lightGrey,
                                  itemBuilder: (BuildContext context) => [
                                    PopupMenuItem(
                                      value: "",
                                      height: 50,
                                      onTap: () {
                                        myCodesController.selectService = null;
                                        if (codeItem.service.name.isNotEmpty) {
                                          myCodesController
                                              .selectService = serviceController
                                              .allServices
                                              .firstWhereOrNull(
                                                (s) =>
                                                    s.id == codeItem.service.id,
                                              );
                                        }
                                        if (!serviceController.loading.value) {
                                          if (serviceController
                                              .allServices
                                              .isEmpty) {
                                            TopSnackBar.warning(
                                              context,
                                              'No services currently available',
                                            );
                                          } else {
                                            Dialogs.show(
                                              context,
                                              okBtn: Obx(() {
                                                return CustomButton(
                                                  width: Get.width,
                                                  height: 0.05,
                                                  title: "Assign",
                                                  loading: myCodesController
                                                      .loadingAssign
                                                      .value,
                                                  textStyle:
                                                      textStyleForMediumWhiteRegularText,
                                                  color: secondaryColor,
                                                  onTap: () async {
                                                    if (myCodesController
                                                            .selectService !=
                                                        null) {
                                                      await myCodesController
                                                          .assignCode(
                                                            codeItem.id,
                                                            myCodesController
                                                                .selectService!
                                                                .id,
                                                            context,
                                                          );
                                                    } else {
                                                      TopSnackBar.warning(
                                                        context,
                                                        'Please chose service',
                                                      );
                                                    }
                                                  },
                                                );
                                              }),
                                              cancelBtn: true,
                                              content: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                    ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Assign service",
                                                          style:
                                                              textStyleForLargeBlackBoldText,
                                                        ),
                                                        InkWell(
                                                          onTap: () =>
                                                              Get.back(),
                                                          child: Icon(
                                                            Icons.close,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 20),
                                                    StatefulBuilder(
                                                      builder: (context, setStateDialog) {
                                                        return CustomDropDown(
                                                          width: Get.width,
                                                          height:
                                                              Get.height * 0.06,
                                                          title: "My services",
                                                          text: "",
                                                          value:
                                                              myCodesController
                                                                  .selectService,
                                                          onChanged: (value) {
                                                            print(
                                                              value!.id
                                                                  .toString(),
                                                            );

                                                            setStateDialog(() {
                                                              myCodesController
                                                                      .selectService =
                                                                  value;
                                                            });
                                                          },
                                                          items: serviceController
                                                              .allServices
                                                              .map((service) {
                                                                return DropdownMenuItem<
                                                                  ServiceModel
                                                                >(
                                                                  value:
                                                                      service,
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width:
                                                                            8,
                                                                      ),
                                                                      Expanded(
                                                                        child: Text(
                                                                          service
                                                                              .name,
                                                                          style:
                                                                              textStyleForSmallBlackRegularText,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              })
                                                              .toList(),
                                                        );
                                                      },
                                                    ),
                                                    SizedBox(height: 20),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      child: Center(
                                        child: Text(
                                          "Assign service",
                                          style:
                                              textStyleForMediumWhiteRegularText
                                                  .copyWith(color: black),
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: "",
                                      onTap: () async {
                                        myCodesController.printCodePdf(
                                          codeItem.code,
                                        );
                                      },
                                      child: Center(
                                        child: Text(
                                          "Print",
                                          style:
                                              textStyleForMediumWhiteRegularText
                                                  .copyWith(color: black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: Get.height * 0.18,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: 10),
                  // Text("My QRs", style: textStyleForTitle),
                  SizedBox(height: 10),

                  CustomTextField(
                    width: 0.9,
                    height: 0.07,
                    controller: myCodesController.searchController,
                    labelText: "Type to search",
                    textColor: black,
                    titleStyle: textStyleForTextField,
                    fillColor: Colors.white,
                    textInputType: TextInputType.text,
                    suffixIcon: InkWell(
                      onTap: () {
                        if (myCodesController
                            .searchController
                            .text
                            .isNotEmpty) {
                          myCodesController.searchController.clear();
                        }
                      },
                      child: Icon(
                        myCodesController.searchController.text.isEmpty
                            ? Icons.search
                            : Icons.close,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          myCodesController.loadingAssign.value
              ? Container(
                  width: Get.width,
                  height: Get.height,
                  color: primaryColor.withAlpha(100),
                  child: Center(child: CircularProgressIndicator(color: white)),
                )
              : const SizedBox(),
        ],
      );
    });
  }
}
