import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';

class CustomDropDown<T> extends StatelessWidget {

  final double width;
  final double height;
  final String text;
  final T? value;
  final String? title;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final bool? required;
  final Color? dropdownColor;

  const CustomDropDown({
    super.key,
    required this.width,
    required this.height,
    required this.text,
    required this.value,
    this.title,
    required this.items,
    required this.onChanged,
    this.required,
    this.dropdownColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title == null ? const SizedBox()
        : Text.rich(
          TextSpan(
            text: title!,
            style: AppTheme.labelLarge.copyWith(fontSize: 15.sp,fontWeight: FontWeight.w500),
            children: [
              if (required == true)
                TextSpan(
                  text: ' *',
                  style: AppTheme.labelLarge.copyWith(fontSize: 15.sp,fontWeight: FontWeight.w500,color: red),
                ),
            ],
          ),
        ),
        SizedBox(height: title == null ? 0 : 6.h),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: dropdownColor ?? white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: grey, width: 0.5),
          ),
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: DropdownButton<T>(
              dropdownColor: white,
              isExpanded: true,
              hint: Text(text, style: AppTheme.bodyMedium.copyWith(color: Colors.grey)),
              icon: Icon(Icons.keyboard_arrow_down_outlined, size: 22.sp),
              iconEnabledColor: grey,
              value: value,
              items: items,
              underline: const SizedBox(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
