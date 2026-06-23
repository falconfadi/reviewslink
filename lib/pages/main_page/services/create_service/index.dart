import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/data/models/response/init/init_response.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/controller.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/widgets/list_of_products_widget.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/widgets/restaurant_menu_widget.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/widgets/single_product_widget.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';
import 'package:reviews_link_v2/widgets/dropdown/custom_drop_down.dart';
import 'package:reviews_link_v2/widgets/header/internal_header.dart';
import 'package:reviews_link_v2/widgets/text_field/custom_text_field.dart';

class CreateServicePage extends StatefulWidget {

  CreateServicePage({super.key});

  @override
  State<CreateServicePage> createState() => _CreateServicePageState();
}

class _CreateServicePageState extends State<CreateServicePage> {

  final CreateServiceController createServiceController = Get.find();
  InitController initController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
                Text(createServiceController.editStatus == true ?
                "Edit this service" : "Add new service",
                    style: AppTheme.displayLarge.copyWith(fontSize: 22.sp)),
                SizedBox(height: 25.h),
                CustomDropDown(
                  width: 1.sw,
                  height: 1.sh * 0.07,
                  title: "Service type",
                  required: true,
                  text: "",
                  dropdownColor: createServiceController.editStatus == true ?
                  lightGrey : white,
                  value: createServiceController.selectedType,
                  onChanged: createServiceController.editStatus == true
                      ? null
                      : (ServiceType? value) {
                          setState(() {
                            createServiceController.clearData();
                            createServiceController.clearSingleProduct();
                            createServiceController.selectedType = value;
                          });
                        },
                  items: initController.servicesTypeList.map((type) {
                    return DropdownMenuItem<ServiceType>(
                      value: type,
                      child: Row(
                        children: [
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              createServiceController.formatText(type.name ?? ""),
                              style: AppTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                createServiceController.selectedType == null
                    ? SizedBox()
                    : createServiceController.selectedType!.name == "list_of_products"
                    ? ListOfProductsWidget(createServiceController: createServiceController)
                    : (createServiceController.selectedType!.name == 'product')
                    ? SingleProductWidget(createServiceController: createServiceController, initController: initController)
                    : (createServiceController.selectedType!.name == "restaurant_menu")
                    ? RestaurantMenuWidget(createServiceController: createServiceController)
                    : (createServiceController.selectedType!.name == "url")
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 25.h),
                          CustomTextField(
                            controller: createServiceController.titleController,
                            title: "Title (optional)",
                            labelText: "e.g. My website url",
                            textInputType: TextInputType.text,
                          ),
                          SizedBox(height: 25.h),
                          CustomTextField(
                            controller: createServiceController.urlController,
                            title: "URL",
                            required: true,
                            labelText: "https://google.com",
                            textInputType: TextInputType.text,
                          ),
                        ],
                      )
                    : Container(
                        height: 1.sh * 0.2,
                        child: Center(child: Text('Coming soon',
                            style: AppTheme.labelLarge
                        )),
                      ),
                SizedBox(height: 50.h),
                createServiceController.allowedTypes.contains(
                      createServiceController.selectedType?.name) ?
                CustomButton(
                  width: 1.sw,
                  height: 0.07,
                  color: createServiceController.selectedType == null
                      ? grey : secondaryColor,
                  title: createServiceController.editStatus == true
                      ? 'Update' : "Save",
                  onTap: () async {
                    if (createServiceController.editStatus == true) {
                      await createServiceController.choseUpdateOption(
                        context,
                      );
                    } else {
                      await createServiceController.choseSaveOption(
                        context,
                      );
                    }
                  },
                  borderRadius: 50.r,
                  loading: createServiceController.loading.value,
                ) : SizedBox(),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      );
    });
  }
}