import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/pages/create_account/controller.dart';
import 'package:reviews_link_v2/res/app_images.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/res/styles.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';
import 'package:reviews_link_v2/widgets/custom_png_pic/custom_png_image.dart';
import 'package:reviews_link_v2/widgets/footer/auth_footer.dart';
import 'package:reviews_link_v2/widgets/text_field/custom_text_field.dart';

class CreateAccountPage extends StatelessWidget {
  CreateAccountPage({super.key});

  final CreateAccountController createAccountController = Get.find();
  final InitController initController = Get.find();

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
                    "Create account".toUpperCase(),
                    style: textStyleForSmallGraySemiBoldText,
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Get started with ReviewsLink",
                    style: textStyleForTitle,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    width: 0.9,
                    height: 0.07,
                    controller: createAccountController.fullNameController,
                    title: "Full name",
                    required: true,
                    textColor: black,
                    titleStyle: textStyleForTextField,
                    fillColor: Colors.white,
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    width: 0.9,
                    height: 0.07,
                    controller: createAccountController.emailController,
                    title: "Email address",
                    required: true,
                    textColor: black,
                    titleStyle: textStyleForTextField,
                    fillColor: Colors.white,
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: Get.height * 0.07,
                          child: CountryCodePicker(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            searchDecoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (CountryCode countryCode) {
                              createAccountController.countryDialCode.value =
                                  countryCode.dialCode!;
                            },
                            initialSelection: "ae",
                            showDropDownButton: true,
                            padding: EdgeInsets.zero,
                            hideMainText: true,
                            showFlagMain: true,
                            flagWidth: 25,
                            dialogBackgroundColor: Theme.of(context).cardColor,
                            textStyle: textStyleForTextField,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 3,
                        child: CustomTextField(
                          width: 0.9,
                          height: 0.07,
                          controller:
                              createAccountController.phoneNumberController,
                          title: "Phone number",
                          required: true,
                          textColor: black,
                          titleStyle: textStyleForTextField,
                          fillColor: Colors.white,
                          textInputType: TextInputType.phone,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    width: 0.9,
                    height: 0.07,
                    controller: createAccountController.companyNameController,
                    title: "Company name",
                    textColor: black,
                    titleStyle: textStyleForTextField,
                    fillColor: Colors.white,
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    width: 0.9,
                    height: 0.07,
                    controller: createAccountController.passwordController,
                    title: "Password",
                    required: true,
                    textColor: black,
                    titleStyle: textStyleForTextField,
                    maxLines: 1,
                    minLines: 1,
                    obscureText: createAccountController.showPassword.value,
                    fillColor: Colors.white,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        createAccountController.showPassword.value =
                            !createAccountController.showPassword.value;
                      },
                      child: createAccountController.showPassword.value
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
                  ),
                  SizedBox(height: 40),
                  CustomButton(
                    width: Get.width,
                    height: 0.075,
                    color: secondaryColor,
                    title: "Create account",
                    icon: Icon(
                      Icons.arrow_forward_outlined,
                      size: 20,
                      color: Colors.white,
                    ),
                    onTap: () async {
                      await createAccountController.signUpRequest(context);
                      // Get.to(() => VerificationCodePage(email: createAccountController.emailController.text));
                    },
                    borderRadiusBottomLeft: 50,
                    borderRadiusBottomRight: 50,
                    borderRadiusTopLeft: 50,
                    borderRadiusTopRight: 50,
                    loadingColor: white,
                    loading: createAccountController.loading.value,
                    textStyle: textStyleForPrimaryButton,
                  ),
                  SizedBox(height: 25),
                  AuthFooterWidget(
                    text: "Already have an account?",
                    link: "Sign in",
                    linkTap: () {
                      Get.offNamed('/login');
                      // Get.off(LogInPage());
                    },
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
