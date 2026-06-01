import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/pages/login/controller.dart';
import 'package:reviews_link_v2/res/app_images.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/res/styles.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';
import 'package:reviews_link_v2/widgets/custom_png_pic/custom_png_image.dart';
import 'package:reviews_link_v2/widgets/footer/auth_footer.dart';
import 'package:reviews_link_v2/widgets/footer/supoort_footer.dart';
import 'package:reviews_link_v2/widgets/text_field/custom_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

class LogInPage extends StatelessWidget {
  LogInPage({super.key});

  final LoginController logInController = Get.find();
  final InitController initController = Get.find();

  static Future<void> launchUrls(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return WillPopScope(
        onWillPop: () async {
          return await initController.backButton(context);
        },
        child: Scaffold(
          backgroundColor: white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  CustomPngImage(
                    width: Get.width * 0.5,
                    height: Get.width * 0.2,
                    image: FULL_LOGO,
                  ),
                  Text(
                    "Sign In".toUpperCase(),
                    style: textStyleForSmallGraySemiBoldText,
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Welcome back", style: textStyleForTitle),
                      Text(
                        "ReviewsLink MCMS",
                        style: textStyleForTinyGrayRegularText,
                      ),
                    ],
                  ),
                  Text(
                    "Log in to manage your QR codes, digital menus, product lists and more.",
                    style: textStyleForTinyGrayRegularText,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    width: 0.9,
                    height: 0.07,
                    controller: logInController.emailController,
                    title: "Email address",
                    labelText: "you@business.com",
                    required: true,
                    textColor: black,
                    titleStyle: textStyleForTextField,
                    fillColor: Colors.white,
                    textInputType: TextInputType.text,
                    icon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    width: 0.9,
                    height: 0.07,
                    controller: logInController.passwordController,
                    title: "Password",
                    required: true,
                    textColor: black,
                    labelText: "Enter your password",
                    titleStyle: textStyleForTextField,
                    maxLines: 1,
                    minLines: 1,
                    obscureText: logInController.showPassword.value,
                    fillColor: Colors.white,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        logInController.showPassword.value =
                            !logInController.showPassword.value;
                      },
                      child: logInController.showPassword.value
                          ? Icon(
                              Icons.visibility_off,
                              color: primaryColor.withOpacity(0.7),
                            )
                          : Icon(
                              Icons.visibility,
                              color: primaryColor.withOpacity(0.7),
                            ),
                    ),
                    textInputType: TextInputType.visiblePassword,
                    icon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(Icons.password),
                    ),
                  ),
                  SizedBox(height: 10),
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
                          style: textStyleForSmallGraySemiBoldText.copyWith(
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  CustomButton(
                    width: Get.width,
                    height: 0.065,
                    color: secondaryColor,
                    title: "Sign in",
                    icon: Icon(
                      Icons.arrow_forward_outlined,
                      size: 20,
                      color: Colors.white,
                    ),
                    onTap: () {
                      logInController.loginRequest(context);
                    },
                    borderRadiusBottomLeft: 50,
                    borderRadiusBottomRight: 50,
                    borderRadiusTopLeft: 50,
                    borderRadiusTopRight: 50,
                    loadingColor: white,
                    loading: logInController.loading.value,
                    textStyle: textStyleForPrimaryButton,
                  ),
                  SizedBox(height: 25),
                  AuthFooterWidget(
                    text: "Don't have an account?",
                    link: "Create account",
                    linkTap: () {
                      Get.offNamed('/createAccount');
                      // Get.off(CreateAccountPage());
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '2026 © ReviewsLink MCMS by ',
                        style: textStyleForTinyGrayRegularText,
                      ),
                      InkWell(
                        onTap: () {
                          launchUrls(Uri.parse("https://your1site.com/"));
                        },
                        child: Text(
                          "Your(1)Site",
                          style: textStyleForSmallGraySemiBoldText.copyWith(
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  SupportFooterWidget(
                    text: 'Need help? ',
                    link: 'Contact support',
                    linkTap: () {
                      Get.toNamed('/createSupportTickets');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
