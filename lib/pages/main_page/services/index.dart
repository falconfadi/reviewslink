import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/pages/main_page/services/controller.dart';
import 'package:reviews_link_v2/pages/main_page/services/widgets/service_card.dart';
import 'package:reviews_link_v2/pages/main_page/services/widgets/tabs_widget.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/loading/custom_loading.dart';

class ServicesPage extends StatefulWidget {

  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {

  final ServiceController serviceController = Get.find();
  final InitController initController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          SizedBox(height: 25.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: TabsWidget(
              selectedTab: serviceController.selectedTab.value,
              onTabChanged: (index) {
                if (!serviceController.loading.value) {
                  serviceController.selectedTab.value = index;
                  serviceController.selectedTabId.value =
                      initController.servicesTypeList[index].id ?? 0;
                  serviceController.selectedTabText.value =
                      initController.servicesTypeList[index].name ?? '';
                  print(initController.servicesTypeList[index].name);
                }
              },
            ),
          ),
          SizedBox(height: 25.h),
          Expanded(
            child: RefreshIndicator(
              color: primaryColor,
              onRefresh: () async {
                await serviceController.getServicesList();
              },
              child: serviceController.loading.value
                  ? LoadingIndicator()
                  : !serviceController.allowedTypes.contains(
                      serviceController.selectedTabText.value,
                    )
                  ? Center(
                      child: Text(
                        "Coming soon",
                          style: AppTheme.labelLarge
                      ),
                    )
                  : serviceController.getFilteredServices().isEmpty
                  ? Center(
                      child: Text(
                        "No services available in this category",
                          style: AppTheme.labelLarge
                      ),
                    )
                  : ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      children: [
                        ...serviceController
                            .getFilteredServices()
                            .map((service) => ServiceCard(service: service))
                            .toList(),
                        SizedBox(height: 30.h),
                      ],
                    ),
            ),
          ),
        ],
      );
    });
  }
}
