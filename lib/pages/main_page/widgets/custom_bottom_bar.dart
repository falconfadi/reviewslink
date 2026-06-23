import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/extensions/context_localization.dart';
import 'package:reviews_link_v2/pages/main_page/controller.dart';
import 'package:reviews_link_v2/res/app_images.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/pages/main_page/widgets/bottom_bar_icon.dart';

class CustomBottomBar extends StatelessWidget {

  CustomBottomBar({super.key});

  final MainPageController mainPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    final isTablet = Constant.isTablet(context);
    return Obx(() {
      return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        shadowColor: black,
        height: isTablet ? 90.h : null,
        notchMargin: 8,
        color: white,
        elevation: 10,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.fastOutSlowIn,
          height: 0.08.sh,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BottomBarIcon(
                onTap: () {
                  mainPageController.moveBetweenPages(0);
                },
                image: QR_ICON,
                select: mainPageController.pageIndex.value == 0 ? true : false,
                title: context.localizations.my_qrs,
              ),
              SizedBox(width: 0.2.sw),
              BottomBarIcon(
                onTap: () {
                  mainPageController.moveBetweenPages(2);
                },
                image: SERVICES_ICON,
                select: mainPageController.pageIndex.value == 2 ? true : false,
                title: context.localizations.my_services,
              ),
            ],
          ),
        ),
      );
    });
  }
}
