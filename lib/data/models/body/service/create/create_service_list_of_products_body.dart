import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class CreateServiceListOfProductsBody {
  String? serviceTypeId;
  String? name;
  String? pageTitle;

  List<ProductRequestModel> products;
  List<File> productImages;

  File? logo;

  CreateServiceListOfProductsBody({
    this.serviceTypeId,
    this.name,
    this.pageTitle,
    required this.products,
    required this.productImages,
    this.logo,
  });

  Future<FormData> toFormData() async {
    final formData = FormData();

    formData.fields.addAll([
      MapEntry('service_type_id', serviceTypeId ?? ''),
      MapEntry('name', name ?? ''),
      MapEntry('page_title', pageTitle ?? ''),
    ]);

    final productsJson = jsonEncode(products.map((e) => e.toJson()).toList());

    formData.fields.add(MapEntry('products', productsJson));

    if (logo != null) {
      formData.files.add(
        MapEntry('logo', await MultipartFile.fromFile(logo!.path)),
      );
    }

    for (var image in productImages) {
      formData.files.add(
        MapEntry('product_images[]', await MultipartFile.fromFile(image.path)),
      );
    }

    return formData;
  }
}

class ProductRequestModel {
  String? title;
  String? description;
  String? price;

  ProductRequestModel({this.title, this.description, this.price});

  Map<String, dynamic> toJson() {
    return {"title": title, "description": description, "price": price};
  }
}
