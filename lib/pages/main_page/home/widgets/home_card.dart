import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/custom_picture/custom_svg_image.dart';

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
        margin: EdgeInsets.symmetric(vertical: 15.h),
        width: 1.sw * 0.8,
        height: 1.sh * 0.17,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(25.r),
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
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: CustomSvgImage(
                width: 1.sw * 0.12,
                height: 1.sw * 0.12,
                image: imagePath,
                color: secondaryColor,
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Text(title, style: AppTheme.displayLarge.copyWith(fontSize: 22.sp)),
            ),
          ],
        ),
      ),
    );
  }
}
