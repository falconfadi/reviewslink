import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/res/styles.dart';

class InternalHeader extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  InternalHeader({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: white,
      shadowColor: lightGrey.withOpacity(0.2),
      surfaceTintColor: white,
      iconTheme: IconThemeData(color: primaryColor),
      centerTitle: true,
      title: Text(title ?? "", style: textStyleForMediumBlackRegularText),
    );
  }

  @override
  Size get preferredSize => Size(Get.width, 50);
}
