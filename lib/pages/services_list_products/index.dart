import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/data/constant/api_constant.dart';
import 'package:reviews_link_v2/pages/services_list_products/controller.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/res/styles.dart';
import 'package:reviews_link_v2/widgets/custom_png_pic/custom_png_network.dart';
import 'package:reviews_link_v2/widgets/header/internal_header.dart';

class ServicesListProductsPage extends StatelessWidget {
  ServicesListProductsPage({super.key});
  final ServicesListProductsController servicesListProductsController =
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
              CustomPngNetwork(
                width: Get.width,
                height: Get.height * 0.25,
                image:
                    servicesListProductsController.data.logo != null &&
                        servicesListProductsController.data.logo!.isNotEmpty
                    ? baseUrl +
                          '/admin/' +
                          servicesListProductsController.data.logo!
                    : null,
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      servicesListProductsController.data.pageTitle,
                      style: textStyleForLargeBlackBoldText,
                    ),
                    SizedBox(height: 20),
                    servicesListProductsController.data.products.isEmpty
                        ? Center()
                        : Text("Products: ", style: textStyleForSubTitle),
                    SizedBox(
                      height:
                          servicesListProductsController.data.products.isEmpty
                          ? 0
                          : 10,
                    ),
                    SizedBox(
                      height: Get.height * 0.28,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount:
                            servicesListProductsController.data.products.length,
                        itemBuilder: (context, index) {
                          final product = servicesListProductsController
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
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: CustomPngNetwork(
                                      width: Get.width * 0.4,
                                      height: Get.height * 0.12,
                                      image:
                                          servicesListProductsController
                                                      .data
                                                      .products[index]
                                                      .image !=
                                                  null &&
                                              servicesListProductsController
                                                  .data
                                                  .products[index]
                                                  .image!
                                                  .isNotEmpty
                                          ? baseUrl +
                                                '/admin/' +
                                                servicesListProductsController
                                                    .data
                                                    .products[index]
                                                    .image!
                                          : null,
                                    ),
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
                                        product.title,
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
                                            textStyleForMediumTextGraySemiBoldText,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        product.price,
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
