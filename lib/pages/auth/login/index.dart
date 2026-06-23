import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/pages/auth/login/controller.dart';
import 'package:reviews_link_v2/res/app_images.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';
import 'package:reviews_link_v2/widgets/custom_picture/custom_png_image.dart';
import 'package:reviews_link_v2/widgets/footer/custom_footer.dart';
import 'package:reviews_link_v2/widgets/text_field/custom_text_field.dart';

class LogInPage extends StatelessWidget {

  LogInPage({super.key});

  final LoginController logInController = Get.find();
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
                  Text("Sign In".toUpperCase(),
                    style: AppTheme.bodyLarge.copyWith(color: grey),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Welcome back",
                        style: AppTheme.displayLarge.copyWith(fontSize: 22.sp),
                      ),
                      Text(
                        "ReviewsLink MCMS",
                        style: AppTheme.labelMedium.copyWith(color: grey),
                      ),
                    ],
                  ),
                  Text(
                    "Log in to manage your QR codes, digital menus, product lists and more.",
                    style: AppTheme.labelMedium.copyWith(color: grey),
                  ),
                  SizedBox(height: 25.h),
                  CustomTextField(
                    controller: logInController.emailController,
                    title: "Email address",
                    required: true,
                    labelText: "you@business.com",
                    textInputType: TextInputType.text,
                    icon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Icon(Icons.person,size: isTablet ? 20.sp : null),
                    ),
                  ),
                  SizedBox(height: 25.h),
                  CustomTextField(
                    controller: logInController.passwordController,
                    title: "Password",
                    required: true,
                    labelText: "Enter your password",
                    textInputType: TextInputType.visiblePassword,
                    maxLines: 1,
                    minLines: 1,
                    obscureText: logInController.showPassword.value,
                    suffixIcon: Padding(
                      padding: isTablet
                          ? EdgeInsets.symmetric(horizontal: 10.w)
                          : EdgeInsets.zero,
                      child: GestureDetector(
                        onTap: () {
                          logInController.showPassword.value = !logInController.showPassword.value;
                        },
                        child: logInController.showPassword.value ? Icon(
                            Icons.visibility_off,
                            color: primaryColor.withOpacity(0.7),
                            size: isTablet ? 20.sp : null)
                            : Icon(Icons.visibility,
                            color: primaryColor.withOpacity(0.7),
                            size: isTablet ? 20.sp : null),
                      ),
                    ),
                    icon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Icon(Icons.password,size: isTablet ? 20.sp : null),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(
                            '/forgetPassword',
                            arguments: logInController.emailController.text,
                          );
                        },
                        child: Text(
                          "Forgot password?",
                          style: AppTheme.bodyLarge.copyWith(
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 45.h),
                  CustomButton(
                    width: 1.sw,
                    height: 0.07,
                    title: "Sign in",
                    icon: Icon(
                      Icons.arrow_forward_outlined,
                      size: 22.sp,
                      color: white,
                    ),
                    onTap: () {
                      logInController.loginRequest(context);
                    },
                    borderRadius: 50.r,
                    loading: logInController.loading.value,
                  ),
                  SizedBox(height: 30.h),
                  CustomFooterWidget(
                    text: "Don't have an account?",
                    link: "Create account",
                    linkTap: () {
                      Get.offNamed('/createAccount');
                    },
                  ),
                  SizedBox(height: 15.h),
                  CustomFooterWidget(
                    text: "2026 © ReviewsLink MCMS by",
                    link: "Your(1)Site",
                    linkTap: () {
                      Constant.launchUrls(Uri.parse("https://your1site.com/"));
                    },
                  ),
                  SizedBox(height: 15.h),
                  CustomFooterWidget(
                    text: 'Need help? ',
                    link: 'Contact support',
                    linkTap: () {
                      Get.toNamed('/createSupportTickets');
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
