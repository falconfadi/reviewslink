import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/res/styles.dart';
import 'package:reviews_link_v2/widgets/custom_svg_pic/custom_svg_image.dart';

class BottomBarIcon extends StatelessWidget {
  final VoidCallback onTap;
  final String image;
  final bool select;
  final String title;

  const BottomBarIcon({
    required this.onTap,
    required this.image,
    required this.select,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        width: Get.width * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSvgImage(
              width: 32,
              height: 32,
              image: image,
              color: select ? primaryColor : secondaryColor,
            ),
            Text(
              title,
              style: select
                  ? textStyleForBottomBarSelect
                  : textStyleForBottomBarNotSelect,
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 350),
              width: select ? Get.width * 0.14 : 0,
              height: 3,
              decoration: BoxDecoration(
                color: select ? primaryColor : secondaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
