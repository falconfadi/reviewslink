import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reviews_link_v2/data/models/response/service/google_place_response.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';

class GooglePlaceTile extends StatelessWidget {

  final GooglePlaceResponse place;
  final bool selected;
  final VoidCallback? onTap;

  const GooglePlaceTile({super.key, required this.place, this.selected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? darkBlue.withValues(alpha: 0.08) : white,
      borderRadius: BorderRadius.circular(12.r),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: selected ? darkBlue : lightGrey),
          ),
          child: Row(
            children: [
              Icon(Icons.location_on_outlined, color: selected ? darkBlue : grey),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.placeName,
                      style: AppTheme.labelLarge.copyWith(fontSize: 15.sp),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (place.placeAddress.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Text(
                        place.placeAddress,
                        style: AppTheme.bodyMedium.copyWith(color: grey),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              if (selected) ...[
                SizedBox(width: 10.w),
                Icon(Icons.check_circle, color: darkBlue),
              ],
            ],
          ),
        ),
      ),
    );
  }
}