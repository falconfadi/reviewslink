import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/controller.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/widgets/social_media_cards_widget.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/widgets/social_media_profile_widget.dart';

class SocialMediaService extends StatelessWidget {

  final int initialCards;
  final bool canAddMore;

  SocialMediaService({super.key,
    required this.initialCards,
    required this.canAddMore,
  });

  final CreateServiceController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SocialMediaProfileWidget(controller: controller),
        SizedBox(height: 25.h),
        SocialMediaCardsWidget(
          initialCards: initialCards,
          canAddMore: canAddMore,
        ),
      ],
    );
  }
}