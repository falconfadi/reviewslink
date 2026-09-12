import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/controller.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/widgets/image_picker_widget.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/text_field/custom_text_field.dart';

class SocialMediaProfileWidget extends StatelessWidget {

  final CreateServiceController controller;

  const SocialMediaProfileWidget({super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Card(
        color: white,
        shadowColor: grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Text("Profile",
                style: AppTheme.displayLarge.copyWith(fontSize: 22.sp),
              ),
              SizedBox(height: 25.h),
              CustomTextField(
                controller: controller.displayNameController,
                title: "Display name",
                required: true,
                labelText: "EX. ReviewsLink",
                textInputType: TextInputType.text,
              ),
              SizedBox(height: 25.h),
              CustomTextField(
                controller: controller.bioController,
                title: "Bio",
                required: true,
                labelText: "Short profile bio",
                textInputType: TextInputType.text,
                maxLines: 3,
                minLines: 3,
              ),
              SizedBox(height: 25.h),
              ImagePickerWidget(
                label: "Avatar",
                width: 0.25.sw,
                imageFile: controller.avatar.value,
                imageUrl: controller.avatarUrl,
                onTap: () async {
                  File? pickedImage = await controller.selectImage();
                  if (pickedImage != null) {
                    controller.avatar.value = pickedImage;
                  }
                },
              ),
              SizedBox(height: 25.h),
              ImagePickerWidget(
                label: "Background",
                width: 0.25.sw,
                imageFile: controller.background.value,
                imageUrl: controller.backgroundUrl,
                onTap: () async {
                  File? pickedImage = await controller.selectImage();
                  if (pickedImage != null) {
                    controller.background.value = pickedImage;
                  }
                },
              ),
              SizedBox(height: 10),
            ],
          ),
        )
    ));
  }
}