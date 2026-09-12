import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/data/constant/api_constant.dart';
import 'package:reviews_link_v2/pages/main_page/services/social_media_services/controller.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/custom_picture/custom_png_network.dart';
import 'package:reviews_link_v2/widgets/header/internal_header.dart';

class SocialMediaServicesPage extends StatelessWidget {

  SocialMediaServicesPage({super.key});

  final SocialMediaServicesController socialMediaServicesController = Get.find();
  final InitController initController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: InternalHeader(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25.w),
              Stack(
                alignment: Alignment.center,
                children: [
                  CustomPngNetwork(
                    width: double.infinity,
                    height: 0.3.sh,
                    image: socialMediaServicesController.data
                        .profile!.background != "" ?
                    '$baseUrl/admin/${socialMediaServicesController
                        .data.profile!.background}' : null,
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    child: Center(
                      child: Container(
                        width: 100.w,
                        height: 100.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: grey),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  socialMediaServicesController.data
                                      .profile!.avatar != "" ?
                                  '$baseUrl/admin/${socialMediaServicesController
                                      .data.profile!.avatar}' : "",
                                ))
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(socialMediaServicesController.data.profile!.displayName != "")...[
                      SizedBox(height: 25.h),
                      Text(
                        socialMediaServicesController.data.profile!.displayName!,
                        style: AppTheme.headlineSmall,
                      ),
                    ],
                    if(socialMediaServicesController.data.profile!.bio != "")...[
                      SizedBox(height: 10.h),
                      Text(
                        socialMediaServicesController.data.profile!.bio!,
                        style: AppTheme.bodyLarge,
                      ),
                    ],
                    if(socialMediaServicesController.data.cards!.isNotEmpty)...[
                      SizedBox(height: 30.h),
                      ListView.builder(
                        itemCount: socialMediaServicesController.data.cards!.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index) {
                          return InkWell(
                            onTap: () {
                              Constant.launchUrls(Uri.parse(socialMediaServicesController.data.cards![index].url!));
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  CustomPngNetwork(
                                    width: 60,
                                    height: 60,
                                    image: '$baseUrl/${socialMediaServicesController.data.cards![index].icon}',
                                  ),
                                  SizedBox(width: 10),
                                  Text(socialMediaServicesController.data.cards![index].url!,
                                    style: AppTheme.bodyLarge.copyWith(
                                      color: grey
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ],
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
