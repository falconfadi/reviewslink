import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/pages/auth/create_account/controller.dart';
import 'package:reviews_link_v2/res/app_images.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';
import 'package:reviews_link_v2/widgets/country_code_picker/custom_country_code_picker.dart';
import 'package:reviews_link_v2/widgets/custom_picture/custom_png_image.dart';
import 'package:reviews_link_v2/widgets/footer/custom_footer.dart';
import 'package:reviews_link_v2/widgets/text_field/custom_text_field.dart';

class CreateAccountPage extends StatelessWidget {

  CreateAccountPage({super.key});

  final CreateAccountController createAccountController = Get.find();
  final InitController initController = Get.find();

  @override
  Widget build(BuildContext context) {
    final isTablet = Constant.isTablet(context);
    return Obx(() {
      return WillPopScope(
        onWillPop: () async {
          return await initController.backButton(context);
        },
        child: Scaffold(
          backgroundColor: white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 25.h),
                  CustomPngImage(
                    width: 1.sw * 0.5,
                    height: 1.sw * 0.2,
                    image: FULL_LOGO,
                  ),
                  Text(
                    "Create account".toUpperCase(),
                    style: AppTheme.bodyLarge.copyWith(color: grey),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Get started with ReviewsLink",
                    style: AppTheme.displayLarge.copyWith(fontSize: 22.sp),
                  ),
                  SizedBox(height: 25.h),
                  CustomTextField(
                    controller: createAccountController.fullNameController,
                    title: "Full name",
                    required: true,
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(height: 25.h),
                  CustomTextField(
                    controller: createAccountController.emailController,
                    title: "Email address",
                    required: true,
                    textInputType: TextInputType.text,
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
                              createAccountController.countryDialCode.value =
                              countryCode.dialCode!;
                            },
                            initialSelection: createAccountController.countryDialCode.value,
                          ),
                        ],
                      ),
                      Expanded(
                        flex: 4,
                        child: CustomTextField(
                          controller: createAccountController.phoneNumberController,
                          title: "Phone number",
                          required: true,
                          textInputType: TextInputType.phone,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),
                  CustomTextField(
                    controller: createAccountController.companyNameController,
                    title: "Company name",
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(height: 25.h),
                  CustomTextField(
                    controller: createAccountController.passwordController,
                    title: "Password",
                    required: true,
                    maxLines: 1,
                    minLines: 1,
                    obscureText: createAccountController.showPassword.value,
                    suffixIcon: Padding(
                      padding: isTablet
                          ? EdgeInsets.symmetric(horizontal: 10.w)
                          : EdgeInsets.zero,
                      child: GestureDetector(
                        onTap: () {
                          createAccountController.showPassword.value =
                              !createAccountController.showPassword.value;
                        },
                        child: createAccountController.showPassword.value
                            ? Icon(
                                Icons.visibility_off,
                                color: primaryColor.withOpacity(0.7),
                            size: isTablet ? 20.sp : null
                              )
                            : Icon(
                                Icons.visibility,
                                color: primaryColor.withOpacity(0.7),
                            size: isTablet ? 20.sp : null
                              ),
                      ),
                    ),
                    textInputType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 50.h),
                  CustomButton(
                    width: 1.sw,
                    height: 0.07,
                    title: "Create account",
                    icon: Icon(
                      Icons.arrow_forward_outlined,
                      size: 22.sp,
                      color: white,
                    ),
                    onTap: () async {
                      await createAccountController.signUpRequest(context);
                    },
                    borderRadius: 50.r,
                    loading: createAccountController.loading.value,
                  ),
                  SizedBox(height: 30.h),
                  CustomFooterWidget(
                    text: "Already have an account?",
                    link: "Sign in",
                    linkTap: () {
                      Get.offNamed('/login');
                    },
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
