import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/pages/main_page/controller.dart';
import 'package:reviews_link_v2/res/app_images.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/custom_picture/custom_svg_image.dart';

class CustomFloatingButton extends StatelessWidget {

  CustomFloatingButton({Key? key}) : super(key: key);

  final MainPageController mainPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bool isSelected = mainPageController.pageIndex.value == 1;
      final bool isTablet = Constant.isTablet(context);

      Widget buildFabContent({double? targetSize}) {
        return FloatingActionButton(
          heroTag: "2",
          shape: const CircleBorder(),
          onPressed: () {
            mainPageController.moveBetweenPages(1);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            width: targetSize,
            height: targetSize,
            decoration: BoxDecoration(
              color: isSelected ? primaryColor : white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: CustomSvgImage(
                width: isTablet ? 30.w : 35.w,
                height: isTablet ? 30.w : 35.w,
                color: !isSelected ? secondaryColor : white,
                image: HOME_ICON,
              ),
            ),
          ),
        );
      }
      return isTablet ? SizedBox(
        width: 60.w,
        height: 60.w,
        child: buildFabContent(targetSize: 60.w),
      ) : buildFabContent();
    });
  }
}

