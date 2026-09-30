import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/data/models/response/init/init_response.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/controller.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/widgets/rating_form_service.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/widgets/social_media_service.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/widgets/url_service.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';
import 'package:reviews_link_v2/widgets/dropdown/custom_drop_down.dart';
import 'package:reviews_link_v2/widgets/header/internal_header.dart';

class CreateServicePage extends StatefulWidget {

  CreateServicePage({super.key});

  @override
  State<CreateServicePage> createState() => _CreateServicePageState();
}

class _CreateServicePageState extends State<CreateServicePage> {

  final CreateServiceController createServiceController = Get.find();
  InitController initController = Get.find();


  @override
  void initState() {
    super.initState();
    if(createServiceController.editStatus == false) {
      createServiceController.selectedType = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: white,
        appBar: InternalHeader(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25.h),
                Text(createServiceController.editStatus == true ?
                "Edit this service" : "Add new service",
                    style: AppTheme.displayLarge.copyWith(fontSize: 22.sp)),
                SizedBox(height: 25.h),
                CustomDropDown(
                  width: 1.sw,
                  height: 1.sh * 0.07,
                  title: "Service type",
                  required: true,
                  text: "",
                  dropdownColor: createServiceController.editStatus == true ?
                  lightGrey : white,
                  value: createServiceController.selectedType,
                  onChanged: createServiceController.editStatus == true
                      ? null
                      : (ServiceType? value) {
                          setState(() {
                            createServiceController.clearData();
                            createServiceController.selectedType = value;

                            final typeName = value?.name;
                            if (typeName == "social_media_cards_4") {
                              createServiceController.initializeSocialMediaCards(4);
                            } else if (typeName == "social_media_cards_8") {
                              createServiceController.initializeSocialMediaCards(8);
                            } else if (typeName == "social_media_cards_unlimited") {
                              createServiceController.initializeSocialMediaCards(11);
                            }
                          });
                        },
                  items: initController.servicesTypeList.map((type) {
                    return DropdownMenuItem<ServiceType>(
                      value: type,
                      child: Row(
                        children: [
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              Constant.serviceTypeName(type.name ?? ""),
                              style: AppTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 25.h),
                _buildServiceWidget(),
                SizedBox(height: 50.h),
                createServiceController.allowedTypes.contains(
                      createServiceController.selectedType?.name) ?
                CustomButton(
                  width: 1.sw,
                  height: 0.07,
                  color: createServiceController.selectedType == null
                      ? grey : secondaryColor,
                  title: createServiceController.editStatus == true
                      ? 'Update' : "Save",
                  onTap: () async {
                    if (createServiceController.editStatus == true) {
                      await createServiceController.choseUpdateOption(
                        context,
                      );
                    } else {
                      await createServiceController.choseSaveOption(
                        context,
                      );
                    }
                  },
                  borderRadius: 50.r,
                  loading: createServiceController.loading.value,
                ) : SizedBox(),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildServiceWidget() {
    final type = createServiceController.selectedType;

    if (type == null) {
      return const SizedBox();
    }

    switch (type.name) {
      case "url":
        return UrlService(controller: createServiceController);

      case "rating_form":
        return RatingFormService(controller: createServiceController);

      case "social_media_cards_4":
        return SocialMediaService(
          initialCards: 4,
          canAddMore: false,
        );

      case "social_media_cards_8":
        return SocialMediaService(
          initialCards: 8,
          canAddMore: false,
        );

      case "social_media_cards_unlimited":
        return SocialMediaService(
          initialCards: 11,
          canAddMore: true,
        );

      default:
        return Container(
          height: 1.sh * 0.2,
          child: Center(child: Text('Coming soon',
              style: AppTheme.labelLarge
          )),
        );
    }
  }
}