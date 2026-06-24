import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/controller.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/widgets/build_color_itm.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/widgets/image_picker_widget.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/widgets/products_list_widget.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/check_box_list_tile/custom_check_box_list_tile.dart';
import 'package:reviews_link_v2/widgets/text_field/custom_text_field.dart';

class RestaurantMenuWidget extends StatefulWidget {

  final CreateServiceController createServiceController;

  RestaurantMenuWidget({super.key, required this.createServiceController});

  @override
  State<RestaurantMenuWidget> createState() => _RestaurantMenuWidgetState();
}

class _RestaurantMenuWidgetState extends State<RestaurantMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 25.h),
        CustomTextField(
          controller: widget.createServiceController.pageTitleController,
          title: "Page title",
          required: true,
          textInputType: TextInputType.text,
        ),
        SizedBox(height: 25.h),
        CustomTextField(
          controller: widget.createServiceController.descriptionController,
          title: "Description",
          textInputType: TextInputType.text,
        ),
        SizedBox(height: 25.h),
        Card(
          color: white,
          shadowColor: grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h),
                Text("Header", style: AppTheme.displayLarge.copyWith(fontSize: 20.sp)),
                SizedBox(height: 20.h),
                ImagePickerWidget(
                  label: "Logo",
                  imageFile: widget.createServiceController.headerLogo.value,
                  imageUrl: widget.createServiceController.headerLogoUrl,
                  onTap: () async {
                    File? pickedImage = await widget.createServiceController.selectImage();
                    if (pickedImage != null) {
                      setState(() {
                        widget.createServiceController.headerLogo.value = pickedImage;
                      });
                    }
                  },
                ),
                SizedBox(height: 6.h),
                CustomCheckBoxListTile(
                  value: widget.createServiceController.logoVisible,
                  onChanged: (v) {
                   setState(() {
                     widget.createServiceController.logoVisible = v!;
                   });
                  },
                  title: "Show logo",
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 25.h),
        Container(
          width: 1.sw,
          child: Card(
            color: white,
            shadowColor: grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.h),
                  Text("Theme colors", style: AppTheme.displayLarge.copyWith(fontSize: 20.sp)),
                  SizedBox(height: 20.h),
                  Wrap(
                    spacing: 5.w,
                    runSpacing: 5.w,
                    children: [
                      buildColorItem(
                        title: "Background",
                        color: widget.createServiceController.hexToColor(
                          widget.createServiceController.theme!.colors.bg,
                        ),
                        onColorChanged: (c) {
                          setState(() {
                            widget.createServiceController.theme!.colors.bg =
                                colorToHex(c);
                          });
                        },
                        context: context,
                      ),
                      buildColorItem(
                        title: "Panel",
                        color: widget.createServiceController.hexToColor(
                          widget.createServiceController.theme!.colors.panel,
                        ),
                        onColorChanged: (c) {
                          setState(() {
                            widget.createServiceController.theme!.colors.panel =
                                colorToHex(c);
                          });
                        },
                        context: context,
                      ),
                      buildColorItem(
                        title: "Text",
                        color: widget.createServiceController.hexToColor(
                          widget.createServiceController.theme!.colors.text,
                        ),
                        onColorChanged: (c) {
                          setState(() {
                            widget.createServiceController.theme!.colors.text =
                                colorToHex(c);
                          });
                        },
                        context: context,
                      ),
                      buildColorItem(
                        title: "Muted",
                        color: widget.createServiceController.hexToColor(
                          widget.createServiceController.theme!.colors.muted,
                        ),
                        onColorChanged: (c) {
                          setState(() {
                            widget.createServiceController.theme!.colors.muted =
                                colorToHex(c);
                          });
                        },
                        context: context,
                      ),
                      buildColorItem(
                        title: "Accent",
                        color: widget.createServiceController.hexToColor(
                          widget.createServiceController.theme!.colors.accent,
                        ),
                        onColorChanged: (c) {
                          setState(() {
                            widget.createServiceController.theme!.colors.accent =
                                colorToHex(c);
                          });
                        },
                        context: context,
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 25.h),
        Card(
          color: white,
          shadowColor: grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h),
                Text("End banner", style: AppTheme.displayLarge.copyWith(fontSize: 20.sp)),
                SizedBox(height: 20.h),
                ImagePickerWidget(
                  label: "Banner image",
                  imageFile: widget.createServiceController.bannerImage.value,
                  imageUrl: widget.createServiceController.bannerImageUrl,
                  onTap: () async {
                    File? pickedImage = await widget.createServiceController.selectImage();
                    if (pickedImage != null) {
                      setState(() {
                        widget.createServiceController.bannerImage.value = pickedImage;
                      });
                    }
                  },
                ),
                CustomCheckBoxListTile(
                  value: widget.createServiceController.bannerVisible,
                  onChanged: (v) {
                   setState(() {
                     widget.createServiceController.bannerVisible = v!;
                   });
                  },
                  title: "Show banner",
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  controller: widget.createServiceController.bannerTextController,
                  title: "Banner alt text",
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 25.h),
              ],
            ),
          ),
        ),
        SizedBox(height: 25.h),
        Text("Products", style: AppTheme.labelLarge.copyWith(fontSize: 15.sp,fontWeight: FontWeight.w500)),
        SizedBox(height: 6.h),
        ProductsListWidget(createServiceController: widget.createServiceController),
      ],
    );
  }
}
