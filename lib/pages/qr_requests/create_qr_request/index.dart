import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/qr_requests/create_qr_request/controller.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';
import 'package:reviews_link_v2/widgets/country_code_picker/custom_country_code_picker.dart';
import 'package:reviews_link_v2/widgets/header/internal_header.dart';
import 'package:reviews_link_v2/widgets/text_field/custom_text_field.dart';

class CreateQRRequestPage extends StatefulWidget {

  CreateQRRequestPage({super.key});

  @override
  State<CreateQRRequestPage> createState() => _CreateQRRequestPageState();
}

class _CreateQRRequestPageState extends State<CreateQRRequestPage> {

  CreateQRRequestController createQRRequestController = Get.find();

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
                Text("QR Request Details",
                  style: AppTheme.displayLarge.copyWith(fontSize: 22.sp),
                ),
                SizedBox(height: 25.h),
                CustomTextField(
                  controller: createQRRequestController.fullNameController,
                  title: "Full name",
                  required: true,
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 25.h),
                CustomTextField(
                  controller: createQRRequestController.emailController,
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
                            createQRRequestController.countryDialCode.value =
                            countryCode.dialCode!;
                          },
                          initialSelection: createQRRequestController.countryDialCode.value,
                        ),
                      ],
                    ),
                    Expanded(
                      flex: 4,
                      child: CustomTextField(
                        controller: createQRRequestController.phoneNumberController,
                        title: "Phone number",
                        required: true,
                        textInputType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25.h),
                CustomTextField(
                  controller: createQRRequestController.companyController,
                  title: "Company name",
                  textInputType: TextInputType.number,
                ),
                SizedBox(height: 25.h),
                CustomTextField(
                  controller: createQRRequestController.numberOfQRsController,
                  title: "Quantity",
                  required: true,
                  textInputType: TextInputType.number,
                ),
                SizedBox(height: 25.h),
                CustomTextField(
                  controller: createQRRequestController.notesController,
                  title: "Notes",
                  labelText: 'Anything we should know? (optional)',
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 50.h),
                CustomButton(
                  width: 1.sw,
                  height: 0.07,
                  title: "Send request",
                  onTap: () async {
                    await createQRRequestController.createQrRequest(context);
                  },
                  borderRadius: 50.r,
                  loading: createQRRequestController.loading.value,
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
