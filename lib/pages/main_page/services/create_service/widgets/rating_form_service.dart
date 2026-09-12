import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/controller.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/check_box_list_tile/custom_check_box_list_tile.dart';
import 'package:reviews_link_v2/widgets/text_field/custom_text_field.dart';

class RatingFormService extends StatelessWidget {

  final CreateServiceController controller;

  const RatingFormService({super.key, required this.controller});


  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 25.h),
        CustomTextField(
          controller: controller.formRatingTitleController,
          title: "Form Title",
          required: true,
          textInputType: TextInputType.text,
        ),
        SizedBox(height: 25.h),
        CustomTextField(
          controller: controller.formRatingDescriptionController,
          title: "Description (optional)",
          textInputType: TextInputType.text,
        ),
        SizedBox(height: 15.h),
        CustomCheckBoxListTile(
            value: controller.allowComments.value,
            onChanged: (v) {
              controller.allowComments.value = v!;
            },
            title: "Require visitors to write a comment"
        ),
        SizedBox(height: 10.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Max Stars',
              style: AppTheme.labelLarge.copyWith(fontSize: 15.sp,fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 6.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(8, (index) {
                  final int starValue = index + 3;
                  final bool isSelected = controller.maxStars == starValue;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      checkmarkColor: white,
                      selected: isSelected,
                      selectedColor: darkBlue,
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              '$starValue',
                              style: AppTheme.bodyLarge.copyWith(color: isSelected ? white : grey)
                          ),
                          SizedBox(width: 6.w),
                          Icon(
                            Icons.star,
                            size: 18.sp,
                            color: isSelected ? secondaryColor : grey,
                          ),
                        ],
                      ),
                      onSelected: (bool selected) {
                        if (selected) {
                          controller.maxStars.value = starValue;
                        }
                      },
                    ),
                  );
                }),
              ),
            ),
          ],
        )
      ],
    ));
  }
}