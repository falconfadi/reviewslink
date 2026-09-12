import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/data/models/response/service/service_response.dart';
import 'package:reviews_link_v2/pages/main_page/services/controller.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';
import 'package:reviews_link_v2/widgets/pop_up/custom_popup_menu_button.dart';
import 'package:reviews_link_v2/widgets/dialog/custom_dialog.dart';
import 'package:reviews_link_v2/widgets/rating_bar/custom_rating_bar.dart';

class ServiceCard extends StatelessWidget {

  final ServiceResponse service;

  ServiceCard({super.key, required this.service});

  final ServiceController serviceController = Get.find();

  @override
  Widget build(BuildContext context) {
    final isTablet = Constant.isTablet(context);
    return InkWell(
      onTap: () async {
        if (service.serviceType.name == 'url') {
          Constant.launchUrls(Uri.parse((service.jsonData as UrlServiceData).url));
        }
        if (service.serviceType.name == "rating_form") {
          Dialogs.show(
            context,
            content: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () => Get.back(),
                        child: Icon(Icons.close,size: isTablet ? 20.sp : null),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text((service.jsonData as RatingFormServiceData).formTitle,
                    style: AppTheme.headlineMedium,
                  ),
                  SizedBox(height: 8),
                  Text((service.jsonData as RatingFormServiceData).formDescription,
                    style: AppTheme.bodyLarge.copyWith(color: grey),
                  ),
                  SizedBox(height: 15.h),
                  CustomRatingBar(
                    rate: (service.jsonData as RatingFormServiceData).maxStars.toDouble(),
                    size: isTablet ? 30.sp : 35.sp,
                    itemPadding: 0,
                    onChanged: null
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          );
        }
        if (service.serviceType.name == "social_media_cards_4" ||
        service.serviceType.name == "social_media_cards_8" ||
        service.serviceType.name == "social_media_cards_unlimited") {
          Get.toNamed(
            '/socialMediaServices',
            arguments: service.jsonData as SocialMediaServiceData,
          );
        }
      },
      child: Card(
        color: darkBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.serviceType.name == "rating_form"
                            ? (service.jsonData as RatingFormServiceData).formTitle
                            : service.serviceType.name == "url"
                            ? (service.jsonData as UrlServiceData).url
                            : service.serviceType.name == "social_media_cards_4" ||
                            service.serviceType.name == "social_media_cards_8" ||
                            service.serviceType.name == "social_media_cards_unlimited" ?
                            (service.jsonData as SocialMediaServiceData).profile!.displayName == "" &&
                                (service.jsonData as SocialMediaServiceData).cards!.isNotEmpty ?
                            (service.jsonData as SocialMediaServiceData).cards!.first.platform! :
                            (service.jsonData as SocialMediaServiceData).profile!.displayName!
                            : "",
                        style: AppTheme.bodyLarge.copyWith(fontSize: 20.sp,color: white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        service.serviceType.name,
                        style: AppTheme.labelLarge.copyWith(fontSize: 18.sp,color: white),
                      ),
                    ],
                  ),
                ),
              ),
              CustomPopupMenuButton(
                itemBuilder: [
                  PopupMenuItem(
                    height: isTablet ? 80 : kMinInteractiveDimension,
                    value: "",
                    onTap: () {
                      Get.toNamed('/createService', arguments: [true, service]);
                    },
                    child: Center(
                      child: Text(
                        "Edit",
                        style: AppTheme.labelLarge.copyWith(color: secondaryColor,fontSize: 18.sp),
                        ),
                    ),
                  ),
                  PopupMenuItem(
                    height: isTablet ? 80 : kMinInteractiveDimension,
                    value: "",
                    onTap: () {
                      Dialogs.show(
                        context,
                        content: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Codes list",
                                    style: AppTheme.headlineMedium,
                                  ),
                                  InkWell(
                                    onTap: () => Get.back(),
                                    child: Icon(Icons.close,size: isTablet ? 20.sp : null),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: 1.sh * 0.4,
                                ),
                                child: service.codes.isEmpty
                                    ? Container(
                                  margin: EdgeInsets.symmetric(vertical: 20.h),
                                  child: Text(
                                      'This service doesn\'t have codes yet',
                                      style: AppTheme.labelMedium
                                  ),
                                )
                                    : ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: service.codes.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(vertical: 15.h),
                                      child: IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                service.codes[index].code,
                                                style: AppTheme.bodyLarge.copyWith(
                                                    fontSize: 18.sp,color: grey
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Scans: ${service.codes[index].scans}',
                                                style: AppTheme.bodyLarge.copyWith(
                                                    fontSize: 18.sp,color: grey
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        "Codes",
                        style: AppTheme.labelLarge.copyWith(color: lightBlue,fontSize: 18.sp),
                      ),
                    ),
                  ),
                  if (service.serviceType.name == "rating_form")...[
                    PopupMenuItem(
                      height: isTablet ? 80 : kMinInteractiveDimension,
                      value: "",
                      onTap: () {
                        Get.toNamed('/reviews', arguments: service);
                      },
                      child: Center(
                        child: Text(
                          "Reviews",
                          style: AppTheme.labelLarge.copyWith(fontSize: 18.sp),
                        ),
                      ),
                    ),
                  ],
                  PopupMenuItem(
                    height: isTablet ? 80 : kMinInteractiveDimension,
                    value: "",
                    onTap: () {
                      Dialogs.show(
                        context,
                        title: "Are you sure you want to delete this service?",
                        okBtn: Obx(() {
                          return CustomButton(
                            width: 1.sw,
                            height: 0.05,
                            title: "Delete",
                            loading: serviceController.loadingDelete.value,
                            color: red,
                            onTap: () async {
                              await serviceController.deleteService(
                                service.id,
                                context,
                              );
                            },
                          );
                        }),
                        cancelBtn: true,
                      );
                    },
                    child: Center(
                      child: Text(
                        "Delete",
                        style: AppTheme.labelLarge.copyWith(color: red,fontSize: 18.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
