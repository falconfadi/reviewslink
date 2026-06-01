import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reviews_link_v2/pages/profile/controller.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/res/styles.dart';

class PickImageSheet extends StatelessWidget {

  PickImageSheet({super.key});

  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildPickOption(
              icon: Icons.image_outlined,
              labelKey: "Gallery",
              source: ImageSource.gallery,
            ),
            _buildPickOption(
              icon: Icons.camera_alt_outlined,
              labelKey: "Camera",
              source: ImageSource.camera,
            ),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildPickOption({required IconData icon, required String labelKey, required ImageSource source}) {
    return InkWell(
      onTap: () async {
        final file = await profileController.selectImage(imageSource: source);
        if (file != null) {
          profileController.pickedImage.value = file;
          Get.back();
        }
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor,
            ),
            child: Center(
              child: Icon(icon, size: 30, color: white),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(labelKey,
              style: textStyleForSmallBlackRegularText.copyWith(fontWeight: FontWeight.w600)
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}


