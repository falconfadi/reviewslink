import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import '../../res/color.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final Widget? icon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType textInputType;
  final int? maxLength;
  final TextAlign? textAlign;
  final bool? obscureText;
  final Color? fillColor;
  final Color? textColor;
  final String? title;
  final bool? readOnly;
  final int? maxLines;
  final int? minLines;
  final bool? required;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    this.controller,
    this.labelText,
    this.icon,
    this.maxLength,
    this.textAlign,
    this.obscureText,
    this.suffixIcon,
    this.fillColor,
    required this.textInputType,
    this.textColor,
    this.title,
    this.readOnly,
    this.maxLines,
    this.minLines,
    this.required = false,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = Constant.isTablet(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title == null ? const SizedBox() :
        Text.rich(
          TextSpan(
            text: title ?? "",
            style: AppTheme.labelLarge.copyWith(fontSize: 15.sp,fontWeight: FontWeight.w500),
            children: [
              if (required == true)
                TextSpan(
                  text: ' *',
                    style: AppTheme.labelLarge.copyWith(fontSize: 15.sp,fontWeight: FontWeight.w500,color: red)
                ),
            ],
          ),
        ),
        SizedBox(height: title == null ? 0 : 6.h),
        Container(
          width: 1.sw,
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            cursorHeight: isTablet ? 35 : 18,
            obscureText: obscureText ?? false,
            onChanged: onChanged,
            maxLength: maxLength ?? 500,
            minLines: minLines ?? 1,
            maxLines: maxLines ?? 1,
            readOnly: readOnly ?? false,
            cursorColor: Colors.grey,
            controller: controller,
            autofocus: false,
            style: AppTheme.bodyLarge,
            decoration: InputDecoration(
              counterText: '',
              hintText: labelText,
              hintStyle: AppTheme.bodyMedium.copyWith(color: Colors.grey),
              isDense: true,
              filled: true,
              fillColor: fillColor ?? white,
              prefixIconColor: Colors.grey,
              prefixIcon: icon,
              suffixIcon: suffixIcon,
              contentPadding: isTablet ? EdgeInsets.all(10.w) : null,
              prefixIconConstraints: BoxConstraints(
                maxHeight: 50.h,
                maxWidth: 50.w,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
                borderRadius: BorderRadius.circular(12.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: lightGrey),
                borderRadius: BorderRadius.circular(12.r),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12.r),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(12.r),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: red),
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            keyboardType: textInputType,
          ),
        ),
      ],
    );
  }
}
