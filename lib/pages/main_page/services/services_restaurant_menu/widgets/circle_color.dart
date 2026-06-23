import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reviews_link_v2/res/app_theme.dart';

class ColorCircle extends StatelessWidget {

  final Color color;
  final String label;

  const ColorCircle({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 55.w,
          height: 55.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300),
          ),
        ),
        SizedBox(height: 6.h),
        Text(label, style: AppTheme.bodySmall),
      ],
    );
  }
}
