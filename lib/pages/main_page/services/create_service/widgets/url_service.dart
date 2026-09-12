import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/controller.dart';
import 'package:reviews_link_v2/widgets/text_field/custom_text_field.dart';

class UrlService extends StatelessWidget {

  final CreateServiceController controller;

  const UrlService({super.key, required this.controller});


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 25.h),
        CustomTextField(
          controller: controller.titleController,
          title: "Title (optional)",
          labelText: "e.g. My website url",
          textInputType: TextInputType.text,
        ),
        SizedBox(height: 25.h),
        CustomTextField(
          controller: controller.urlController,
          title: "URL",
          required: true,
          labelText: "https://google.com",
          textInputType: TextInputType.text,
        ),
      ],
    );
  }
}