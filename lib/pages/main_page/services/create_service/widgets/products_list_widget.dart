import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/controller.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/widgets/image_picker_widget.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';
import 'package:reviews_link_v2/widgets/text_field/custom_text_field.dart';

class ProductsListWidget extends StatelessWidget {

  final CreateServiceController createServiceController;

  const ProductsListWidget({super.key,
    required this.createServiceController,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: createServiceController.products.length,
          itemBuilder: (context, index) {
            final product = createServiceController.products[index];
            return Card(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Product no. ' + (index + 1).toString(),
                          style: AppTheme.labelLarge,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Container(
                              width: 30.w,
                              height: 30.w,
                              decoration: BoxDecoration(
                                color: red,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: Icon(Icons.close, color: white,size: 25.sp),
                              ),
                            ),
                            onPressed: () {
                              createServiceController.removeProduct(index);
                            },
                          ),
                        ),
                      ],
                    ),
                    CustomTextField(
                      controller: product.title,
                      title: createServiceController.selectedType!.name ==
                          'restaurant_menu' ? "Name" : "Title",
                      required: true,
                      labelText:  createServiceController.selectedType!.name ==
                          'restaurant_menu' ? 'e.g. Hamburger' : 'e.g. Wireless Mouse',
                      textInputType: TextInputType.text,
                    ),
                    SizedBox(height: 25.h),
                    CustomTextField(
                      controller: product.description,
                      title: createServiceController.selectedType!.name ==
                          'restaurant_menu' ? "Components" : "Description",
                      labelText:  createServiceController.selectedType!.name ==
                          'restaurant_menu' ? 'e.g. Meat, egg, cheese ... etc'
                          : 'e.g. High quality mouse with ergonomic design',
                      textInputType: TextInputType.text,
                    ),
                    SizedBox(height: 25.h),
                    CustomTextField(
                      controller: product.price,
                      title: "Price",
                      required: true,
                      labelText: 'e.g. 25\$',
                      textInputType: TextInputType.phone,
                    ),
                    SizedBox(height: 25.h),
                    Obx(() => ImagePickerWidget(
                      label: "Image",
                      imageFile: product.image.value,
                      imageUrl: product.imageUrl,
                      onTap: () async {
                        File? pickedImage = await createServiceController.selectImage();
                        if (pickedImage != null) {
                          product.image.value = pickedImage;
                        }
                      },
                    )),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            );
          },
        ),
        SizedBox(height: 20.h),
        Align(
          alignment: Alignment.centerLeft,
          child: CustomButton(
            width: 0.55,
            height: 0.05,
            color: green,
            title: "Add product",
            onTap: () {
              createServiceController.addProduct();
            },
          ),
        ),
      ],
    ));
  }
}
