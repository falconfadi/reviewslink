import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reviews_link_v2/data/constant/api_constant.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';

class ImagePickerWidget extends StatelessWidget {

  final String label;
  final VoidCallback onTap;
  final double? width;
  final File? imageFile;
  final String? imageUrl;

  const ImagePickerWidget({
    super.key,
    required this.label,
    required this.onTap,
    this.width,
    required this.imageFile,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasLocalImage = imageFile != null && imageFile!.path.isNotEmpty;
    final bool hasNetworkImage = imageUrl != null && imageUrl!.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          style: AppTheme.labelLarge.copyWith(fontSize: 15.sp, fontWeight: FontWeight.w500),
          TextSpan(
            text: label,
            children: [
              TextSpan(
                text: ' *',
                style: AppTheme.labelLarge.copyWith(color: red, fontSize: 15.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        SizedBox(height: 6.h),
        InkWell(
          onTap: onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              height: 1.sw * 0.25,
              width: width ?? 1.sw,
              decoration: BoxDecoration(
                color: lightGrey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: lightGrey),
              ),
              child: hasLocalImage
                  ? Image.file(imageFile!, fit: BoxFit.cover)
                  : hasNetworkImage
                  ? Image.network('$baseUrl/admin/$imageUrl', fit: BoxFit.cover)
                  : Icon(Icons.add_a_photo, size: 30.sp),
            ),
          ),
        ),
      ],
    );
  }
}
