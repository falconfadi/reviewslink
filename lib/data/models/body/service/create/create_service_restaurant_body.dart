import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class CreateServiceRestaurantBody {
  String? serviceTypeId;
  String? name;
  String? pageTitle;
  String? description;

  bool? showLogo;
  bool? bannerShow;
  String? bannerAlt;

  ThemeColorModel? theme;

  List<ProductResRequestModel> products;
  List<File> productImages;

  File? headerLogo;
  File? bannerImage;

  CreateServiceRestaurantBody({
    this.serviceTypeId,
    this.name,
    this.pageTitle,
    this.description,
    this.showLogo,
    this.bannerShow,
    this.bannerAlt,
    this.theme,
    required this.products,
    required this.productImages,
    this.headerLogo,
    this.bannerImage,
  });

  Future<FormData> toFormData() async {
    final formData = FormData();

    formData.fields.addAll([
      MapEntry('service_type_id', serviceTypeId ?? ''),
      MapEntry('name', name ?? ''),
      MapEntry('page_title', pageTitle ?? ''),
      MapEntry('description', description ?? ''),
      MapEntry('show_logo', (showLogo ?? false) ? '1' : '0'),
      MapEntry('banner_show', (bannerShow ?? false) ? '1' : '0'),
      MapEntry('banner_alt', bannerAlt ?? ''),
    ]);

    if (theme != null) {
      formData.fields.add(MapEntry('theme', jsonEncode(theme!.toJson())));
    }

    final productsJson = jsonEncode(products.map((e) => e.toJson()).toList());

    formData.fields.add(MapEntry('products', productsJson));

    if (headerLogo != null) {
      formData.files.add(
        MapEntry('header_logo', await MultipartFile.fromFile(headerLogo!.path)),
      );
    }

    if (bannerImage != null) {
      formData.files.add(
        MapEntry(
          'banner_image',
          await MultipartFile.fromFile(bannerImage!.path),
        ),
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

class ProductResRequestModel {
  String? title;
  String? description;
  String? price;

  ProductResRequestModel({this.title, this.description, this.price});

  Map<String, dynamic> toJson() {
    return {"name": title, "des": description, "price": price};
  }
}

class ThemeColorModel {
  ThemeColors colors;

  ThemeColorModel({required this.colors});

  Map<String, dynamic> toJson() {
    return {"colors": colors.toJson()};
  }
}

class ThemeColors {
  String bg;
  String panel;
  String text;
  String muted;
  String accent;

  ThemeColors({
    required this.bg,
    required this.panel,
    required this.text,
    required this.muted,
    required this.accent,
  });

  Map<String, dynamic> toJson() {
    return {
      "bg": bg,
      "panel": panel,
      "text": text,
      "muted": muted,
      "accent": accent,
    };
  }
}
