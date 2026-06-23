import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';

class CardRowItem extends StatelessWidget {

  final String title;
  final String subTitle;
  final Color? titleColor;
  final Color? subtitleColor;

  CardRowItem({super.key,
    required this.title,
    required this.subTitle,
    this.titleColor,
    this.subtitleColor
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$title:", style: AppTheme.labelLarge.copyWith(fontSize: 18.sp,color: titleColor ?? white)),
        SizedBox(width: 5.w),
        Expanded(
          child: Text(subTitle, style: AppTheme.labelLarge.copyWith(color: subtitleColor ??  white)),
        ),
      ],
    );
  }
}
