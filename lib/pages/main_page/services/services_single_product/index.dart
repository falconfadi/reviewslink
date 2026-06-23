import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/data/constant/api_constant.dart';
import 'package:reviews_link_v2/pages/main_page/services/services_single_product/controller.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/custom_picture/custom_png_network.dart';
import 'package:reviews_link_v2/widgets/header/internal_header.dart';

class ServicesSingleProductPage extends StatelessWidget {

  ServicesSingleProductPage({super.key});

  final ServicesSingleProductController servicesSingleProductController = Get.find();
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
              SizedBox(height: 25.w),
              CustomPngNetwork(
                width: 1.sw,
                height: 1.sh * 0.25,
                image: servicesSingleProductController.data
                    .supermarket.first.image != null &&
                    servicesSingleProductController
                        .data.supermarket.first.image!.isNotEmpty
                    ? baseUrl + '/admin/' + servicesSingleProductController
                    .data.supermarket.first.image! : null,
              ),
              SizedBox(height: 25.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      servicesSingleProductController.data.supermarket.first.name,
                      style: AppTheme.headlineMedium,
                    ),
                    if(servicesSingleProductController.data.supermarket.first.description != "")...[
                      SizedBox(height: 25.h),
                      Text(
                        servicesSingleProductController.data.supermarket.first.description,
                        style: AppTheme.bodyLarge.copyWith(color: grey),
                      ),
                    ],
                    if(servicesSingleProductController.data.supermarket.first.productId != "")...[
                      SizedBox(height: 25.h),
                      Text(
                        "ID: ${servicesSingleProductController.data.supermarket.first.productId}",
                        style: AppTheme.bodyLarge.copyWith(color: grey),
                      ),
                    ],
                    SizedBox(height: 25.h),
                    Text(servicesSingleProductController.data.supermarket.first.price +
                          ' ${initController.currencyList.firstWhere((c) => int.parse(c.id!) == servicesSingleProductController.data.currencyId).symbol}',
                      style: AppTheme.headlineLarge.copyWith(color: green),
                    ),
                    if(servicesSingleProductController.data.multiCurrency == true)...[
                      Text(initController.formatPriceWithConversion(
                        price: double.parse(servicesSingleProductController
                            .data.supermarket.first.price,
                        ),
                        productCurrencyId: servicesSingleProductController
                            .data.currencyId,
                      ),
                        style: AppTheme.headlineLarge.copyWith(color: green),
                      )
                    ]
                  ],
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
