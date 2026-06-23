import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/data/constant/api_constant.dart';
import 'package:reviews_link_v2/pages/main_page/services/services_list_products/controller.dart';
import 'package:reviews_link_v2/pages/main_page/services/widgets/products_preview_widget.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/custom_picture/custom_png_network.dart';
import 'package:reviews_link_v2/widgets/header/internal_header.dart';

class ServicesListProductsPage extends StatelessWidget {

  ServicesListProductsPage({super.key});

  final ServicesListProductsController servicesListProductsController = Get.find();

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
                image: servicesListProductsController.data.logo != null &&
                    servicesListProductsController.data.logo!.isNotEmpty
                    ? baseUrl + '/admin/' + servicesListProductsController.data.logo!
                    : null,
              ),
              SizedBox(height: 25.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      servicesListProductsController.data.pageTitle,
                      style: AppTheme.headlineMedium,
                    ),
                    if(servicesListProductsController.data.products.isNotEmpty)...[
                      SizedBox(height: 25.h),
                      ProductsPreviewWidget(
                        productsList: servicesListProductsController.data.products,
                        getTitle: (product) => product.title,
                      )
                    ],
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
