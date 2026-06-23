import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/pages/main_page/home/index.dart';
import 'package:reviews_link_v2/pages/main_page/controller.dart';
import 'package:reviews_link_v2/pages/main_page/my_codes/index.dart';
import 'package:reviews_link_v2/pages/main_page/services/index.dart';
import 'package:reviews_link_v2/pages/main_page/widgets/custom_drawer.dart';
import 'package:reviews_link_v2/pages/main_page/widgets/custom_floating_bottom.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/pages/main_page/widgets/custom_bottom_bar.dart';

class MainPage extends StatelessWidget {

  MainPage({super.key});

  final MainPageController mainPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    final isTablet = Constant.isTablet(context);
    return Obx(() {
      return WillPopScope(
        onWillPop: () async {
          return await mainPageController.backButton(context);
        },
        child: Scaffold(
          backgroundColor: white,
          key: mainPageController.scaffoldKey,
          drawer: DrawerWidget(),
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: CustomBottomBar(),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: white,
            shadowColor: lightGrey.withOpacity(0.2),
            surfaceTintColor: white,
            elevation: 1,
            toolbarHeight: isTablet ? 100 : 50 ,
            leading: IconButton(
              icon: Icon(Icons.menu,size: Constant.isTablet(context)  ? 25.sp : null),
              color: primaryColor,
              onPressed: () => mainPageController.scaffoldKey.currentState?.openDrawer(),
            ),
            title: Text(
              mainPageController.pageIndex.value == 0
                  ? 'My QRs'
                  : mainPageController.pageIndex.value == 2
                  ? 'My services'
                  : mainPageController.pageIndex.value == 1 &&
                        mainPageController.scanPopUpStatus.value
                  ? 'Claim QR'
                  : 'Home',
              style: AppTheme.labelLarge.copyWith(fontSize: 18.sp),
            ),
          ),
          floatingActionButton: MediaQuery.of(context).viewInsets.bottom > 0
              ? null
              : CustomFloatingButton(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
