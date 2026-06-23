import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reviews_link_v2/pages/support_tickets/create_support_tickets/controller.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';
import 'package:reviews_link_v2/widgets/country_code_picker/custom_country_code_picker.dart';
import 'package:reviews_link_v2/widgets/header/internal_header.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/widgets/text_field/custom_text_field.dart';

class CreateSupportTicketsPage extends StatelessWidget {

  CreateSupportTicketsPage({super.key});

  final CreateSupportTicketsController createSupportTicketsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: white,
        appBar: InternalHeader(title: 'Support'),
        body: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height:  25.h),
                  CustomTextField(
                    controller: createSupportTicketsController.fullNameController,
                    title: "Full name",
                    readOnly: createSupportTicketsController.changeStatus.value
                        ? false
                        : true,
                    fillColor: createSupportTicketsController.changeStatus.value
                        ? white
                        : lightGrey,
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(height:  25.h),
                  CustomTextField(
                    controller: createSupportTicketsController.emailController,
                    title: "Email address",
                    readOnly: createSupportTicketsController.changeStatus.value
                        ? false
                        : true,
                    fillColor: createSupportTicketsController.changeStatus.value
                        ? white
                        : lightGrey,
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(height:  25.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      createSupportTicketsController.editStatus == true ? Center() :
                      Column(
                        children: [
                          Text(""),
                          SizedBox(height: 6.h),
                          CustomCountryCodePicker(
                            onChanged: (CountryCode countryCode) {
                              createSupportTicketsController.countryDialCode.value =
                              countryCode.dialCode!;
                            },
                            initialSelection: createSupportTicketsController.countryDialCode.value,

                          ),
                        ],
                      ),
                      Expanded(
                        flex: 4,
                        child: CustomTextField(
                          controller: createSupportTicketsController.mobileController,
                          title: "Phone number",
                          required: true,
                          readOnly: createSupportTicketsController.editStatus == true ? true : false,
                          fillColor: createSupportTicketsController.editStatus == true ?
                          lightGrey : white,
                          textInputType: TextInputType.phone,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),
                  CustomTextField(
                    controller: createSupportTicketsController.subjectController,
                    title: "Subject",
                    required: true,
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(height: 25.h),
                  CustomTextField(
                    controller: createSupportTicketsController.messageController,
                    title: "Message",
                    required: true,
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(height: 50.h),
                  CustomButton(
                    width: 1.sw,
                    height: 0.07,
                    title: createSupportTicketsController.editStatus == true ?
                    "Update request" : "Send request",
                    onTap: () async {
                      if(createSupportTicketsController.editStatus == true) {
                        await createSupportTicketsController.updateSupport(context,
                            createSupportTicketsController.chosenToEdit!.id!
                        );
                      } else {
                        await createSupportTicketsController.createSupport(context);
                      }
                    },
                    borderRadius: 50.r,
                    loading: createSupportTicketsController.loading.value,
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
