import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/color.dart';

class CustomTextField extends StatelessWidget {
  final double width;
  final double height;
  final String? labelText;
  final Widget? icon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final int? maxLength;
  final TextAlign? textAlign;
  final bool? obscureText;
  final Color? fillColor;
  final Color? textColor;
  final String? title;
  final TextStyle? titleStyle;
  final bool? readOnly;
  final int? maxLines;
  final int? minLines;
  final bool? required;

  const CustomTextField({
    required this.width,
    required this.height,
    this.controller,
    this.labelText,
    this.icon,
    this.validator,
    this.maxLength,
    this.textAlign,
    this.obscureText,
    this.suffixIcon,
    this.fillColor,
    required this.textInputType,
    this.textColor,
    this.title,
    this.titleStyle,
    this.readOnly,
    this.maxLines,
    this.minLines,
    this.required = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title == null ? const SizedBox() :
        Text.rich(
          TextSpan(
            text: title ?? "",
            style: titleStyle,
            children: [
              if (required == true)
                TextSpan(
                  text: ' *',
                  style: (titleStyle ?? const TextStyle())
                      .copyWith(color: red),
                ),
            ],
          ),
        ),
        SizedBox(height: title == null ? 0 : 6),
        Container(
          width: Get.width * width,
          height: Get.height * height,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            cursorHeight: 18,
            obscureText: obscureText ?? false,
            maxLength: maxLength ?? 500,
            minLines: minLines ?? 1,
            maxLines: maxLines ?? 1,
            readOnly: readOnly ?? false,
            // validator: validator,
            cursorColor: Colors.grey,
            controller: controller,
            autofocus: false,
            style: TextStyle(color: textColor ?? black, fontSize: 15),
            decoration: InputDecoration(
              // contentPadding: EdgeInsets.only(
              //   bottom: (Get.height * height) / 2,
              //   left: 10,
              //   right: 10,
              // ),
              counterText: '',
              hintText: labelText,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
              isDense: true,
              filled: true,
              fillColor: fillColor ?? Colors.transparent,
              prefixIconColor: Colors.grey,
              prefixIcon: icon,
              suffixIcon: suffixIcon,
              prefixIconConstraints: BoxConstraints(
                maxHeight: Get.height * 0.1,
                maxWidth: Get.height * 0.1,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: lightGrey),
                borderRadius: BorderRadius.circular(10),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red.withValues(alpha: 0.8),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            // textAlign: textAlign ?? TextAlign.center,
            keyboardType: textInputType,
          ),
        ),
      ],
    );
  }
}
