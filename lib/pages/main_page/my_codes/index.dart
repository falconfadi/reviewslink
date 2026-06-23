import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/data/models/response/service/service_response.dart';
import 'package:reviews_link_v2/pages/main_page/my_codes/controller.dart';
import 'package:reviews_link_v2/pages/main_page/services/controller.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';
import 'package:reviews_link_v2/widgets/card_row_item/card_row_item.dart';
import 'package:reviews_link_v2/widgets/pop_up/custom_popup_menu_button.dart';
import 'package:reviews_link_v2/widgets/dialog/custom_dialog.dart';
import 'package:reviews_link_v2/widgets/dropdown/custom_drop_down.dart';
import 'package:reviews_link_v2/widgets/loading/custom_loading.dart';
import 'package:reviews_link_v2/widgets/snack_bar/top_snack_bar.dart';
import 'package:reviews_link_v2/widgets/text_field/custom_text_field.dart';

class MyCodesPage extends StatefulWidget {

  const MyCodesPage({super.key});

  @override
  State<MyCodesPage> createState() => _MyCodesPageState();
}

class _MyCodesPageState extends State<MyCodesPage> {

  final MyCodesController myCodesController = Get.find();
  final ServiceController serviceController = Get.find();

  @override
  Widget build(BuildContext context) {
    final isTablet = Constant.isTablet(context);
    return Obx(() {
      return Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 1.sh * 0.13),
            child: myCodesController.loading.value ?
            LoadingIndicator() : myCodesController.codesList.isEmpty
                ? Center(
              child: Text(
                "No codes available yet",
                style: AppTheme.labelLarge
              ),
            ) : RefreshIndicator(
              color: primaryColor,
              onRefresh: () async {
                await myCodesController.getCodesList();
              },
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: 35.h),
                itemCount: myCodesController.filteredList.length,
                itemBuilder: (context, index) {
                  final codeItem = myCodesController.filteredList[index];
                  return Card(
                    color: darkBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CardRowItem(
                                    title: "Code",
                                    subTitle: codeItem.code,
                                  ),
                                  SizedBox(height: 8.h),
                                  CardRowItem(
                                    title: "Service",
                                    subTitle:
                                    codeItem.service.name.isEmpty
                                        ? 'No service'
                                        : codeItem.service.name,
                                  ),
                                  SizedBox(height: 8.h),
                                  CardRowItem(
                                    title: "Scan counter",
                                    subTitle: codeItem.scans.toString(),
                                  ),
                                  SizedBox(height: 8.h),
                                  CardRowItem(
                                    title: "Claim date",
                                    subTitle: codeItem.claimDate,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          CustomPopupMenuButton(
                            itemBuilder: [
                              PopupMenuItem(
                                height: isTablet ? 80 : kMinInteractiveDimension,
                                value: "",
                                onTap: () {
                                  myCodesController.selectService = null;
                                  if (codeItem.service.name.isNotEmpty) {
                                    myCodesController.selectService = serviceController.allServices.firstWhereOrNull((s) =>
                                      s.id == codeItem.service.id,
                                    );
                                  }
                                  if (!serviceController.loading.value) {
                                    if (serviceController.allServices.isEmpty) {
                                      TopSnackBar.warning(context,
                                        'No services currently available',
                                      );
                                    } else {
                                      Dialogs.show(
                                        context,
                                        okBtn: Obx(() {
                                          return CustomButton(
                                            width: 1.sw,
                                            height: 0.05,
                                            title: "Assign",
                                            loading: myCodesController.loadingAssign.value,
                                            onTap: () async {
                                              if (myCodesController.selectService != null) {
                                                await myCodesController.assignCode(
                                                  codeItem.id,
                                                  myCodesController.selectService!.id,
                                                  context,
                                                );
                                              } else {
                                                TopSnackBar.warning(
                                                  context,
                                                  'Please chose service',
                                                );
                                              }
                                              TopSnackBar.warning(
                                                context,
                                                'Please chose service',
                                              );
                                            },
                                          );
                                        }),
                                        cancelBtn: true,
                                        content: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Assign service",
                                                    style: AppTheme.headlineMedium,
                                                  ),
                                                  InkWell(
                                                    onTap: () => Get.back(),
                                                    child: Icon(Icons.close,size: isTablet ? 20.sp : null),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 25.h),
                                              StatefulBuilder(
                                                builder: (context, setStateDialog) {
                                                  return CustomDropDown(
                                                    width: 1.sw,
                                                    height: 1.sh * 0.07,
                                                    title: "My services",
                                                    text: "",
                                                    value: myCodesController.selectService,
                                                    onChanged: (value) {
                                                      print(value!.id.toString());
                                                      setStateDialog(() {
                                                        myCodesController.selectService = value;
                                                      });
                                                    },
                                                    items: serviceController.allServices.map((service) {
                                                      return DropdownMenuItem<ServiceResponse>(
                                                        value: service,
                                                        child: Row(
                                                          children: [
                                                            SizedBox(width: 8.w),
                                                            Expanded(
                                                              child: Text(service.name,
                                                                style: AppTheme.bodyLarge,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }).toList(),
                                                  );
                                                },
                                              ),
                                              SizedBox(height: 25.h),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Center(
                                  child: Text("Assign service",
                                    textAlign: TextAlign.center,
                                    style: AppTheme.labelLarge.copyWith(fontSize: 18.sp),
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                value: "",
                                height: isTablet ? 80 : kMinInteractiveDimension,
                                onTap: () async {
                                  myCodesController.printCodePdf(codeItem.code);
                                },
                                child: Center(
                                  child: Text("Print",
                                    style: AppTheme.labelLarge.copyWith(fontSize: 18.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.h),
                  CustomTextField(
                    controller: myCodesController.searchController,
                    labelText: "Type to search",
                    textInputType: TextInputType.text,
                    suffixIcon: Padding(
                      padding: isTablet
                          ? EdgeInsets.symmetric(horizontal: 10.w)
                          : EdgeInsets.zero,
                      child: InkWell(
                        onTap: () {
                          if (myCodesController.searchController.text.isNotEmpty) {
                            myCodesController.searchController.clear();
                          }
                        },
                        child: Icon(
                          myCodesController.searchController.text.isEmpty ? Icons.search : Icons.close,
                          size: isTablet ? 20.sp : null,

                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h),
                ],
              ),
            ),
          ),
          myCodesController.loadingAssign.value
              ? Container(
                  width: 1.sw,
                  height: 1.sh,
                  color: primaryColor.withAlpha(100),
                  child: LoadingIndicator(color: white)
                )
              : const SizedBox(),
        ],
      );
    });
  }
}
