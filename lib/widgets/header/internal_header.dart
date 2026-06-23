import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/res/Keys.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';

class InternalHeader extends StatelessWidget implements PreferredSizeWidget {

  final String? title;
  final bool? automaticallyImplyLeading;

  InternalHeader({super.key, this.title,this.automaticallyImplyLeading});

  @override
  Widget build(BuildContext context) {
    final isTablet = Constant.isTablet(context);
    return AppBar(
      backgroundColor: white,
      shadowColor: lightGrey.withOpacity(0.2),
      surfaceTintColor: white,
      elevation: 1,
      toolbarHeight: isTablet ? 100 : 50,
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back,size: Constant.isTablet(context)  ? 20.sp : null),
        color: primaryColor,
        onPressed: () => Get.back(),
      ),
      title: Text(title ?? "", style: AppTheme.labelLarge.copyWith(fontSize: 18.sp)),
    );
  }

  @override
  Size get preferredSize => Size(
    1.sw,
    Constant.isTablet(
        Keys.navigatorKey.currentContext!) ? 100 : 50,
  );
}
