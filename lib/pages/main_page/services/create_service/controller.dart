import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/data/constant/api_constant.dart';
import 'package:reviews_link_v2/data/models/body/service/create/create_service_list_of_products_body.dart';
import 'package:reviews_link_v2/data/models/body/service/create/create_service_restaurant_body.dart';
import 'package:reviews_link_v2/data/models/body/service/create/create_service_single_product_body.dart';
import 'package:reviews_link_v2/data/models/body/service/create/create_service_url_body.dart';
import 'package:reviews_link_v2/data/models/body/service/update/update_service_list_of_product_body.dart' as updateModel;
import 'package:reviews_link_v2/data/models/body/service/update/update_service_restaurant_body.dart' as updateModelRestaurant;
import 'package:reviews_link_v2/data/models/body/service/update/update_service_single_product_body.dart';
import 'package:reviews_link_v2/data/models/body/service/update/update_service_url_body.dart';
import 'package:reviews_link_v2/data/models/response/init/init_response.dart';
import 'package:reviews_link_v2/data/repository/service_repo.dart';
import 'package:reviews_link_v2/extensions/context_localization.dart';
import 'package:reviews_link_v2/pages/main_page/services/controller.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/models/product_model.dart';
import 'package:reviews_link_v2/data/models/response/service/service_response.dart' as serviceModelResponse;
import 'package:reviews_link_v2/widgets/snack_bar/top_snack_bar.dart';

class CreateServiceController extends getx.GetxController {

  InitController initController = getx.Get.find();
  ServiceController serviceController = getx.Get.find();
  ServiceRepo serviceRepo = ServiceRepo();

  TextEditingController pageTitleController = TextEditingController();
  TextEditingController nameUrlController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController bannerTextController = TextEditingController();
  final allowedTypes = [
    "url", "restaurant_menu",
    "product", "list_of_products",
  ];
  final RxList<ProductModel> products = <ProductModel>[ProductModel()].obs;
  ProductModel singleProduct = ProductModel();
  List<File> productsImage = [];
  List<String> currencies = ["USD", "\$"];
  getx.RxBool multiCurrency = false.obs;
  getx.Rxn<Currencies> selectedCurrency = getx.Rxn<Currencies>();
  getx.Rx<File> logo = File('').obs;
  String? logoUrl;
  getx.Rx<File> headerLogo = File('').obs;
  String? headerLogoUrl;
  getx.Rx<File> bannerImage = File('').obs;
  String? bannerImageUrl;
  ServiceType? selectedType;
  getx.RxBool loading = false.obs;
  bool bannerVisible = false;
  bool logoVisible = false;
  bool? editStatus;
  serviceModelResponse.ServiceResponse? chosenServiceToEdit;
  ThemeColorModel? theme;

  @override
  void onInit() {
    theme = ThemeColorModel(
      colors: ThemeColors(
        bg: "#fffdf7",
        panel: "#ffffff",
        text: "#111827",
        muted: "#6b7280",
        accent: "#f97316",
      ),
    );
    editStatus = getx.Get.arguments[0];
    if (editStatus == true) {
      print('@@@@@@@@@@@');
      chosenServiceToEdit = getx.Get.arguments[1];
      selectedType = chosenServiceToEdit?.serviceType.toInitModel();
      if (selectedType!.id == 1) {
        fillRestaurantMenuFields();
      } else if (selectedType!.id == 2) {
        fillUrlFields();
      } else if (selectedType!.id == 3) {
        fillSingleProductFields();
      } else if (selectedType!.id == 4) {
        fillListOfProductsFields();
      }
      print('@@@@@@@@@@@');
    }
    super.onInit();
  }

  /// for Edit
  fillRestaurantMenuFields() {
    pageTitleController.text = (chosenServiceToEdit!.jsonData as
    serviceModelResponse.RestaurantMenuData).pageTitle;

    descriptionController.text = (chosenServiceToEdit!.jsonData as
    serviceModelResponse.RestaurantMenuData).description;

    headerLogoUrl = (chosenServiceToEdit!.jsonData as
    serviceModelResponse.RestaurantMenuData).header.logo;

    logoVisible = (chosenServiceToEdit!.jsonData as
    serviceModelResponse.RestaurantMenuData).header.showLogo == 1;

    theme!.colors.bg = (chosenServiceToEdit!.jsonData as
    serviceModelResponse.RestaurantMenuData).theme.colors.bg;

    theme!.colors.panel = (chosenServiceToEdit!.jsonData as
    serviceModelResponse.RestaurantMenuData).theme.colors.panel;

    theme!.colors.text = (chosenServiceToEdit!.jsonData as
    serviceModelResponse.RestaurantMenuData).theme.colors.text;

    theme!.colors.muted = (chosenServiceToEdit!.jsonData as
    serviceModelResponse.RestaurantMenuData).theme.colors.muted;

    theme!.colors.accent = (chosenServiceToEdit!.jsonData as
    serviceModelResponse.RestaurantMenuData).theme.colors.accent;

    bannerImageUrl = (chosenServiceToEdit!.jsonData as
    serviceModelResponse.RestaurantMenuData).banner.image;

    bannerVisible = (chosenServiceToEdit!.jsonData as
    serviceModelResponse.RestaurantMenuData).banner.show == 1;

    bannerTextController.text = (chosenServiceToEdit!.jsonData as
    serviceModelResponse.RestaurantMenuData).banner.alt;

    products.clear();
    products.value = (chosenServiceToEdit!.jsonData as
    serviceModelResponse.RestaurantMenuData).products.map
    <ProductModel>((item) {
          final product = ProductModel();
          product.title.text = item.name;
          product.description.text = item.description;
          product.price.text = item.price;
          product.imageUrl = item.image;
          return product;
        }).toList();
  }
  fillSingleProductFields() {
    String currencyId = (chosenServiceToEdit!.jsonData as
    serviceModelResponse.SingleProductData).currencyId.toString();

    selectedCurrency.value = initController.currencyList.firstWhere(
      (currency) => currency.id == currencyId,
      orElse: () => Currencies(),
    );
    multiCurrency.value = (chosenServiceToEdit!.jsonData as
    serviceModelResponse.SingleProductData).multiCurrency;

    singleProduct.productId.text = (chosenServiceToEdit!.jsonData as
    serviceModelResponse.SingleProductData).supermarket.first.productId;

    singleProduct.title.text = (chosenServiceToEdit!.jsonData as
    serviceModelResponse.SingleProductData).supermarket.first.name;

    singleProduct.description.text =
        (chosenServiceToEdit!.jsonData as
        serviceModelResponse.SingleProductData).supermarket.first.description;

    singleProduct.price.text = (chosenServiceToEdit!.jsonData as
        serviceModelResponse.SingleProductData).supermarket.first.price;

    singleProduct.imageUrl =
        (chosenServiceToEdit!.jsonData as
        serviceModelResponse.SingleProductData).supermarket.first.image;
  }
  fillListOfProductsFields() {
    pageTitleController.text =
        (chosenServiceToEdit!.jsonData
        as serviceModelResponse.ListOfProductsData)
            .pageTitle;
    logoUrl =
        (chosenServiceToEdit!.jsonData
        as serviceModelResponse.ListOfProductsData)
            .logo;

    products.value =
        (chosenServiceToEdit!.jsonData
        as serviceModelResponse.ListOfProductsData)
            .products
            .map<ProductModel>((item) {
          final product = ProductModel();
          product.title.text = item.title;
          product.description.text = item.description;
          product.price.text = item.price;
          product.imageUrl = item.image;
          return product;
        })
            .toList();
    print('___________');
    print(logoUrl);
    print(products.first.imageUrl);
    print(products.last.imageUrl);
    print('___________');
  }
  fillUrlFields() {
    urlController.text = (chosenServiceToEdit!.jsonData as
        serviceModelResponse.UrlServiceData).url;

    titleController.text = (chosenServiceToEdit!.jsonData as
        serviceModelResponse.UrlServiceData).title;
  }

  void addProduct() {
    products.add(ProductModel());
    update();
  }

  void removeProduct(int index) {
    products.removeAt(index);
    update();
  }

  Color hexToColor(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String formatText(String text) {
    return text.replaceAll('_', ' ').split(' ').map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  Future<File?> selectImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    if (pickedFile != null) {
      print(pickedFile.path);
      return File(pickedFile.path);
    }
    return null;
  }

  choseSaveOption(BuildContext context) async {
    if (selectedType!.name == 'url') {
      await createServiceURL(context);
    } else if (selectedType!.name == 'product') {
      await createServiceSingleProduct(context);
    } else if (selectedType!.name == "list_of_products") {
      await createServiceListOfProducts(context);
    } else if (selectedType!.name == "restaurant_menu") {
      await createServiceRestaurant(context);
    }
  }

  Future<void> createServiceURL(BuildContext context) async {
    Constant.closeKeyBoard();
    if (!loading.value) {
      if (urlController.text.isNotEmpty) {
        loading.value = true;
        await serviceRepo.createServiceUrl(
          CreateServiceUrlBody(
            title: titleController.text,
            name: nameUrlController.text,
            serviceTypeId: selectedType!.id.toString(),
            url: urlController.text,
          ),
        ).then((value) {
          if (value.code == 201) {
            loading.value = false;
            titleController.clear();
            urlController.clear();
            nameUrlController.clear();
            serviceController.allServices.insert(0,
              serviceModelResponse.ServiceResponse.fromJson(
                value.body['service'],
              ),
            );
            TopSnackBar.success(context, value.message);
          }
        });
      } else {
        loading.value = false;
        TopSnackBar.warning(context, context.localizations.empty_field);
      }
    }
  }

  Future<void> createServiceSingleProduct(BuildContext context) async {
    Constant.closeKeyBoard();
    if (!loading.value) {
      if (isSingleProductValid()) {
        loading.value = true;
        await serviceRepo.createServiceSingleProduct(
          CreateServiceSingleProductBody(
            serviceTypeId: selectedType!.id.toString(),
            name: singleProduct.title.text,
            description: singleProduct.description.text,
            productId: singleProduct.productId.text,
            currencyId: selectedCurrency.value!.id,
            multiCurrency: multiCurrency.toString(),
            price: singleProduct.price.text,
            productName: singleProduct.title.text,
            file: singleProduct.image.value,
          ),
        ).then((value) {
          if (value.code == 201) {
            loading.value = false;
            clearSingleProduct();
            serviceController.allServices.insert(0,
              serviceModelResponse.ServiceResponse.fromJson(
                value.body['service'],
              ),
            );
            TopSnackBar.success(context, value.message);
          }
        });
      } else {
        loading.value = false;
        TopSnackBar.warning(context, context.localizations.empty_field);
      }
    }
  }

  bool isSingleProductValid() {
    return selectedType?.id != null &&
        (singleProduct.title.text.trim().isNotEmpty) &&
        selectedCurrency.value!.id != null &&
        (singleProduct.price.text.trim().isNotEmpty) &&
        (singleProduct.image.value.path.isNotEmpty);
  }

  void clearSingleProduct() {
    selectedCurrency.value = null;
    multiCurrency.value = false;
    singleProduct.title.clear();
    singleProduct.description.clear();
    singleProduct.productId.clear();
    singleProduct.price.clear();
    singleProduct.image.value = File('');
  }

  void fillProductImages() {
    productsImage.clear();

    for (var product in products) {
      if (product.image.value.path.isNotEmpty) {
        productsImage.add(product.image.value);
      }
    }
  }

  void clearData() {
    products.clear();
    productsImage.clear();
    descriptionController.clear();
    headerLogo.value = File('');
    logoVisible = false;
    bannerTextController.clear();
    bannerVisible = false;
    bannerImage.value = File('');
    products.add(ProductModel());
    pageTitleController.clear();
    logo.value = File('');
  }

  Future<void> createServiceListOfProducts(BuildContext context) async {
    Constant.closeKeyBoard();
    if (!loading.value) {
      if (isListOfProductsValid()) {
        fillProductImages();
        print("Number of product images: ${productsImage.length}");
        loading.value = true;
        try {
          final body = CreateServiceListOfProductsBody(
            serviceTypeId: selectedType!.id.toString(),
            name: pageTitleController.text.trim(),
            pageTitle: pageTitleController.text.trim(),
            products: products.map((p) => productModelToRequest(p)).toList(),
            productImages: productsImage,
            logo: logo.value,
          );
          FormData formData = await body.toFormData();
          Dio dio = Dio();
          final response = await dio.post(
            baseUrl + CREATE_SERVICES,
            data: formData,
            options: Options(
              headers: {
                'Authorization': 'Bearer ${initController.userData!.token}',
                'Content-Type': 'multipart/form-data',
              },
            ),
          );
          if (response.statusCode == 201) {
            clearData();
            serviceController.allServices.insert(0,
              serviceModelResponse.ServiceResponse.fromJson(
                response.data['body']['service'],
              ),
            );
            TopSnackBar.success(
              context,
              response.data['message'] ?? "Service created successfully",
            );
          } else {
            TopSnackBar.warning(context, "Failed: ${response.data}");
          }
        } catch (e) {
          print("Error creating service: $e");
          TopSnackBar.warning(context, "Something went wrong");
        } finally {
          loading.value = false;
        }
      } else {
        loading.value = false;
        TopSnackBar.warning(context, context.localizations.empty_field);
      }
    }
  }

  bool isListOfProductsValid() {
    if (pageTitleController.text.toString().trim().isEmpty) return false;
    if (logo.value.path.isEmpty) return false;
    if (products.isEmpty) return false;
    for (var product in products) {
      if (product.title.toString().trim().isEmpty) return false;
      if (product.price.toString().trim().isEmpty) return false;
      if (product.image.value.path == "") return false;
    }
    return true;
  }

  ProductRequestModel productModelToRequest(ProductModel product) {
    return ProductRequestModel(
      title: product.title.text.trim(),
      description: product.description.text.trim(),
      price: product.price.text.trim(),
    );
  }

  Future<void> createServiceRestaurant(BuildContext context) async {
    Constant.closeKeyBoard();
    if (!loading.value) {
      if (isRestaurantValuesValid()) {
        fillProductImages();
        print("Number of product images: ${productsImage.length}");
        loading.value = true;
        try {
          final body = CreateServiceRestaurantBody(
            serviceTypeId: selectedType!.id.toString(),
            pageTitle: pageTitleController.text.trim(),
            description: descriptionController.text.trim(),
            headerLogo: headerLogo.value,
            showLogo: logoVisible,
            theme: theme,
            bannerImage: bannerImage.value,
            bannerShow: bannerVisible,
            bannerAlt: bannerTextController.text.trim(),
            products: products
                .map((p) => productModelRestaurantToRequest(p))
                .toList(),
            productImages: productsImage,
          );
          FormData formData = await body.toFormData();
          Dio dio = Dio();
          final response = await dio.post(
            baseUrl + CREATE_SERVICES,
            data: formData,
            options: Options(
              headers: {
                'Authorization': 'Bearer ${initController.userData!.token}',
                'Content-Type': 'multipart/form-data',
              },
            ),
          );

          if (response.statusCode == 201 || response.statusCode == 200) {
            clearData();
            serviceController.allServices.insert(0,
              serviceModelResponse.ServiceResponse.fromJson(
                response.data['body']['service'],
              ),
            );
            TopSnackBar.success(
              context,
              response.data['message'] ?? "Service created successfully",
            );
          } else {
            TopSnackBar.warning(context, "Failed: ${response.data}");
          }
        } catch (e) {
          print("Error creating service: $e");
          TopSnackBar.warning(context, "Something went wrong");
        } finally {
          loading.value = false;
        }
      } else {
        loading.value = false;
        TopSnackBar.warning(context, context.localizations.empty_field);
      }
    }
  }

  bool isRestaurantValuesValid() {
    if (pageTitleController.text.toString().trim().isEmpty) return false;
    if (headerLogo.value.path == '') return false;
    if (bannerImage.value.path == '') return false;
    for (var product in products) {
      if (product.title.toString().trim().isEmpty) return false;
      if (product.price.toString().trim().isEmpty) return false;
      if (product.image.value.path == "") return false;
    }
    return true;
  }

  ProductResRequestModel productModelRestaurantToRequest(ProductModel product) {
    return ProductResRequestModel(
      title: product.title.text.trim(),
      description: product.description.text.trim(),
      price: product.price.text.trim(),
    );
  }

  choseUpdateOption(BuildContext context) async {
    if (selectedType!.name == 'url') {
      await updateServiceURL(context);
    } else if (selectedType!.name == 'product') {
      await updateServiceSingleProduct(context);
    } else if (selectedType!.name == "list_of_products") {
      await updateServiceListOfProducts(context);
    } else if (selectedType!.name == "restaurant_menu") {
      await updateServiceRestaurant(context);
    }
  }

  Future<void> updateServiceURL(BuildContext context) async {
    Constant.closeKeyBoard();
    if (!loading.value) {
      if (urlController.text.isNotEmpty) {
        loading.value = true;
        await serviceRepo.updateServiceUrl(
          UpdateServiceUrlBody(
            title: titleController.text,
            name: nameUrlController.text,
            serviceId: chosenServiceToEdit!.id.toString(),
            url: urlController.text,
          ),
        ).then((value) async {
          if (value.code == 200) {
            await serviceController.getServicesList();
            loading.value = false;
            getx.Get.back();
            TopSnackBar.success(context, value.message);
          }
        });
      } else {
        loading.value = false;
        TopSnackBar.warning(context, context.localizations.empty_field);
      }
    }
  }

  Future<void> updateServiceSingleProduct(BuildContext context) async {
    Constant.closeKeyBoard();
    if (!loading.value) {
      if (isSingleProductValidUpdate()) {
        loading.value = true;
        await serviceRepo.updateServiceSingleProduct(
          UpdateServiceSingleProductBody(
            serviceId: chosenServiceToEdit!.id.toString(),
            name: singleProduct.title.text,
            description: singleProduct.description.text,
            productId: singleProduct.productId.text,
            currencyId: selectedCurrency.value!.id,
            multiCurrency: multiCurrency.toString(),
            price: singleProduct.price.text,
            productName: singleProduct.title.text,
            file: singleProduct.image.value.path == ''
                ? null
                : singleProduct.image.value,
          ),
        ).then((value) async {
          if (value.code == 200) {
            await serviceController.getServicesList();
            loading.value = false;
            getx.Get.back();
            TopSnackBar.success(context, value.message);
          }
        });
      } else {
        loading.value = false;
        TopSnackBar.warning(context, context.localizations.empty_field);
      }
    }
  }

  bool isSingleProductValidUpdate() {
    return selectedType?.id != null &&
        (singleProduct.title.text.trim().isNotEmpty) &&
        selectedCurrency.value!.id != null &&
        (singleProduct.price.text.trim().isNotEmpty) &&
        (singleProduct.image.value.path.isNotEmpty ||
            singleProduct.imageUrl != null);
  }

  Future<File> urlToFile(String imageUrl) async {
    Dio dio = Dio();

    String extension = imageUrl.split('.').last.split('?').first;

    final tempDir = Directory.systemTemp;
    final filePath =
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.$extension';
    await dio.download(
      baseUrl + '/admin/' + imageUrl,
      filePath,
      options: Options(
        responseType: ResponseType.bytes,
        headers: {'Authorization': 'Bearer ${initController.userData!.token}'},
      ),
    );
    return File(filePath);
  }

  Future fillProductImagesUpdate() async {
    productsImage.clear();
    print(products.length);
    for (var product in products) {
      if (product.image.value.path.isNotEmpty) {
        productsImage.add(product.image.value);
      } else {
        File file = await urlToFile(product.imageUrl!);
        productsImage.add(file);
      }
    }
  }

  Future<void> updateServiceListOfProducts(BuildContext context) async {
    Constant.closeKeyBoard();
    if (!loading.value) {
      loading.value = true;
      await fillProductImagesUpdate();
      await fillLogo();
      if (isListOfProductsValidUpdate() == '') {
        print("Number of product images: ${productsImage.length}");

        try {
          final body = updateModel.UpdateServiceListOfProductsBody(
            serviceId: chosenServiceToEdit!.id.toString(),
            name: pageTitleController.text.trim(),
            pageTitle: pageTitleController.text.trim(),
            products: products
                .map((p) => productModelToRequestUpdate(p))
                .toList(),
            productImages: productsImage,
            logo: logo.value.path == '' ? null : logo.value,
          );
          FormData formData = await body.toFormData();
          Dio dio = Dio();
          final response = await dio.post(
            baseUrl + UPDATE_SERVICE,
            data: formData,
            options: Options(
              headers: {
                'Authorization': 'Bearer ${initController.userData!.token}',
                'Content-Type': 'multipart/form-data',
              },
            ),
          );

          if (response.statusCode == 200) {
            await serviceController.getServicesList();
            getx.Get.back();
            TopSnackBar.success(
              context,
              response.data['message'] ?? "Service created successfully",
            );
          } else {
            TopSnackBar.warning(context, "Failed: ${response.data}");
          }
        } catch (e) {
          print("Error creating service: $e");
          TopSnackBar.warning(context, "Something went wrong");
        } finally {
          loading.value = false;
        }
      } else {
        loading.value = false;
        TopSnackBar.warning(context, context.localizations.empty_field);
      }
    }
  }

  String isListOfProductsValidUpdate() {
    if (pageTitleController.text.toString().trim().isEmpty) return 'title';
    if (logo.value.path.isEmpty && logoUrl == null) return 'logo';
    if (products.isEmpty) return 'products';
    for (var product in products) {
      if (product.title.toString().trim().isEmpty) return 'title products';
      if (product.price.toString().trim().isEmpty) return 'price';
      if (product.image.value.path == "" && product.imageUrl == null)
        return 'image';
    }
    return '';
  }

  Future fillLogo() async {
    File file = await urlToFile(logoUrl!);
    logo.value = file;
  }

  updateModel.ProductRequestModel productModelToRequestUpdate(
      ProductModel product,
      ) {
    return updateModel.ProductRequestModel(
      title: product.title.text.trim(),
      description: product.description.text.trim(),
      price: product.price.text.trim(),
    );
  }

  Future<void> updateServiceRestaurant(BuildContext context) async {
    Constant.closeKeyBoard();
    if (!loading.value) {
      loading.value = true;
      await fillProductImagesUpdate();
      await fillImages();
      if (isRestaurantValuesValidUpdate()) {
        print("Number of product images: ${productsImage.length}");
        try {
          final body = updateModelRestaurant.UpdateServiceRestaurantBody(
            serviceId: chosenServiceToEdit!.id.toString(),
            pageTitle: pageTitleController.text.trim(),
            description: descriptionController.text.trim(),
            headerLogo: headerLogo.value,
            showLogo: logoVisible,
            theme: mapTheme(theme),
            bannerImage: bannerImage.value,
            bannerShow: bannerVisible,
            bannerAlt: bannerTextController.text.trim(),
            products: products
                .map((p) => productModelRestaurantToRequestUpdate(p))
                .toList(),
            productImages: productsImage,
          );
          FormData formData = await body.toFormData();
          Dio dio = Dio();
          final response = await dio.post(
            baseUrl + UPDATE_SERVICE,
            data: formData,
            options: Options(
              headers: {
                'Authorization': 'Bearer ${initController.userData!.token}',
                'Content-Type': 'multipart/form-data',
              },
            ),
          );

          if (response.statusCode == 200) {
            await serviceController.getServicesList();
            getx.Get.back();
            TopSnackBar.success(
              context,
              response.data['message'] ?? "Service created successfully",
            );
            TopSnackBar.success(
              context,
              response.data['message'] ?? "Service created successfully",
            );
          } else {
            TopSnackBar.warning(context, "Failed: ${response.data}");
          }
        } catch (e) {
          print("Error creating service: $e");
          TopSnackBar.warning(context, "Something went wrong");
        } finally {
          loading.value = false;
        }
      } else {
        loading.value = false;
        TopSnackBar.warning(context, context.localizations.empty_field);
      }
    }
  }

  Future fillImages() async {
    File file1 = await urlToFile(headerLogoUrl!);
    headerLogo.value = file1;

    File file2 = await urlToFile(bannerImageUrl!);
    bannerImage.value = file2;
  }

  bool isRestaurantValuesValidUpdate() {
    if (pageTitleController.text.toString().trim().isEmpty) return false;
    if (headerLogo.value.path == '' && headerLogoUrl == null) return false;
    if (bannerImage.value.path == '' && bannerImageUrl == null) return false;
    for (var product in products) {
      if (product.title.toString().trim().isEmpty) return false;
      if (product.price.toString().trim().isEmpty) return false;
      if (product.image.value.path == "" && product.imageUrl == null)
        return false;
    }

    return true;
  }

  updateModelRestaurant.ProductResRequestModel productModelRestaurantToRequestUpdate(ProductModel product) {
    return updateModelRestaurant.ProductResRequestModel(
      title: product.title.text.trim(),
      description: product.description.text.trim(),
      price: product.price.text.trim(),
    );
  }

  updateModelRestaurant.ThemeColorModel? mapTheme(ThemeColorModel? theme) {
    if (theme == null) return null;

    return updateModelRestaurant.ThemeColorModel(
      colors: updateModelRestaurant.ThemeColors(
        bg: theme.colors.bg,
        panel: theme.colors.panel,
        text: theme.colors.text,
        muted: theme.colors.muted,
        accent: theme.colors.accent,
      ),
    );
  }

}

extension ServiceTypeMapper on serviceModelResponse.ServiceType {
  ServiceType toInitModel() {
    return ServiceType(
      id: id,
      name: name,
      tableName: tableName,
      dataType: dataType,
    );
  }
}
