import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/pages/main_page/services/reviews/controller.dart';
import 'package:reviews_link_v2/res/app_images.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/header/internal_header.dart';
import 'package:reviews_link_v2/widgets/loading/custom_loading.dart';
import 'package:reviews_link_v2/widgets/rating_bar/custom_rating_bar.dart';

class ReviewsPage extends StatelessWidget {

  ReviewsPage({super.key});

  final ReviewsController reviewsController = Get.find();

  @override
  Widget build(BuildContext context) {
    final isTablet = Constant.isTablet(context);
    return Scaffold(
      backgroundColor: white,
      appBar: InternalHeader(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25.h),
              RichText(
                text: TextSpan(
                  text: "Reviews",
                  style: AppTheme.displayLarge.copyWith(fontSize: 22.sp),
                  children: [
                    TextSpan(
                      text: " (" + reviewsController.data.reviewsCount.toString() + ")",
                      style: AppTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.h),
              Container(
                child: reviewsController.data.reviews.isEmpty
                    ? Center(
                  child: Text(
                      "No reviews yet",
                      style: AppTheme.labelLarge
                  ),
                ) : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: reviewsController.data.reviews.length,
                  itemBuilder: (context, index) {
                    final reviewItem = reviewsController.data.reviews[index];
                    return Card(
                      color: white,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(reviewItem.feedbackType,
                                    style: AppTheme.bodyLarge,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Obx(() {
                                  final isThisItemDeleting = reviewsController.deletingItemId.value == reviewItem.id;
                                  return isThisItemDeleting ?
                                  Center(
                                    child: LoadingIndicator(
                                      height: 0.02.sh,
                                      width: 0.02.sh,
                                      color: secondaryColor,
                                    ),
                                  ) : InkWell(
                                    onTap: () async {
                                      await reviewsController.deleteServiceReview(
                                        reviewItem.id,
                                        context,
                                      );
                                    },
                                    child: SvgPicture.asset(
                                      DELETE_ICON,
                                      width: 25.w,
                                      color: secondaryColor,
                                    ),
                                  );
                                }),
                              ],
                            ),
                            SizedBox(height: 5),
                            CustomRatingBar(
                              rate: reviewItem.rating.toDouble(),
                              size: isTablet ? 20.sp : 25.sp,
                              itemPadding: 0,
                              onChanged: null
                            ),
                            if(reviewItem.comment != "")...[
                              SizedBox(height: 5),
                              Text(reviewItem.comment,
                                style: AppTheme.labelLarge,
                              ),
                            ],
                            SizedBox(height: 5),
                            Text(reviewItem.createdAt,
                              style: AppTheme.labelLarge,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
