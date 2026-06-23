import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/res/color.dart';

class CustomPopupMenuButton extends StatelessWidget {

  final List<PopupMenuEntry<String>> itemBuilder;

  const CustomPopupMenuButton({super.key,
    required this.itemBuilder
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = Constant.isTablet(context);
    return PopupMenuButton(
        icon: Icon(Icons.more_vert, color: white),
        offset: Offset(0, isTablet ? 60 : 40),
        iconSize: isTablet ? 25.sp : null,
        onSelected: (value) {},
        color: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.r),
          ),
        ),
        elevation: 5,
        shadowColor: lightGrey,
        itemBuilder: (BuildContext context) => itemBuilder
    );
  }
}