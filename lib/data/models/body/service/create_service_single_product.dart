// class CreateServiceSingleProduct {
//   String? serviceTypeId;
//   String? name;
//   String? productName;
//   String? description;
//   String? productId;
//   String? price;
//   String? currencyId;
//   String? multiCurrency;
//
//   CreateServiceSingleProduct(
//       {this.serviceTypeId,
//         this.name,
//         this.productName,
//         this.description,
//         this.productId,
//         this.price,
//         this.currencyId,
//         this.multiCurrency});
//
//   CreateServiceSingleProduct.fromJson(Map<String, dynamic> json) {
//     serviceTypeId = json['service_type_id'];
//     name = json['name'];
//     productName = json['product_name'];
//     description = json['description'];
//     productId = json['product_id'];
//     price = json['price'];
//     currencyId = json['currency_id'];
//     multiCurrency = json['multi_currency'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['service_type_id'] = this.serviceTypeId;
//     data['name'] = this.name;
//     data['product_name'] = this.productName;
//     data['description'] = this.description;
//     data['product_id'] = this.productId;
//     data['price'] = this.price;
//     data['currency_id'] = this.currencyId;
//     data['multi_currency'] = this.multiCurrency;
//     return data;
//   }
// }

import 'dart:io';

import 'package:dio/dio.dart';

class CreateServiceSingleProductBody {
  String? serviceTypeId;
  String? name;
  String? productName;
  String? description;
  String? productId;
  String? price;
  String? currencyId;
  String? multiCurrency;
  File? file;

  CreateServiceSingleProductBody({
    this.serviceTypeId,
    this.name,
    this.productName,
    this.description,
    this.productId,
    this.price,
    this.currencyId,
    this.multiCurrency,
    this.file,
  });

  FormData toFormData() {
    final formData = FormData();

    formData.fields
      ..add(MapEntry('service_type_id', serviceTypeId ?? ''))
      ..add(MapEntry('name', name ?? ''))
      ..add(MapEntry('product_name', productName ?? ''))
      ..add(MapEntry('description', description ?? ''))
      ..add(MapEntry('product_id', productId ?? ''))
      ..add(MapEntry('price', price ?? ''))
      ..add(MapEntry('currency_id', currencyId ?? ''))
      ..add(MapEntry('multi_currency', multiCurrency ?? ''));
    if (file != null) {
      formData.files.add(
        MapEntry('image', MultipartFile.fromFileSync(file!.path)),
      );
    }
    return formData;
  }
}
