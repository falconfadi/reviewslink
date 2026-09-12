import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reviews_link_v2/res/color.dart';

class CustomRatingBar extends StatelessWidget {
  final double rate;
  final double? size;
  final IconData? iconData;
  final double? itemPadding;
  final ValueChanged<double>? onChanged;

  const CustomRatingBar({
    super.key,
    required this.rate,
    this.size,
    this.iconData,
    this.itemPadding,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: rate,
      minRating: 0,
      glowColor: white,
      ignoreGestures: onChanged == null,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: rate.toInt(),
      itemSize: size ?? 25.w,
      unratedColor: lightGrey,
      itemPadding: EdgeInsets.symmetric(horizontal: itemPadding ?? 1.w),
      itemBuilder: (context, _) => Icon(
        iconData ?? Icons.star_outlined,
        color: yellow,
      ),
      onRatingUpdate: (rating) {
        onChanged?.call(rating);
      },
    );
  }
}