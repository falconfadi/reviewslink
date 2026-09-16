import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reviews_link_v2/data/constant/api_constant.dart';
import 'package:reviews_link_v2/pages/profile/controller.dart';
import 'package:reviews_link_v2/pages/profile/widget/pick_image_sheet.dart';
import 'package:reviews_link_v2/res/app_images.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';
import 'package:reviews_link_v2/widgets/country_code_picker/custom_country_code_picker.dart';
import 'package:reviews_link_v2/widgets/dialog/custom_dialog.dart';
import 'package:reviews_link_v2/widgets/header/internal_header.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/widgets/sheet/custom_sheet.dart';
import 'package:reviews_link_v2/widgets/text_field/custom_text_field.dart';

class ProfilePage extends StatelessWidget {

  ProfilePage({super.key});

  final ProfileController profileController = Get.find();

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
                Text("Profile",
                    style: AppTheme.displayLarge.copyWith(fontSize: 22.sp)
                ),
                SizedBox(height: 25.h),
                Center(
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Dialogs.show(
                            context,
                            content: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () => Get.back(),
                                      child: Icon(Icons.close,size: 25.sp),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  width: 1.sw,
                                  height: 1.sw,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: profileController.pickedImage.value != null
                                          ? FileImage(
                                        profileController.pickedImage.value!,
                                      )
                                          : profileController.imageUrl.value.isNotEmpty
                                          ? NetworkImage(
                                        baseUrl +
                                            '/images/users/' +
                                            profileController.imageUrl.value,
                                      )
                                          : AssetImage(USER_ICON) as ImageProvider,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.h),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          width: 110.w,
                          height: 110.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: lightGrey),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: profileController.pickedImage.value != null
                                  ? FileImage(
                                      profileController.pickedImage.value!,
                                    )
                                  : profileController.imageUrl.value.isNotEmpty
                                  ? NetworkImage(
                                      baseUrl +
                                          '/images/users/' +
                                          profileController.imageUrl.value,
                                    )
                                  : AssetImage(USER_ICON) as ImageProvider,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            CustomSheet.show(
                              isDismissible: true,
                              header: Text("Select Image", style: AppTheme.bodyLarge),
                              action: InkWell(
                                  onTap: () {
                                    profileController.removeUserImage();
                                  },
                                  child: SvgPicture.asset(DELETE_ICON,width: 25.w,color: secondaryColor)),
                              padding: 30.w,
                              context: context,
                              child: PickImageSheet(),
                            );
                          },
                          child: Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primaryColor.withOpacity(1),
                            ),
                            child: Center(
                              child: Icon(Icons.edit, color: white,size: 25.sp),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                CustomTextField(
                  controller: profileController.fullNameController,
                  title: "Full name",
                  required: true,
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 25.h),
                CustomTextField(
                  controller: profileController.emailController,
                  title: "Email address",
                  fillColor: lightGrey,
                  textInputType: TextInputType.text,
                  readOnly: true,
                ),
                SizedBox(height: 25.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(""),
                        SizedBox(height: 6.h),
                        CustomCountryCodePicker(
                          onChanged: (CountryCode countryCode) {
                            profileController.countryDialCode.value =
                            countryCode.dialCode!;
                          },
                          initialSelection: profileController.countryDialCode.value,
                        ),
                      ],
                    ),
                    Expanded(
                      flex: 4,
                      child: CustomTextField(
                        controller: profileController.phoneNumberController,
                        title: "Phone number",
                        required: true,
                        textInputType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25.h),
                CustomTextField(
                  controller: profileController.companyNameController,
                  title: "Company name",
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 50.h),
                CustomButton(
                  width: 1.sw,
                  height: 0.07,
                  title: "Save changes",
                  onTap: () async {
                    await profileController.updateProfile(context);
                  },
                  borderRadius: 50.r,
                  loading: profileController.loading.value,
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      );
    });
  }
}
