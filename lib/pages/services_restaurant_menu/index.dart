import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/data/constant/api_constant.dart';
import 'package:reviews_link_v2/pages/services_restaurant_menu/controller.dart';
import 'package:reviews_link_v2/pages/services_restaurant_menu/widgets/circle_color.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/res/styles.dart';
import 'package:reviews_link_v2/widgets/custom_png_pic/custom_png_network.dart';
import 'package:reviews_link_v2/widgets/header/internal_header.dart';

class ServicesRestaurantMenuPage extends StatelessWidget {
  ServicesRestaurantMenuPage({super.key});
  final ServicesRestaurantMenuController servicesRestaurantMenuController =
      Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: InternalHeader(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              servicesRestaurantMenuController.data.header.showLogo == 1
                  ? CustomPngNetwork(
                      width: Get.width,
                      height: Get.height * 0.25,
                      image:
                          servicesRestaurantMenuController.data.header.logo !=
                                  null &&
                              servicesRestaurantMenuController
                                  .data
                                  .header
                                  .logo!
                                  .isNotEmpty
                          ? baseUrl +
                                '/admin/' +
                                servicesRestaurantMenuController
                                    .data
                                    .header
                                    .logo!
                          : null,
                    )
                  : SizedBox(),
              SizedBox(
                height:
                    servicesRestaurantMenuController.data.header.showLogo == 0
                    ? 0
                    : 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ColorCircle(
                    color: servicesRestaurantMenuController.hexToColor(
                      servicesRestaurantMenuController.data.theme.colors.bg,
                    ),
                    label: 'Background',
                  ),
                  ColorCircle(
                    color: servicesRestaurantMenuController.hexToColor(
                      servicesRestaurantMenuController.data.theme.colors.panel,
                    ),
                    label: 'Panel',
                  ),
                  ColorCircle(
                    color: servicesRestaurantMenuController.hexToColor(
                      servicesRestaurantMenuController.data.theme.colors.text,
                    ),
                    label: 'Text',
                  ),
                  ColorCircle(
                    color: servicesRestaurantMenuController.hexToColor(
                      servicesRestaurantMenuController.data.theme.colors.muted,
                    ),
                    label: 'Muted',
                  ),
                  ColorCircle(
                    color: servicesRestaurantMenuController.hexToColor(
                      servicesRestaurantMenuController.data.theme.colors.accent,
                    ),
                    label: 'Accent',
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      servicesRestaurantMenuController.data.pageTitle,
                      style: textStyleForLargeBlackBoldText,
                    ),
                    Text(
                      servicesRestaurantMenuController.data.description,
                      style: textStyleForMediumTextGraySemiBoldText,
                    ),
                    SizedBox(height: 15),
                    servicesRestaurantMenuController.data.products.isEmpty
                        ? Center()
                        : Text("Products: ", style: textStyleForSubTitle),
                    SizedBox(
                      height:
                          servicesRestaurantMenuController.data.products.isEmpty
                          ? 0
                          : 10,
                    ),
                    SizedBox(
                      height: Get.height * 0.28,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: servicesRestaurantMenuController
                            .data
                            .products
                            .length,
                        itemBuilder: (context, index) {
                          final product = servicesRestaurantMenuController
                              .data
                              .products[index];
                          return Card(
                            margin: EdgeInsets.only(right: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: CustomPngNetwork(
                                    width: Get.width * 0.4,
                                    height: Get.height * 0.12,
                                    image:
                                        servicesRestaurantMenuController
                                                    .data
                                                    .products[index]
                                                    .image !=
                                                null &&
                                            servicesRestaurantMenuController
                                                .data
                                                .products[index]
                                                .image!
                                                .isNotEmpty
                                        ? baseUrl +
                                              '/admin/' +
                                              servicesRestaurantMenuController
                                                  .data
                                                  .products[index]
                                                  .image!
                                        : null,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  width: Get.width * 0.35,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: textStyleForLargeBlackBoldText,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        product.description,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            textStyleForSmallGraySemiBoldText,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        product.price + ' \$',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            textStyleForMediumTextGraySemiBoldText
                                                .copyWith(
                                                  color: secondaryColor,
                                                ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height:
                          servicesRestaurantMenuController.data.banner.show == 0
                          ? 0
                          : 15,
                    ),
                    servicesRestaurantMenuController.data.banner.show == 0
                        ? Center()
                        : Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Banner: ", style: textStyleForSubTitle),
                                  SizedBox(height: 10),
                                  servicesRestaurantMenuController
                                              .data
                                              .banner
                                              .show ==
                                          1
                                      ? CustomPngNetwork(
                                          width: Get.width,
                                          height: Get.height * 0.25,
                                          image:
                                              servicesRestaurantMenuController
                                                          .data
                                                          .banner
                                                          .image !=
                                                      null &&
                                                  servicesRestaurantMenuController
                                                      .data
                                                      .banner
                                                      .image!
                                                      .isNotEmpty
                                              ? baseUrl +
                                                    '/admin/' +
                                                    servicesRestaurantMenuController
                                                        .data
                                                        .banner
                                                        .image!
                                              : null,
                                        )
                                      : const SizedBox(),
                                  SizedBox(height: 20),
                                  Text(
                                    servicesRestaurantMenuController
                                        .data
                                        .banner
                                        .alt,
                                    style: textStyleForSmallBlackRegularText,
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
