import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final String title;
  final VoidCallback onTap;
  final Widget? icon;
  final bool? loading;
  final double? borderRadiusBottomLeft;
  final double? borderRadiusTopRight;
  final double? borderRadiusBottomRight;
  final double? borderRadiusTopLeft;
  final TextStyle textStyle;
  final Border? border;
  final Color? loadingColor;
  final double? padding;

  const CustomButton({
    required this.width,
    required this.height,
    required this.color,
    required this.title,
    required this.onTap,
    this.loading,
    this.border,
    this.borderRadiusBottomLeft,
    this.borderRadiusTopRight,
    this.borderRadiusBottomRight,
    this.borderRadiusTopLeft,
    this.icon,
    required this.textStyle,
    this.loadingColor,
    this.padding,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width * width,
        height: Get.height * height,
        padding: EdgeInsets.symmetric(horizontal: padding ?? 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(borderRadiusBottomLeft ?? 10),
            topRight: Radius.circular(borderRadiusTopRight ?? 10),
            bottomRight: Radius.circular(borderRadiusBottomRight ?? 10),
            topLeft: Radius.circular(borderRadiusTopLeft ?? 10),
          ),
          border: border,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisAlignment:
            //     icon == null
            //         ? MainAxisAlignment.center
            //         : MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              loading ?? false
                  ? Center(
                      child: SizedBox(
                        height: Get.height * 0.03,
                        width: Get.height * 0.03,
                        child: CircularProgressIndicator(
                          color: loadingColor ?? Colors.white,
                        ),
                      ),
                    )
                  : Text(
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: textStyle,
                    ),
              icon == null
                  ? const SizedBox(width: 0)
                  : const SizedBox(width: 10),
              icon ?? const Text(''),
            ],
          ),
        ),
      ),
    );
  }
}
