import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:reviews_link_v2/pages/verification_code/controller.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/res/styles.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';
import 'package:reviews_link_v2/widgets/footer/auth_footer.dart';

class VerificationCodePage extends StatefulWidget {
  VerificationCodePage({super.key});

  @override
  State<VerificationCodePage> createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  final VerificationCodeController verificationCodeController = Get.find();

  @override
  void initState() {
    super.initState();
    verificationCodeController.codeController = TextEditingController();
  }

  static PinTheme defaultPinTheme = PinTheme(
    width: 50,
    height: 60,
    textStyle: textStyleForTitle,
    decoration: BoxDecoration(
      color: white,
      border: Border.all(color: lightGrey),
      borderRadius: BorderRadius.circular(10),
    ),
  );
  static PinTheme focusedPinTheme = defaultPinTheme.copyDecorationWith(
    color: white,
    border: Border.all(color: lightGrey),
    borderRadius: BorderRadius.circular(10),
  );
  static PinTheme submittedPinTheme = defaultPinTheme.copyWith(
    decoration: defaultPinTheme.decoration?.copyWith(color: white),
  );

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          shadowColor: lightGrey.withOpacity(0.1),
          surfaceTintColor: white,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  "Email verification".toUpperCase(),
                  style: textStyleForSmallGraySemiBoldText,
                ),
                SizedBox(height: 15),
                Text("Enter the 6-digit code", style: textStyleForTitle),
                SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    text: "We’ve sent a verification code to ",
                    style: textStyleForTinyGrayRegularText,
                    children: [
                      TextSpan(
                        text: verificationCodeController.email,
                        style: textStyleForSmallBlackRegularText,
                      ),
                      TextSpan(
                        text:
                            ". Enter the code below to activate your account.",
                        style: textStyleForTinyGrayRegularText,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "Verification code",
                  style: textStyleForSmallBlackRegularText,
                ),
                SizedBox(height: 10),
                Pinput(
                  length: 6,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  controller: verificationCodeController.codeController,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  keyboardType: TextInputType.phone,
                  showCursor: true,
                ),
                SizedBox(height: 40),
                CustomButton(
                  width: Get.width,
                  height: 0.075,
                  color: secondaryColor,
                  title: "Verify & continue",
                  icon: Icon(
                    Icons.arrow_forward_outlined,
                    size: 20,
                    color: Colors.white,
                  ),
                  onTap: () async {
                    await verificationCodeController.verifyCodeRequest(context);
                  },
                  borderRadiusBottomLeft: 50,
                  borderRadiusBottomRight: 50,
                  borderRadiusTopLeft: 50,
                  borderRadiusTopRight: 50,
                  loadingColor: white,
                  loading: verificationCodeController.loading.value,
                  textStyle: textStyleForPrimaryButton,
                ),
                SizedBox(height: 25),
                AuthFooterWidget(
                  text: "Didn’t get the email?",
                  link: "Resend code",
                  linkTap: () async {
                    await verificationCodeController.resendCodeOTP(context);
                  },
                ),

                SizedBox(height: 15),
                if (verificationCodeController.loadingOtp.value)
                  Center(
                    child: Container(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(color: primaryColor),
                    ),
                  ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      );
    });
  }
}
