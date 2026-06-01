import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/data/constant/api_constant.dart';
import 'package:reviews_link_v2/data/models/response/init/init_response.dart';
import 'package:reviews_link_v2/pages/create_service/controller.dart';
import 'package:reviews_link_v2/pages/create_service/widgets/build_color_itm.dart';
import 'package:reviews_link_v2/res/color.dart';

import 'package:reviews_link_v2/res/styles.dart';
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
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                createServiceController.editStatus == true
                    ? Text("Edit this service", style: textStyleForTitle)
                    : Text("Add new service", style: textStyleForTitle),
                SizedBox(height: 30),
                CustomDropDown(
                  width: Get.width,
                  height: Get.height * 0.06,
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
                            createServiceController.selectedType = value;
                          });
                        },
                  items: initController.servicesTypeList.map((type) {
                    return DropdownMenuItem<ServiceType>(
                      value: type,
                      child: Row(
                        children: [
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              createServiceController.formatText(
                                type.name ?? "",
                              ),
                              style: textStyleForSmallBlackRegularText,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                createServiceController.selectedType == null
                    ? SizedBox()
                    : createServiceController.selectedType!.name ==
                          "list_of_products"
                    ? buildListOfProduct()
                    : (createServiceController.selectedType!.name == 'product')
                    ? buildSingleProductWidget()
                    : (createServiceController.selectedType!.name ==
                          "restaurant_menu")
                    ? buildRestaurantMenuWidget()
                    : (createServiceController.selectedType!.name == "url")
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15),
                          CustomTextField(
                            width: 0.9,
                            height: 0.06,
                            controller: createServiceController.titleController,
                            title: "Title (optional)",
                            textColor: black,
                            labelText: "e.g. My website url",
                            titleStyle: textStyleForTextField,
                            fillColor: Colors.white,
                            textInputType: TextInputType.text,
                          ),
                          SizedBox(height: 15),
                          CustomTextField(
                            width: 0.9,
                            height: 0.06,
                            controller: createServiceController.urlController,
                            title: "URL",
                            required: true,
                            labelText: "https://google.com",
                            textColor: black,
                            titleStyle: textStyleForTextField,
                            fillColor: Colors.white,
                            textInputType: TextInputType.text,
                          ),
                        ],
                      )
                    : Container(
                        height: Get.height * 0.2,
                        child: Center(child: Text('Coming soon')),
                      ),
                SizedBox(height: 40),
                createServiceController.allowedTypes.contains(
                      createServiceController.selectedType?.name,
                    )
                    ? CustomButton(
                        width: Get.width,
                        height: 0.075,
                        color: createServiceController.selectedType == null
                            ? grey
                            : secondaryColor,
                        title: createServiceController.editStatus == true
                            ? 'Update'
                            : "Save",
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
                        borderRadiusBottomLeft: 50,
                        borderRadiusBottomRight: 50,
                        borderRadiusTopLeft: 50,
                        borderRadiusTopRight: 50,
                        loadingColor: white,
                        loading: createServiceController.loading.value,
                        textStyle: textStyleForPrimaryButton,
                      )
                    : SizedBox(),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget buildListOfProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        CustomTextField(
          width: 0.9,
          height: 0.06,
          controller: createServiceController.pageTitleController,
          title: "Page title",
          required: true,
          textColor: black,
          labelText: 'Name of company',
          titleStyle: textStyleForTextField,
          fillColor: Colors.white,
          textInputType: TextInputType.text,
        ),
        const SizedBox(height: 20),
        Text.rich(
          style: textStyleForTextField,
          TextSpan(
            text: "Logo",
            children: [
              TextSpan(
                text: ' *',
                style: textStyleForTextField.copyWith(color: red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () async {
            File? pickedImage = await createServiceController.selectImage();
            if (pickedImage != null) {
              createServiceController.logo.value = pickedImage;
            }
          },
          child: Container(
            height: Get.width * 0.25,
            width: Get.width * 0.25,
            decoration: BoxDecoration(
              color: lightGrey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: lightGrey),
            ),
            child: createServiceController.logo.value.path != ""
                ? Image.file(
                    createServiceController.logo.value,
                    fit: BoxFit.cover,
                  )
                : createServiceController.logoUrl != null
                ? Image.network(
                    baseUrl + '/admin/' + createServiceController.logoUrl!,
                    fit: BoxFit.cover,
                  )
                : const Icon(Icons.add_a_photo),
            // createServiceController.logo.value.path == ''
            // ? const Icon(Icons.add_a_photo)
            // : Image.file(
            //     createServiceController.logo.value,
            //     fit: BoxFit.cover,
            //   ),
          ),
        ),
        const SizedBox(height: 20),
        Text("Products", style: textStyleForTextField),
        const SizedBox(height: 6),
        buildProductsList(),
      ],
    );
  }

  Widget buildProductsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: createServiceController.products.length,
          itemBuilder: (context, index) {
            return productCard(index);
          },
        ),
        SizedBox(height: 15),
        Align(
          alignment: Alignment.centerLeft,
          child: CustomButton(
            width: 0.55,
            height: 0.05,
            color: green,
            title: "Add product",
            textStyle: textStyleForPrimaryButton,
            onTap: () {
              setState(() {
                createServiceController.addProduct();
              });
            },
          ),
        ),
      ],
    );
  }

  Widget productCard(int index) {
    final product = createServiceController.products[index];
    return Obx(() {
      return Card(
        color: white,
        shadowColor: grey,
        elevation: 3,
        margin: EdgeInsets.only(bottom: 15),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product no. ' + (index + 1).toString(),
                    style: textStyleForSmallBlackRegularText,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: red,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Center(
                          child: Icon(Icons.close, color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          createServiceController.removeProduct(index);
                        });
                      },
                    ),
                  ),
                ],
              ),
              CustomTextField(
                width: 0.9,
                height: 0.06,
                controller: product.title,
                title:
                    createServiceController.selectedType!.name ==
                        'restaurant_menu'
                    ? "Name"
                    : "Title",
                required: true,
                labelText:  createServiceController.selectedType!.name ==
              'restaurant_menu' ? 'e.g. Hamburger' : 'e.g. Wireless Mouse',
                textColor: black,
                titleStyle: textStyleForTextField,
                fillColor: Colors.white,
                textInputType: TextInputType.text,
              ),
              SizedBox(height: 15),
              CustomTextField(
                width: 0.9,
                height: 0.06,
                controller: product.description,
                title:
                    createServiceController.selectedType!.name ==
                        'restaurant_menu'
                    ? "Components"
                    : "Description",
                labelText:  createServiceController.selectedType!.name ==
                    'restaurant_menu' ? 'e.g. Meat, egg, cheese ... etc'
                    : 'e.g. High quality mouse with ergonomic design',
                textColor: black,
                titleStyle: textStyleForTextField,
                fillColor: Colors.white,
                textInputType: TextInputType.text,
              ),
              SizedBox(height: 15),
              CustomTextField(
                width: 0.9,
                height: 0.06,
                controller: product.price,
                title: "Price",
                required: true,
                labelText: 'e.g. 25\$',
                textColor: black,
                titleStyle: textStyleForTextField,
                fillColor: Colors.white,
                textInputType: TextInputType.phone,
              ),
              SizedBox(height: 15),
              Text.rich(
                style: textStyleForTextField,
                TextSpan(
                  text: "Image",
                  children: [
                    TextSpan(
                      text: ' *',
                      style: textStyleForTextField.copyWith(color: red),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () async {
                  File? pickedImage = await createServiceController
                      .selectImage();
                  if (pickedImage != null) {
                    product.image.value = pickedImage;
                  }
                },
                child: Container(
                  height: Get.height * 0.15,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: lightGrey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: lightGrey),
                  ),
                  child: product.image.value.path != ""
                      ? Image.file(product.image.value, fit: BoxFit.cover)
                      : product.imageUrl != null
                      ? Image.network(
                          baseUrl + '/admin/' + product.imageUrl!,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.add_a_photo),
                ),
              ),

              // const SizedBox(height: 10),
            ],
          ),
        ),
      );
    });
  }

  Widget buildSingleProductWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        CustomDropDown(
          width: Get.width,
          height: Get.height * 0.06,
          title: "Currency",
          text: "Select currency",
          required: true,
          value: createServiceController.selectedCurrency,
          onChanged: (value) {
            setState(() {
              print(value);
              createServiceController.selectedCurrency = value;
            });
          },
          items: initController.currencyList.map((currency) {
            return DropdownMenuItem<Currencies>(
              value: currency,
              child: Row(
                children: [
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      currency.name ?? "",
                      style: textStyleForSmallBlackRegularText,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 10),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          value: createServiceController.multiCurrency,
          onChanged: (v) {
            setState(() {
              createServiceController.multiCurrency = v!;
            });
          },
          title: const Text("Show in multi-currency"),
          controlAffinity: ListTileControlAffinity.leading,
        ),
        const SizedBox(height: 10),
        Text("Product", style: textStyleForTextField),
        const SizedBox(height: 6),
        Card(
          color: white,
          shadowColor: grey,
          elevation: 3,
          margin: EdgeInsets.only(bottom: 15),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  width: 0.9,
                  height: 0.06,
                  controller: createServiceController.singleProduct.title,
                  title: "Name",
                  required: true,
                  labelText: 'e.g. Wireless Mouse',
                  textColor: black,
                  titleStyle: textStyleForTextField,
                  fillColor: Colors.white,
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 15),
                CustomTextField(
                  width: 0.9,
                  height: 0.06,
                  controller: createServiceController.singleProduct.description,
                  title: "Description",
                  labelText: 'e.g. High quality mouse with ergonomic design',
                  textColor: black,
                  titleStyle: textStyleForTextField,
                  fillColor: Colors.white,
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 15),
                CustomTextField(
                  width: 0.9,
                  height: 0.06,
                  controller: createServiceController.singleProduct.productId,
                  title: "Product ID",
                  labelText: 'e.g. WM-1023',
                  textColor: black,
                  titleStyle: textStyleForTextField,
                  fillColor: Colors.white,
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 15),
                CustomTextField(
                  width: 0.9,
                  height: 0.06,
                  controller: createServiceController.singleProduct.price,
                  title: "Price",
                  required: true,
                  labelText: 'e.g. 25\$',
                  textColor: black,
                  titleStyle: textStyleForTextField,
                  fillColor: Colors.white,
                  textInputType: TextInputType.phone,
                ),
                SizedBox(height: 15),
                Text.rich(
                  style: textStyleForTextField,
                  TextSpan(
                    text: "Image",
                    children: [
                      TextSpan(
                        text: ' *',
                        style: textStyleForTextField.copyWith(color: red),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () async {
                    File? pickedImage = await createServiceController
                        .selectImage();

                    if (pickedImage != null) {
                      createServiceController.singleProduct.image.value =
                          pickedImage;
                    }
                  },
                  child: Container(
                    height: Get.height * 0.2,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: lightGrey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: lightGrey),
                    ),
                    child:
                        createServiceController
                                .singleProduct
                                .image
                                .value
                                .path !=
                            ""
                        ? Image.file(
                            createServiceController.singleProduct.image.value,
                            fit: BoxFit.cover,
                          )
                        : createServiceController.singleProduct.imageUrl != null
                        ? Image.network(
                            baseUrl +
                                '/admin/' +
                                createServiceController.singleProduct.imageUrl!,
                          )
                        : const Icon(Icons.add_a_photo),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildRestaurantMenuWidget() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          CustomTextField(
            width: 0.9,
            height: 0.06,
            controller: createServiceController.pageTitleController,
            title: "Page title",
            required: true,
            textColor: black,
            titleStyle: textStyleForTextField,
            fillColor: Colors.white,
            textInputType: TextInputType.text,
          ),
          SizedBox(height: 15),
          CustomTextField(
            width: 0.9,
            height: 0.06,
            controller: createServiceController.descriptionController,
            title: "Description",
            textColor: black,
            titleStyle: textStyleForTextField,
            fillColor: Colors.white,
            textInputType: TextInputType.text,
          ),
          SizedBox(height: 15),
          Card(
            color: white,
            shadowColor: grey,
            elevation: 3,
            margin: EdgeInsets.only(bottom: 10),
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Header", style: textStyleForSubTitle),
                  const SizedBox(height: 10),
                  Text.rich(
                    style: textStyleForTextField,
                    TextSpan(
                      text: "Logo",
                      children: [
                          TextSpan(
                            text: ' *',
                            style: textStyleForTextField.copyWith(color: red),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: () async {
                      File? pickedImage = await createServiceController
                          .selectImage();
                      if (pickedImage != null) {
                        createServiceController.headerLogo.value = pickedImage;
                      }
                    },
                    child: Container(
                      height: Get.height * 0.15,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: lightGrey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: lightGrey),
                      ),
                      child: createServiceController.headerLogo.value.path != ""
                          ? Image.file(
                              createServiceController.headerLogo.value,
                              fit: BoxFit.cover,
                            )
                          : createServiceController.headerLogoUrl != null
                          ? Image.network(
                              baseUrl +
                                  '/admin/' +
                                  createServiceController.headerLogoUrl!,
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.add_a_photo),
                    ),
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    value: createServiceController.logoVisible,
                    onChanged: (v) {
                      setState(() {
                        createServiceController.logoVisible = v!;
                      });
                    },
                    title: const Text("Show logo"),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: primaryColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5),
          Card(
            color: white,
            shadowColor: grey,
            elevation: 3,
            margin: EdgeInsets.only(bottom: 15),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Theme colors", style: textStyleForSubTitle),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      buildColorItem(
                        title: "Background",
                        color: createServiceController.hexToColor(
                          createServiceController.theme!.colors.bg,
                        ),
                        onColorChanged: (c) {
                          setState(() {
                            createServiceController.theme!.colors.bg =
                                colorToHex(c);
                          });
                        },
                        context: context,
                      ),

                      buildColorItem(
                        title: "Panel",
                        color: createServiceController.hexToColor(
                          createServiceController.theme!.colors.panel,
                        ),
                        onColorChanged: (c) {
                          setState(() {
                            createServiceController.theme!.colors.panel =
                                colorToHex(c);
                          });
                        },
                        context: context,
                      ),

                      buildColorItem(
                        title: "Text",
                        color: createServiceController.hexToColor(
                          createServiceController.theme!.colors.text,
                        ),
                        onColorChanged: (c) {
                          setState(() {
                            createServiceController.theme!.colors.text =
                                colorToHex(c);
                          });
                        },
                        context: context,
                      ),

                      buildColorItem(
                        title: "Muted",
                        color: createServiceController.hexToColor(
                          createServiceController.theme!.colors.muted,
                        ),
                        onColorChanged: (c) {
                          setState(() {
                            createServiceController.theme!.colors.muted =
                                colorToHex(c);
                          });
                        },
                        context: context,
                      ),

                      buildColorItem(
                        title: "Accent",
                        color: createServiceController.hexToColor(
                          createServiceController.theme!.colors.accent,
                        ),
                        onColorChanged: (c) {
                          setState(() {
                            createServiceController.theme!.colors.accent =
                                colorToHex(c);
                          });
                        },
                        context: context,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5),
          Card(
            color: white,
            shadowColor: grey,
            elevation: 3,
            margin: EdgeInsets.only(bottom: 15),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("End banner", style: textStyleForSubTitle),
                  const SizedBox(height: 10),
                  Text.rich(
                    style: textStyleForTextField,
                    TextSpan(
                      text: "Banner image",
                      children: [
                        TextSpan(
                          text: ' *',
                          style: textStyleForTextField.copyWith(color: red),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: () async {
                      File? pickedImage = await createServiceController
                          .selectImage();

                      if (pickedImage != null) {
                        createServiceController.bannerImage.value = pickedImage;
                      }
                    },
                    child: Container(
                      height: Get.height * 0.15,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: lightGrey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: lightGrey),
                      ),
                      child:
                          createServiceController.bannerImage.value.path != ""
                          ? Image.file(
                              createServiceController.bannerImage.value,
                              fit: BoxFit.cover,
                            )
                          : createServiceController.bannerImageUrl != null
                          ? Image.network(
                              baseUrl +
                                  '/admin/' +
                                  createServiceController.bannerImageUrl!,
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.add_a_photo),

                      // createServiceController.bannerImage.value.path == ''
                      // ? const Icon(Icons.add_a_photo)
                      // : Image.file(
                      //     createServiceController.bannerImage.value,
                      //     fit: BoxFit.cover,
                      //   ),
                    ),
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    value: createServiceController.bannerVisible,
                    onChanged: (v) {
                      setState(() {
                        createServiceController.bannerVisible = v!;
                      });
                    },
                    title: const Text("Show banner"),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  SizedBox(height: 15),
                  CustomTextField(
                    width: 0.9,
                    height: 0.06,
                    controller: createServiceController.bannerTextController,
                    title: "Banner alt text",
                    textColor: black,
                    titleStyle: textStyleForTextField,
                    fillColor: Colors.white,
                    textInputType: TextInputType.text,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text("Products", style: textStyleForTextField),
          const SizedBox(height: 6),
          buildProductsList(),
        ],
      ),
    );
  }
}
