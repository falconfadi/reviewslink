import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/pages/services/controller.dart';
import 'package:reviews_link_v2/pages/services/widgets/service_card.dart';
import 'package:reviews_link_v2/pages/services/widgets/tabs_widget.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/res/styles.dart';

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
          SizedBox(height: 20),
          Expanded(
            child: RefreshIndicator(
              color: primaryColor,
              onRefresh: () async {
                await serviceController.getServicesList();
              },
              child: serviceController.loading.value
                  ? Center(
                      child: CircularProgressIndicator(color: primaryColor),
                    )
                  : !serviceController.allowedTypes.contains(
                      serviceController.selectedTabText.value,
                    )
                  ? Center(
                      child: Text(
                        "Coming soon",
                        style: textStyleForSmallBlackRegularText,
                      ),
                    )
                  : serviceController.getFilteredServices().isEmpty
                  ? Center(
                      child: Text(
                        "No services available in this category",
                        style: textStyleForSmallBlackRegularText,
                      ),
                    )
                  : ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        ...serviceController
                            .getFilteredServices()
                            .map((service) => ServiceCard(service: service))
                            .toList(),

                        SizedBox(height: 30),
                      ],
                    ),
            ),
          ),
        ],
      );
    });
  }
}
