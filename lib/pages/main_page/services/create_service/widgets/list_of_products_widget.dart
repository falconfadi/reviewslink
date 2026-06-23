import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/controller.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/widgets/image_picker_widget.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/widgets/products_list_widget.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/widgets/text_field/custom_text_field.dart';

class ListOfProductsWidget extends StatelessWidget {

  final CreateServiceController createServiceController;

  ListOfProductsWidget({super.key,
    required this.createServiceController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 25.h),
        CustomTextField(
          controller: createServiceController.pageTitleController,
          title: "Page title",
          required: true,
          labelText: 'Name of company',
          textInputType: TextInputType.text,
        ),
        SizedBox(height: 25.h),
        Obx(() => ImagePickerWidget(
          label: "Logo",
          width: 1.sw * 0.25,
          imageFile: createServiceController.logo.value,
          imageUrl: createServiceController.logoUrl,
          onTap: () async {
            File? pickedImage = await createServiceController.selectImage();
            if (pickedImage != null) {
              createServiceController.logo.value = pickedImage;
            }
          },
        )),
        SizedBox(height: 25.h),
        Text("Products", style: AppTheme.labelLarge.copyWith(fontSize: 15.sp,fontWeight: FontWeight.w500)),
        SizedBox(height: 6.h),
        ProductsListWidget(createServiceController: createServiceController),
      ],
    );
  }
}
