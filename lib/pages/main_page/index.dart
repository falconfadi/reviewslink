import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/home/index.dart';
import 'package:reviews_link_v2/pages/main_page/controller.dart';
import 'package:reviews_link_v2/pages/my_codes/index.dart';
import 'package:reviews_link_v2/pages/services/index.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/res/styles.dart';
import 'package:reviews_link_v2/widgets/bottom_bar/custom_bottom_bar.dart';
import 'package:reviews_link_v2/widgets/bottom_bar/custom_floating_bottom.dart';
import 'package:reviews_link_v2/widgets/drawer/custom_drawer.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final MainPageController mainPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return WillPopScope(
        onWillPop: () async {
          return await mainPageController.backButton(context);
        },
        child: Scaffold(
          key: mainPageController.scaffoldKey,
          drawer: DrawerWidget(),
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: CustomBottomBar(),
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            backgroundColor: white,
            iconTheme: IconThemeData(color: primaryColor),
            title: Text(
              mainPageController.pageIndex.value == 0
                  ? 'My QRs'
                  : mainPageController.pageIndex.value == 2
                  ? 'My services'
                  : mainPageController.pageIndex.value == 1 &&
                        mainPageController.scanPopUpStatus.value
                  ? 'Claim QR'
                  : 'Home',
              style: textStyleForMediumBlackRegularText,
            ),
          ),
          floatingActionButton: MediaQuery.of(context).viewInsets.bottom > 0
              ? null
              : CustomFloatingButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: SafeArea(
            child: PageView(
              controller: mainPageController.pageController,
              onPageChanged: (index) {
                mainPageController.pageIndex.value = index;
              },
              physics: const BouncingScrollPhysics(),
              children: [MyCodesPage(), HomePage(), ServicesPage()],
            ),
          ),
        ),
      );
    });
  }
}
