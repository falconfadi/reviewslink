import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/pages/auth/verification_code/controller.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';
import 'package:reviews_link_v2/widgets/footer/custom_footer.dart';
import 'package:reviews_link_v2/widgets/header/internal_header.dart';
import 'package:reviews_link_v2/widgets/loading/custom_loading.dart';

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

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: white,
        appBar: InternalHeader(automaticallyImplyLeading: false),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25.h),
                Text(
                  "Email verification".toUpperCase(),
                  style: AppTheme.bodyLarge.copyWith(color: grey),
                ),
                SizedBox(height: 20.h),
                Text("Enter the 6-digit code", style: AppTheme.displayLarge.copyWith(fontSize: 22.sp)),
                SizedBox(height: 15.h),
                RichText(
                  text: TextSpan(
                    text: "We’ve sent a verification code to ",
                    style: AppTheme.labelMedium.copyWith(color: grey),
                    children: [
                      TextSpan(
                        text: verificationCodeController.email,
                        style: AppTheme.labelLarge,
                      ),
                      TextSpan(
                        text: ". Enter the code below to activate your account.",
                        style: AppTheme.labelMedium.copyWith(color: grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.h),
                Text(
                  "Verification code",
                  style: AppTheme.labelLarge,
                ),
                SizedBox(height: 15.h),
                Pinput(
                  length: 6,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  controller: verificationCodeController.codeController,
                  defaultPinTheme: Constant.defaultPinTheme,
                  focusedPinTheme: Constant.focusedPinTheme,
                  submittedPinTheme: Constant.submittedPinTheme,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  keyboardType: TextInputType.phone,
                  showCursor: true,
                ),
                SizedBox(height: 50.h),
                CustomButton(
                  width: 1.sw,
                  height: 0.07,
                  title: "Verify & continue",
                  icon: Icon(
                    Icons.arrow_forward_outlined,
                    size: 22.sp,
                    color: white,
                  ),
                  onTap: () async {
                    await verificationCodeController.verifyCodeRequest(context);
                  },
                  borderRadius: 50.r,
                  loading: verificationCodeController.loading.value,
                ),
                SizedBox(height: 30.h),
                CustomFooterWidget(
                  text: "Didn’t get the email?",
                  link: "Resend code",
                  linkTap: () async {
                    await verificationCodeController.resendCodeOTP(context);
                  },
                ),
                SizedBox(height: 20.h),
                if (verificationCodeController.loadingOtp.value)
                  LoadingIndicator(
                    width: 0.03.sh, height: 0.03.sh,
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
