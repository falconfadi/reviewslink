import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/custom_picture/custom_svg_image.dart';

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
    final isTablet = Constant.isTablet(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        width: 0.2.sw,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSvgImage(
              width: isTablet ? 25.w : 30.w,
              height: isTablet ? 25.w : 30.w,
              image: image,
              color: select ? primaryColor : secondaryColor,
            ),
            Text(
              title,
              style: AppTheme.labelSmall.copyWith(
                color: select ? primaryColor : secondaryColor
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 350),
              width: select ? 0.15.sw : 0,
              height: 3,
              decoration: BoxDecoration(
                color: select ? primaryColor : secondaryColor,
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
