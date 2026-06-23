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
