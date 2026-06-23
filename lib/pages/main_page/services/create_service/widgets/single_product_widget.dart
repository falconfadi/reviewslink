import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/data/models/response/init/init_response.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/controller.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/widgets/image_picker_widget.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/check_box_list_tile/custom_check_box_list_tile.dart';
import 'package:reviews_link_v2/widgets/dropdown/custom_drop_down.dart';
import 'package:reviews_link_v2/widgets/text_field/custom_text_field.dart';

class SingleProductWidget extends StatelessWidget {

  final CreateServiceController createServiceController;
  final InitController initController;

  SingleProductWidget({super.key,
    required this.createServiceController,
    required this.initController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 25.h),
        Obx(() => CustomDropDown(
                width: 1.sw,
                height: 1.sh * 0.07,
                title: "Currency",
                text: "Select currency",
                required: true,
                value: createServiceController.selectedCurrency.value,
                onChanged: (value) {
                  print(value);
                  createServiceController.selectedCurrency.value = value;
                },
                items: initController.currencyList.map((currency) {
                  return DropdownMenuItem<Currencies>(
                    value: currency,
                    child: Row(
                      children: [
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(currency.name ?? "",
                            style: AppTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
        ),
        Obx(() => CustomCheckBoxListTile(
          value: createServiceController.multiCurrency.value,
          onChanged: (v) {
            createServiceController.multiCurrency.value = v!;
          },
          title: "Show in multi-currency",
        )),
        SizedBox(height: 10.h),
        Text("Product", style: AppTheme.labelLarge.copyWith(fontSize: 15.sp,fontWeight: FontWeight.w500)),
        SizedBox(height: 6.h),
        Card(
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
                SizedBox(height: 15.h),
                CustomTextField(
                  controller: createServiceController.singleProduct.title,
                  title: "Name",
                  required: true,
                  labelText: 'e.g. Wireless Mouse',
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 25.h),
                CustomTextField(
                  controller: createServiceController.singleProduct.description,
                  title: "Description",
                  labelText: 'e.g. High quality mouse with ergonomic design',
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 25.h),
                CustomTextField(
                  controller: createServiceController.singleProduct.productId,
                  title: "Product ID",
                  labelText: 'e.g. WM-1023',
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 25.h),
                CustomTextField(
                  controller: createServiceController.singleProduct.price,
                  title: "Price",
                  required: true,
                  labelText: 'e.g. 25\$',
                  textInputType: TextInputType.phone,
                ),
                SizedBox(height: 25.h),
                Obx(() => ImagePickerWidget(
                  label: "Image",
                  imageFile: createServiceController.singleProduct.image.value,
                  imageUrl: createServiceController.singleProduct.imageUrl,
                  onTap: () async {
                    File? pickedImage = await createServiceController.selectImage();
                    if (pickedImage != null) {
                      createServiceController.singleProduct.image.value = pickedImage;
                    }
                  },
                )),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
