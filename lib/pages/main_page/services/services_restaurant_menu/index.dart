import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/data/constant/api_constant.dart';
import 'package:reviews_link_v2/pages/main_page/services/services_restaurant_menu/controller.dart';
import 'package:reviews_link_v2/pages/main_page/services/services_restaurant_menu/widgets/circle_color.dart';
import 'package:reviews_link_v2/pages/main_page/services/widgets/products_preview_widget.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/custom_picture/custom_png_network.dart';
import 'package:reviews_link_v2/widgets/header/internal_header.dart';

class ServicesRestaurantMenuPage extends StatelessWidget {

  ServicesRestaurantMenuPage({super.key});

  final ServicesRestaurantMenuController servicesRestaurantMenuController = Get.find();

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
              if(servicesRestaurantMenuController.data.header.showLogo == 1)...[
                CustomPngNetwork(
                  width: 1.sw,
                  height: 1.sh * 0.25,
                  image: servicesRestaurantMenuController.data.header.logo !=
                      null && servicesRestaurantMenuController.data
                      .header.logo!.isNotEmpty ? baseUrl +
                      '/admin/' + servicesRestaurantMenuController
                      .data.header.logo! : null,
                ),
                SizedBox(height: 25.h),
              ],
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
              SizedBox(height: 25.w),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      servicesRestaurantMenuController.data.pageTitle,
                      style: AppTheme.headlineMedium,
                    ),
                    if(servicesRestaurantMenuController.data.description != "")...[
                      SizedBox(height: 25.h),
                      Text(
                        servicesRestaurantMenuController.data.description,
                        style: AppTheme.bodyLarge.copyWith(color: grey),
                      )
                    ],
                    if(servicesRestaurantMenuController.data.products.isNotEmpty)...[
                      SizedBox(height: 25.h),
                      ProductsPreviewWidget(
                        productsList: servicesRestaurantMenuController.data.products,
                        getTitle: (product) => product.name,
                      )
                    ],
                    if(servicesRestaurantMenuController.data.banner.show == 1)...[
                      SizedBox(height: 25.h),
                      Card(
                        color: white,
                        shadowColor: grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(height: 15.h),
                              Text("Banner: ", style: AppTheme.displayLarge.copyWith(fontSize: 20.sp)),
                              SizedBox(height: 10.h),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: CustomPngNetwork(
                                  height: 1.sh * 0.25,
                                  width: 1.sw,
                                  image: servicesRestaurantMenuController.data.banner
                                      .image != null && servicesRestaurantMenuController
                                      .data.banner.image!.isNotEmpty
                                      ? baseUrl + '/admin/' + servicesRestaurantMenuController
                                      .data.banner.image! : null,
                                ),
                              ),
                              if(servicesRestaurantMenuController.data.banner.alt != "")...[
                                SizedBox(height: 20.h),
                                Text(
                                  servicesRestaurantMenuController.data.banner.alt,
                                  style: AppTheme.labelLarge,
                                ),
                              ],
                              SizedBox(height: 20.h),
                            ],
                          ),
                        ),
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
