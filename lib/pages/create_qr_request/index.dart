import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/create_qr_request/controller.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/res/styles.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';
import 'package:reviews_link_v2/widgets/header/internal_header.dart';
import 'package:reviews_link_v2/widgets/text_field/custom_text_field.dart';

class QRRequestPage extends StatefulWidget {
  QRRequestPage({super.key});

  @override
  State<QRRequestPage> createState() => _QRRequestPageState();
}

class _QRRequestPageState extends State<QRRequestPage> {
  QRRequestController qrRequestDetailsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: white,
        appBar: InternalHeader(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text("QR Request Details", style: textStyleForTitle),
                SizedBox(height: 30),
                CustomTextField(
                  width: 0.9,
                  height: 0.07,
                  controller: qrRequestDetailsController.fullNameController,
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
                  controller: qrRequestDetailsController.emailController,
                  title: "Email address",
                  required: true,
                  textColor: black,
                  titleStyle: textStyleForTextField,
                  fillColor: white,
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text("",style: textStyleForTextField),
                          SizedBox(height:  6),
                          Container(
                            height: Get.height * 0.07,
                            decoration: BoxDecoration(
                              border: Border.all(color: lightGrey),
                              borderRadius: BorderRadius.circular(10),
                            ),
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
                                qrRequestDetailsController.countryDialCode =
                                    countryCode.dialCode!;
                              },
                              initialSelection: qrRequestDetailsController.countryDialCode,
                              showDropDownButton: true,
                              padding: EdgeInsets.zero,
                              hideMainText: true,
                              showFlagMain: true,
                              flagWidth: 25,
                              dialogBackgroundColor: Theme.of(context).cardColor,
                              textStyle: textStyleForTextField,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: CustomTextField(
                        width: 0.9,
                        height: 0.07,
                        controller:
                            qrRequestDetailsController.phoneNumberController,
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
                  controller: qrRequestDetailsController.companyController,
                  title: "Company name",
                  textColor: black,
                  titleStyle: textStyleForTextField,
                  fillColor: Colors.white,
                  textInputType: TextInputType.number,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  width: 0.9,
                  height: 0.07,
                  controller: qrRequestDetailsController.numberOfQRsController,
                  title: "Quantity",
                  required: true,
                  textColor: black,
                  titleStyle: textStyleForTextField,
                  fillColor: Colors.white,
                  textInputType: TextInputType.number,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  width: 0.9,
                  height: 0.07,
                  controller: qrRequestDetailsController.notesController,
                  title: "Notes",
                  labelText: 'Anything we should know? (optional)',
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
                  title: "Send request",
                  onTap: () async {
                    await qrRequestDetailsController.createQrRequest(context);
                  },
                  borderRadiusBottomLeft: 50,
                  borderRadiusBottomRight: 50,
                  borderRadiusTopLeft: 50,
                  borderRadiusTopRight: 50,
                  loadingColor: white,
                  loading: qrRequestDetailsController.loading.value,
                  textStyle: textStyleForPrimaryButton,
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
