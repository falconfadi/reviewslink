import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:url_launcher/url_launcher.dart';

class Constant {

  static closeKeyBoard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static Future<void> launchUrls(Uri url) async {
    if (!await launchUrl(url,mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  static bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  static String formatText(String text) {
    return text.replaceAll('_', ' ').split(' ').map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  static const Map<String, String> _serviceTypeNames = {
    'url': 'URL',
    'social_media_cards_4': 'Social Media 4 Cards',
    'social_media_cards_8': 'Social Media 8 Cards',
    'social_media_cards_unlimited': 'Social Media Unlimited Cards',
    'rating_form': 'Rating Form',
  };

  static String serviceTypeName(String key) {
    return _serviceTypeNames[key] ?? formatText(key);
  }

  static PinTheme defaultPinTheme = PinTheme(
    width: 50.w,
    height: 80.h,
    textStyle: AppTheme.displayLarge.copyWith(fontSize: 22.sp),
    decoration: BoxDecoration(
      color: white,
      border: Border.all(color: lightGrey),
      borderRadius: BorderRadius.circular(15.r),
    ),
  );
  static PinTheme focusedPinTheme = defaultPinTheme.copyDecorationWith(
    color: white,
    border: Border.all(color: lightGrey),
    borderRadius: BorderRadius.circular(15.r),
  );
  static PinTheme submittedPinTheme = defaultPinTheme.copyWith(
    decoration: defaultPinTheme.decoration?.copyWith(color: white),
  );

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600;
  }

}
