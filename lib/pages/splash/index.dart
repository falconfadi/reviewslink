import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reviews_link_v2/res/app_images.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/custom_picture/custom_png_image.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Center(
          child: CustomPngImage(
            width: 1.sw * 0.7,
            height: 1.sh * 0.5,
            image: FULL_LOGO,
          ),
        ),
      ),
    );
  }
}
