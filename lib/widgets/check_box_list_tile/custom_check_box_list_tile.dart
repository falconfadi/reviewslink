import 'package:flutter/material.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';

class CustomCheckBoxListTile extends StatelessWidget {

  final bool value;
  final void Function(bool?) onChanged;
  final String title;

  const CustomCheckBoxListTile({super.key,
    required this.value,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = Constant.isTablet(context);
    return CheckboxListTile(
      checkboxScaleFactor: isTablet ? 1.8 : 1,
      contentPadding: EdgeInsets.zero,
      value: value,
      onChanged: onChanged,
      title: Text(title,
        style: AppTheme.labelMedium,
      ),
      activeColor: primaryColor,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
