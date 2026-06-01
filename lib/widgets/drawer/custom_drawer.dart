import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/data/constant/api_constant.dart';
import 'package:reviews_link_v2/pages/main_page/controller.dart';
import 'package:reviews_link_v2/res/app_images.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/res/styles.dart';
import 'package:reviews_link_v2/widgets/custom_svg_pic/custom_svg_image.dart';
import 'package:reviews_link_v2/widgets/footer/supoort_footer.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});

  static Future<void> launchUrls(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  final InitController initController = Get.find();
  final MainPageController mainPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: Get.width * 0.7,
      backgroundColor: white,
      shadowColor: lightGrey,
      elevation: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(height: 60),
              GestureDetector(
                onTap: () {
                  Get.back();
                  Get.toNamed('/profile');
                },
                child: Container(
                  // padding: EdgeInsets.only(left: 10),
                  width: Get.width * 0.7,
                  height: Get.height * 0.25,
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: Get.height * 0.13,
                        height: Get.height * 0.13,
                        decoration: BoxDecoration(
                          color: white,
                          shape: BoxShape.circle,
                          border: Border.all(color: primaryColor, width: 1),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                (initController.userData!.img != null &&
                                    initController.userData!.img!.isNotEmpty)
                                ? NetworkImage(
                                    baseUrl +
                                        '/images/users/' +
                                        initController.userData!.img!,
                                  )
                                : AssetImage(USER_ICON) as ImageProvider,
                            // image: NetworkImage(
                            //   baseUrl +
                            //       '/admin/' +
                            //       initController.userData!.img!,
                            // ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        initController.userData!.userName ?? "",
                        style: textStyleForSmallBlackRegularText,
                      ),
                      Container(
                        width: Get.width * 0.65,
                        child: Center(
                          child: Text(
                            initController.userData!.userEmail ?? "",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: textStyleForSmallBlackRegularText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 10,
                thickness: 1,
                color: black.withAlpha(50),
                indent: 20,
                endIndent: 20,
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                onTap: () {
                  Get.back();
                  Get.toNamed('/changePassword');
                },
                leading: CustomSvgImage(
                  width: 30,
                  height: 30,
                  image: CHANGE_PASSWORD_ICON,
                  color: secondaryColor,
                ),
                title: Text(
                  "Change password",
                  style: textStyleForMediumBlackRegularText,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                onTap: () {
                  Get.back();
                  Get.toNamed('/myQrRequests');
                },
                leading: CustomSvgImage(
                  width: 30,
                  height: 30,
                  image: QR_ICON,
                  color: secondaryColor,
                ),
                title: Text(
                  "My QRs requests",
                  style: textStyleForMediumBlackRegularText,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                onTap: () {
                  Get.back();
                  Get.toNamed('/showSupportTickets');
                },
                leading: Icon(
                  Icons.contact_support,
                  size: 32,
                  color: secondaryColor,
                ),
                title: Text(
                  "My support tickets",
                  style: textStyleForMediumBlackRegularText,
                ),
              ),

              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                onTap: () {
                  initController.logout();
                },
                leading: CustomSvgImage(
                  width: 26,
                  height: 26,
                  image: LOG_OUT_ICON,
                  color: secondaryColor,
                ),
                title: Text(
                  "LogOut",
                  style: textStyleForMediumBlackRegularText,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SupportFooterWidget(
                text: 'Need help? ',
                link: 'Contact support',
                linkTap: () {
                  Get.toNamed('/createSupportTickets');
                },
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  style:
                      textStyleForTinyGrayRegularText, // default style (Powered by)
                  children: [
                    TextSpan(
                      text: "ReviewsLink",
                      style: textStyleForTinyGrayRegularText.copyWith(
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrls(
                            Uri.parse("https://Reviewslink.com/admin"),
                          );
                        },
                    ),
                    TextSpan(text: " Powered by"),
                  ],
                ),
              ),
              SizedBox(height: 5),
              InkWell(
                onTap: () {
                  launchUrls(Uri.parse("https://your1site.com/"));
                },
                child: Text(
                  "Your(1)Site",
                  style: textStyleForSmallGraySemiBoldText.copyWith(
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
