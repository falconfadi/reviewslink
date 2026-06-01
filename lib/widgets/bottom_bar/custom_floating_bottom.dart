import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/main_page/controller.dart';
import 'package:reviews_link_v2/res/app_images.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/custom_svg_pic/custom_svg_image.dart';

class CustomFloatingButton extends StatelessWidget {
  CustomFloatingButton({Key? key}) : super(key: key);
  final MainPageController mainPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return FloatingActionButton(
        heroTag: "2",
        onPressed: () {
          mainPageController.moveBetweenPages(1);
        },
        // backgroundColor: mainPageController.pageIndex.value == 1 ? primaryColor : white,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          decoration: BoxDecoration(
            color: mainPageController.pageIndex.value == 1
                ? primaryColor
                : white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: CustomSvgImage(
              width: 30,
              height: 30,
              color: mainPageController.pageIndex.value != 1
                  ? secondaryColor
                  : white,
              image: HOME_ICON,
            ),
          ),
        ),
      );
    });
  }
}
