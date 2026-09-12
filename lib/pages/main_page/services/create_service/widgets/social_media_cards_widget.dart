import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/controller.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/widgets/social_media_card_widget.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';

class SocialMediaCardsWidget extends StatelessWidget {

  final int initialCards;
  final bool canAddMore;

  SocialMediaCardsWidget({
    super.key,
    required this.initialCards,
    required this.canAddMore,
  });

  final CreateServiceController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final fixedCards = controller.socialMediaCardsList
          .where((card) => card.isFixed)
          .toList();

      final customCards = controller.socialMediaCardsList
          .where((card) => !card.isFixed)
          .toList();
      return Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: fixedCards.length,
            itemBuilder: (context, index) {
              final card = fixedCards[index];

              return SocialMediaCardWidget(
                key: ValueKey(card.name),
                card: card,
                onRemove: null,
              );
            },
          ),
          if (canAddMore) ...[
            SizedBox(height: 10.h),
            Card(
                color: white,
                shadowColor: grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
                  child:  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Custom URL",
                            style: AppTheme.displayLarge.copyWith(
                              fontSize: 22.sp,
                            ),
                          ),
                          SizedBox(width: 5),
                          CustomButton(
                            width: 0.3.w,
                            height: 0.04,
                            color: green,
                            title: "Add",
                            onTap: () async {
                              controller.addSocialMediaCard();
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: customCards.length,
                        itemBuilder: (context, index) {
                          final card = customCards[index];
                          return SocialMediaCardWidget(
                            key: ValueKey('custom_${card.hashCode}'),
                            card: card,
                            onRemove: () {
                              final actualIndex = controller
                                  .socialMediaCardsList
                                  .indexOf(card);

                              if (actualIndex != -1) {
                                controller.removeSocialMediaCard(
                                  actualIndex,
                                );
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                )
            ),
          ],
        ],
      );
    });
  }
}