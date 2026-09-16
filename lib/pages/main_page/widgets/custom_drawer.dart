import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/data/constant/api_constant.dart';
import 'package:reviews_link_v2/pages/main_page/controller.dart';
import 'package:reviews_link_v2/res/app_images.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/custom_picture/custom_svg_image.dart';
import 'package:reviews_link_v2/widgets/footer/custom_footer.dart';

class DrawerWidget extends StatelessWidget {

  DrawerWidget({super.key});

  final InitController initController = Get.find();
  final MainPageController mainPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 0.7.sw,
      backgroundColor: white,
      shadowColor: lightGrey,
      elevation: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 70.h),
                  GestureDetector(
                    onTap: () => _navigateTo('/profile'),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      width: 1.sw,
                      color: Colors.transparent,
                      child: Column(
                         children: [
                          Container(
                            width: 0.13.sh,
                            height: 0.13.sh,
                            decoration: BoxDecoration(
                              color: white,
                              shape: BoxShape.circle,
                              border: Border.all(color: primaryColor, width: 1),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: (initController.userData!.img != null &&
                                    initController.userData!.img!.isNotEmpty)
                                    ? NetworkImage(
                                  baseUrl + '/images/users/' +
                                      initController.userData!.img!,
                                ) : AssetImage(USER_ICON) as ImageProvider,
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            initController.userData!.userName ?? "",
                            style: AppTheme.bodyLarge,
                          ),
                           SizedBox(height: 5.h),
                          Text("User",
                            textAlign: TextAlign.center,
                            style: AppTheme.labelLarge.copyWith(
                              color: grey
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Divider(
                    height: 10.h,
                    thickness: 1,
                    color: black.withAlpha(50),
                    indent: 20.w,
                    endIndent: 20.w,
                  ),
                  SizedBox(height: 10.h),
                  _buildDrawerTile(
                    iconPath: CHANGE_PASSWORD_ICON,
                    title: "Change password",
                    onTap: () => _navigateTo('/changePassword'),
                  ),
                  _buildDrawerTile(
                    iconPath: QR_ICON,
                    title: "My QRs requests",
                    onTap: () => _navigateTo('/myQrRequests'),
                  ),
                  _buildDrawerTile(
                    iconData: Icons.contact_support,
                    title: "My support tickets",
                    onTap: () => _navigateTo('/showSupportTickets'),
                  ),
                  _buildDrawerTile(
                    iconPath: LOG_OUT_ICON,
                    title: "LogOut",
                    onTap: () => initController.logout(),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomFooterWidget(
                  text: 'Need help? ',
                  link: 'Contact support',
                  linkTap: () {
                    Get.toNamed('/createSupportTickets');
                  },
                ),
                SizedBox(height: 10.h),
                RichText(
                  text: TextSpan(
                    style: AppTheme.labelMedium,
                    children: [
                      TextSpan(text: "2026 © ",
                          style: AppTheme.labelMedium.copyWith(color: grey)
                      ),
                      TextSpan(
                        text: "ReviewsLink",
                        style: AppTheme.labelMedium.copyWith(
                          color: primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Constant.launchUrls(Uri.parse("https://Reviewslink.com/admin"));
                          },
                      ),
                      TextSpan(text: " by",
                        style: AppTheme.labelMedium.copyWith(color: grey)
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "TRUST IT SKILLS - FZCO",
                  style: AppTheme.bodyLarge.copyWith(
                    fontWeight: FontWeight.w500,
                    color: grey,
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateTo(String routeName) {
    Get.back();
    Get.toNamed(routeName);
  }

  Widget _buildDrawerTile({String? iconPath, IconData? iconData,
    required String title, required VoidCallback onTap}) {
    return ListTile(
      onTap: onTap,
      minLeadingWidth: 28.w,
      minTileHeight: 60.h,
      leading: iconPath != null
          ? CustomSvgImage(width: 28.w, height: 28.w, image: iconPath, color: secondaryColor)
          : Icon(iconData, size: 30.sp, color: secondaryColor),
      title: Text(title, style: AppTheme.labelLarge.copyWith(fontSize: 18.sp),
      ),
    );
  }
}
