import 'package:flutter/material.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/res/styles.dart';
import 'package:reviews_link_v2/widgets/custom_svg_pic/custom_svg_image.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final GestureTapCallback onTap;

  const HomeCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        width: Get.width * 0.8,
        height: Get.height * 0.17,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: CustomSvgImage(
                width: Get.width * 0.12,
                height: Get.width * 0.12,
                image: imagePath,
                color: secondaryColor,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(title, style: textStyleForTitle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
