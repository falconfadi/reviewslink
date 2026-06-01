//
//
// class CreateServiceListOfProductsBody {
//   String? serviceTypeId;
//   String? name;
//   String? pageTitle;
//   List<Products>? products;
//
//   CreateServiceListOfProductsBody(
//       {this.serviceTypeId, this.name, this.pageTitle, this.products});
//
//   CreateServiceListOfProductsBody.fromJson(Map<String, dynamic> json) {
//     serviceTypeId = json['service_type_id'];
//     name = json['name'];
//     pageTitle = json['page_title'];
//     if (json['products'] != null) {
//       products = <Products>[];
//       json['products'].forEach((v) {
//         products!.add(new Products.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['service_type_id'] = this.serviceTypeId;
//     data['name'] = this.name;
//     data['page_title'] = this.pageTitle;
//     if (this.products != null) {
//       data['products'] = this.products!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Products {
//   String? title;
//   String? description;
//   String? price;
//
//   Products({this.title, this.description, this.price});
//
//   Products.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     description = json['description'];
//     price = json['price'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['title'] = this.title;
//     data['description'] = this.description;
//     data['price'] = this.price;
//     return data;
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class UpdateServiceListOfProductsBody {
  String? serviceId;
  String? name;
  String? pageTitle;

  List<ProductRequestModel> products;
  List<File> productImages;

  File? logo;

  UpdateServiceListOfProductsBody({
    this.serviceId,
    this.name,
    this.pageTitle,
    required this.products,
    required this.productImages,
    this.logo,
  });

  Future<FormData> toFormData() async {
    final formData = FormData();

    formData.fields.addAll([
      MapEntry('service_id', serviceId ?? ''),
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
