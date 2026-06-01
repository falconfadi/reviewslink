import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/data/constant/api_constant.dart';
import 'package:reviews_link_v2/pages/services_single_product/controller.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/res/styles.dart';
import 'package:reviews_link_v2/widgets/custom_png_pic/custom_png_network.dart';
import 'package:reviews_link_v2/widgets/header/internal_header.dart';

class ServicesSingleProductPage extends StatelessWidget {
  ServicesSingleProductPage({super.key});
  final ServicesSingleProductController servicesSingleProductController =
      Get.find();
  final InitController initController = Get.find();

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
                    servicesSingleProductController
                                .data
                                .supermarket
                                .first
                                .image !=
                            null &&
                        servicesSingleProductController
                            .data
                            .supermarket
                            .first
                            .image!
                            .isNotEmpty
                    ? baseUrl +
                          '/admin/' +
                          servicesSingleProductController
                              .data
                              .supermarket
                              .first
                              .image!
                    : null,
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      servicesSingleProductController
                          .data
                          .supermarket
                          .first
                          .name,
                      style: textStyleForLargeBlackBoldText,
                    ),
                    SizedBox(height: 15),
                    Text(
                      servicesSingleProductController
                          .data
                          .supermarket
                          .first
                          .description,
                      style: textStyleForMediumTextGraySemiBoldText,
                    ),
                    SizedBox(height: 15),
                    Text(
                      "ID: ${servicesSingleProductController.data.supermarket.first.productId}",
                      style: textStyleForMediumTextGraySemiBoldText,
                    ),
                    SizedBox(height: 15),
                    Text(
                      servicesSingleProductController
                              .data
                              .supermarket
                              .first
                              .price +
                          ' ${initController.currencyList.firstWhere((c) => int.parse(c.id!) == servicesSingleProductController.data.currencyId).symbol}',
                      style: textStyleForLargeBlackBoldText.copyWith(
                        color: green,
                      ),
                    ),
                    servicesSingleProductController.data.multiCurrency == true
                        ? Text(
                            initController.formatPriceWithConversion(
                              price: double.parse(
                                servicesSingleProductController
                                    .data
                                    .supermarket
                                    .first
                                    .price,
                              ),
                              productCurrencyId: servicesSingleProductController
                                  .data
                                  .currencyId,
                            ),
                            style: textStyleForLargeBlackBoldText.copyWith(
                              color: green,
                            ),
                          )
                        : const SizedBox(), // servicesSingleProductController.data.multiCurrency == true
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
