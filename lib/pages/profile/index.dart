import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reviews_link_v2/data/constant/api_constant.dart';
import 'package:reviews_link_v2/pages/profile/controller.dart';
import 'package:reviews_link_v2/pages/profile/widget/pick_image_sheet.dart';
import 'package:reviews_link_v2/res/app_images.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/res/styles.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';
import 'package:reviews_link_v2/widgets/dialog/custom_dialog.dart';
import 'package:reviews_link_v2/widgets/header/internal_header.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/widgets/sheet/custom_sheet.dart';
import 'package:reviews_link_v2/widgets/text_field/custom_text_field.dart';

class ProfilePage extends StatelessWidget {

  ProfilePage({super.key});

  final ProfileController profileController = Get.find();

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
                Text("Edit Profile Information", style: textStyleForTitle),
                SizedBox(height: 30),
                Center(
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Dialogs.show(
                            context,
                            content: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () => Get.back(),
                                      child: Icon(Icons.close),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: Get.width,
                                  height: Get.width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: profileController.pickedImage.value != null
                                          ? FileImage(
                                        profileController.pickedImage.value!,
                                      )
                                          : profileController.imageUrl.value.isNotEmpty
                                          ? NetworkImage(
                                        baseUrl +
                                            '/images/users/' +
                                            profileController.imageUrl.value,
                                      )
                                          : AssetImage(USER_ICON) as ImageProvider,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: lightGrey),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: profileController.pickedImage.value != null
                                  ? FileImage(
                                      profileController.pickedImage.value!,
                                    )
                                  : profileController.imageUrl.value.isNotEmpty
                                  ? NetworkImage(
                                      baseUrl +
                                          '/images/users/' +
                                          profileController.imageUrl.value,
                                    )
                                  : AssetImage(USER_ICON) as ImageProvider,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () async {
                            CustomSheet.show(
                              isDismissible: true,
                              header: Text("Select Image",style: textStyleForSmallBlackRegularText.copyWith(fontWeight: FontWeight.w600)),
                              action: InkWell(
                                  onTap: () {
                                    profileController.removeUserImage();
                                  },
                                  child: SvgPicture.asset(DELETE_ICON,width: 25,color: secondaryColor)),
                              padding: 30,
                              context: context,
                              child: PickImageSheet(),
                            );
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primaryColor.withOpacity(1),
                            ),
                            child: Center(
                              child: Icon(Icons.edit, color: white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                CustomTextField(
                  width: 0.9,
                  height: 0.07,
                  controller: profileController.fullNameController,
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
                  controller: profileController.emailController,
                  title: "Email address",
                  textColor: black,
                  titleStyle: textStyleForTextField,
                  fillColor: lightGrey,
                  textInputType: TextInputType.text,
                  readOnly: true,
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
                                profileController.countryDialCode =
                                    countryCode.dialCode!;
                              },
                              initialSelection: profileController.countryDialCode,
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
                        controller: profileController.phoneNumberController,
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
                  controller: profileController.companyNameController,
                  title: "Company name",
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
                  title: "Save changes",
                  onTap: () async {
                    await profileController.updateProfile(context);
                  },
                  borderRadiusBottomLeft: 50,
                  borderRadiusBottomRight: 50,
                  borderRadiusTopLeft: 50,
                  borderRadiusTopRight: 50,
                  loadingColor: white,
                  loading: profileController.loading.value,
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
