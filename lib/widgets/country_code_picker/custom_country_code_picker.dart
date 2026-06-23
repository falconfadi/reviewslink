import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';

class CustomCountryCodePicker extends StatelessWidget {

  final void Function(CountryCode) onChanged;
  final String initialSelection;

  const CustomCountryCodePicker({
    required this.onChanged,
    required this.initialSelection,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = Constant.isTablet(context);
    return CountryCodePicker(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      closeIcon: Icon(
          Icons.close, size: isTablet ? 20.sp : null
      ),
      topBarPadding: isTablet ? EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w): EdgeInsets.zero,
      headerTextStyle: AppTheme.bodyLarge,
      searchDecoration: InputDecoration(
        prefixIcon: Icon(
            Icons.search,
            size: isTablet ? 20.sp : null
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 18.h,
        ),
      ),
      onChanged: onChanged,
      initialSelection: initialSelection,
      showDropDownButton: true,
      padding: EdgeInsets.zero,
      hideMainText: true,
      showFlagMain: true,
      flagWidth: isTablet ? 50 : 25,
      dialogBackgroundColor: white,
    );
  }
}
