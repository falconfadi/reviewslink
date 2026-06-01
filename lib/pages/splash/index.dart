import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/res/app_images.dart';
import 'package:reviews_link_v2/widgets/custom_png_pic/custom_png_image.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: CustomPngImage(
            width: Get.width * 0.6,
            height: Get.height * 0.4,
            image: FULL_LOGO,
          ),
        ),
      ),
    );
  }
}
