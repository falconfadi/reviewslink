import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/loading/custom_loading.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final VoidCallback onTap;
  final Color? color;
  final Widget? icon;
  final double? borderRadius;
  final Border? border;
  final TextStyle? textStyle;
  final bool? loading;
  final double? padding;

  const CustomButton({
    required this.width,
    required this.height,
    required this.title,
    required this.onTap,
    this.color,
    this.icon,
    this.borderRadius,
    this.border,
    this.textStyle,
    this.loading,
    this.padding,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 1.sw * width,
        height: 1.sh * height,
        padding: EdgeInsets.symmetric(horizontal: padding ?? 25.w),
        decoration: BoxDecoration(
          color: color ?? secondaryColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          border: border,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              loading ?? false ? LoadingIndicator(
                  width: 0.03.sh, height: 0.03.sh,
                color: white,
              ) : Text(
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: textStyle ?? AppTheme.headlineSmall.copyWith(
                        color: white
                      ),
                    ),
              icon == null
                  ? const SizedBox(width: 0)
                  : SizedBox(width: 10.w),
              icon ?? const Text(''),
            ],
          ),
        ),
      ),
    );
  }
}
