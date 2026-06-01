import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/services/controller.dart';
import 'package:reviews_link_v2/pages/services/models/service_model.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/res/styles.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';
import 'package:reviews_link_v2/widgets/dialog/custom_dialog.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;

  ServiceCard({super.key, required this.service});
  final ServiceController serviceController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (service.serviceType.name == "restaurant_menu") {
          Get.toNamed(
            '/servicesRestaurantMenu',
            arguments: service.jsonData as RestaurantMenuData,
          );
        }
        if (service.serviceType.name == "list_of_products") {
          Get.toNamed(
            '/servicesListProducts',
            arguments: service.jsonData as ListOfProductsData,
          );
        }
        if (service.serviceType.name == "product") {
          Get.toNamed(
            '/servicesSingleProduct',
            arguments: service.jsonData as SingleProductData,
          );
        }
        if (service.serviceType.name == 'url') {
          await serviceController.openUrl(
            (service.jsonData as UrlServiceData).url,
          );
        }
      },
      child: Card(
        color: primaryColor.withOpacity(0.4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.serviceType.name == "restaurant_menu"
                            ? (service.jsonData as RestaurantMenuData).pageTitle
                            : service.serviceType.name == "list_of_products"
                            ? (service.jsonData as ListOfProductsData).pageTitle
                            : service.serviceType.name == "product"
                            ? (service.jsonData as SingleProductData)
                                  .supermarket
                                  .first
                                  .name
                            : service.serviceType.name == "url"
                            ? (service.jsonData as UrlServiceData).url
                            : "",
                        style: textStyleForBigWhiteSemiBoldText,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 10),
                      Text(
                        service.serviceType.name,
                        style: textStyleForMediumWhiteRegularText,
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
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                elevation: 5,
                shadowColor: lightGrey,
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    value: "",
                    height: 50,
                    onTap: () {
                      Get.toNamed('/createService', arguments: [true, service]);
                    },
                    child: Center(
                      child: Text(
                        "Edit",
                        style: textStyleForMediumWhiteRegularText.copyWith(
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: "",
                    onTap: () {
                      Dialogs.show(
                        context,
                        content: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Codes list",
                                    style: textStyleForLargeBlackBoldText,
                                  ),
                                  InkWell(
                                    onTap: () => Get.back(),
                                    child: Icon(Icons.close),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: Get.height * 0.4,
                                ),
                                child: service.codes.isEmpty
                                    ? Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 20,
                                        ),
                                        child: Text(
                                          'This service doesn\'t have codes yet',
                                        ),
                                      )
                                    : ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemCount: service.codes.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  service.codes[index].code,
                                                  style:
                                                      textStyleForMediumTextGraySemiBoldText,
                                                ),
                                                VerticalDivider(
                                                  color: primaryColor,
                                                  thickness: 2,
                                                ),
                                                Text(
                                                  'Scans: ${service.codes[index].scans}',
                                                  style:
                                                      textStyleForMediumTextGraySemiBoldText,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        "Codes",
                        style: textStyleForMediumWhiteRegularText.copyWith(
                          color: lightBlue,
                        ),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: "",
                    height: 50,
                    onTap: () {
                      Dialogs.show(
                        context,
                        title: "Are you sure you want to delete this service?",
                        okBtn: Obx(() {
                          return CustomButton(
                            width: Get.width,
                            height: 0.05,
                            title: "Delete",
                            loading: serviceController.loadingDelete.value,
                            textStyle: textStyleForMediumWhiteRegularText,
                            color: red,
                            onTap: () async {
                              await serviceController.deleteService(
                                service.id,
                                context,
                              );
                            },
                          );
                        }),
                        cancelBtn: true,
                      );
                    },
                    child: Center(
                      child: Text(
                        "Delete",
                        style: textStyleForMediumWhiteRegularText.copyWith(
                          color: red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
