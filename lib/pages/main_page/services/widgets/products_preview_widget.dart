import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reviews_link_v2/data/constant/api_constant.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/custom_picture/custom_png_network.dart';

class ProductsPreviewWidget extends StatelessWidget {

  final List productsList;
  final String Function(dynamic product) getTitle;

  const ProductsPreviewWidget({
    super.key,
    required this.productsList,
    required this.getTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Products: ", style: AppTheme.displayLarge.copyWith(fontSize: 18.sp)),
        SizedBox(height: 10.h),
        SizedBox(
          height: 1.sh * 0.28,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: productsList.length,
            itemBuilder: (context, index) {
              final product = productsList[index];
              final double itemWidth = 1.sw * 0.4;
              return SizedBox(
                width: itemWidth,
                child: Card(
                  color: white,
                  shadowColor: grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  margin: EdgeInsets.only(right: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.r),
                          topRight: Radius.circular(12.r),
                        ),
                        child: CustomPngNetwork(
                          width: itemWidth,
                          height: 1.sh * 0.12,
                          image: product.image != null && product.image!.isNotEmpty
                              ? '$baseUrl/admin/${product.image}'
                              : null,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                getTitle(product),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme.headlineMedium,
                              ),
                              product.description == "" ? Center() :
                              Text(
                                product.description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme.bodyLarge.copyWith(fontSize: 18.sp,color: grey),
                              ),
                              Text(
                                product.price,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme.bodyLarge.copyWith(
                                  color: secondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}