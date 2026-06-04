import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:reviews_link_v2/pages/create_support_tickets/controller.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/res/styles.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';
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
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  CustomTextField(
                    width: 0.9,
                    height: 0.07,
                    controller: createSupportTicketsController.fullNameController,
                    title: "Full name",
                    textColor: black,
                    readOnly: createSupportTicketsController.changeStatus.value
                        ? false
                        : true,
                    titleStyle: textStyleForTextField,
                    fillColor: createSupportTicketsController.changeStatus.value
                        ? white
                        : lightGrey,
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    width: 0.9,
                    height: 0.07,
                    controller: createSupportTicketsController.emailController,
                    title: "Email address",
                    textColor: black,
                    readOnly: createSupportTicketsController.changeStatus.value
                        ? false
                        : true,
                    titleStyle: textStyleForTextField,
                    fillColor: createSupportTicketsController.changeStatus.value
                        ? white
                        : lightGrey,
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      createSupportTicketsController.editStatus == true ? Center() :
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
                              createSupportTicketsController.countryDialCode =
                                  countryCode.dialCode!;
                            },
                            initialSelection:
                                createSupportTicketsController.countryDialCode,
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
                      SizedBox(width: createSupportTicketsController.editStatus == true ? 0 : 10),
                      Expanded(
                        flex: 3,
                        child: CustomTextField(
                          width: 0.9,
                          height: 0.07,
                          controller:
                              createSupportTicketsController.mobileController,
                          title: "Phone number",
                          required: true,
                          readOnly: createSupportTicketsController.editStatus == true ? true : false,
                          textColor: black,
                          titleStyle: textStyleForTextField,
                          fillColor: createSupportTicketsController.editStatus == true ?
                          lightGrey : white,
                          textInputType: TextInputType.phone,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    width: 0.9,
                    height: 0.07,
                    controller:
                        createSupportTicketsController.subjectController,
                    title: "Subject",
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
                    controller:
                        createSupportTicketsController.messageController,
                    title: "Message",
                    required: true,
                    textColor: black,
                    titleStyle: textStyleForTextField,
                    fillColor: Colors.white,
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(height: 40),
                  CustomButton(
                    width: Get.width,
                    height: 0.075,
                    color: secondaryColor,
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
                    borderRadiusBottomLeft: 50,
                    borderRadiusBottomRight: 50,
                    borderRadiusTopLeft: 50,
                    borderRadiusTopRight: 50,
                    loadingColor: white,
                    loading: createSupportTicketsController.loading.value,
                    textStyle: textStyleForPrimaryButton,
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
