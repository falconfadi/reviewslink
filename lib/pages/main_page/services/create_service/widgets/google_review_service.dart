import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/controller.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/widgets/google_place_tile.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/text_field/custom_text_field.dart';

class GoogleReviewService extends StatelessWidget {

  final CreateServiceController controller;

  const GoogleReviewService({super.key, required this.controller});


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selectedPlace = controller.selectedGooglePlace.value;
      final results = controller.googlePlaces
          .where((place) => place.placeId != selectedPlace?.placeId)
          .toList();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 25.h),
          CustomTextField(
            controller: controller.googleReviewNameController,
            title: "Name (optional)",
            labelText: "e.g. Google Reviews - My business",
            textInputType: TextInputType.text,
          ),
          SizedBox(height: 25.h),
          if (selectedPlace != null) ...[
            Text('Selected business',
              style: AppTheme.labelLarge.copyWith(fontSize: 15.sp,fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 6.h),
            GooglePlaceTile(place: selectedPlace, selected: true),
            SizedBox(height: 25.h),
          ],
          CustomTextField(
            controller: controller.googlePlaceSearchController,
            title: selectedPlace == null ? "Search your business on Google" : "Change business",
            required: selectedPlace == null,
            labelText: "e.g. Amani Spa Abu Dhabi",
            textInputType: TextInputType.text,
            onChanged: controller.onGooglePlaceSearchChanged,
            suffixIcon: controller.searchingGooglePlaces.value
                ? Padding(
                    padding: EdgeInsets.all(12.r),
                    child: SizedBox(
                      width: 18.r,
                      height: 18.r,
                      child: CircularProgressIndicator(strokeWidth: 2, color: grey),
                    ),
                  )
                : Icon(Icons.search, color: grey),
          ),
          if (controller.googlePlacesSearched.value && controller.googlePlaces.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Text('No results found, try a more specific name or add the city',
                style: AppTheme.bodyMedium.copyWith(color: grey),
              ),
            ),
          ...results.map((place) => Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: GooglePlaceTile(
              place: place,
              onTap: () => controller.selectGooglePlace(place),
            ),
          )),
        ],
      );
    });
  }
}