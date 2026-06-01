// class CreateServiceRestaurantBody {
//   String? serviceTypeId;
//   String? name;
//   String? pageTitle;
//   String? description;
//   String? showLogo;
//   String? bannerShow;
//   String? bannerAlt;
//   Theme? theme;
//   List<Products>? products;
//
//   CreateServiceRestaurantBody({
//     this.serviceTypeId,
//     this.name,
//     this.pageTitle,
//     this.description,
//     this.showLogo,
//     this.bannerShow,
//     this.bannerAlt,
//     this.theme,
//     this.products,
//   });
//
//   CreateServiceRestaurantBody.fromJson(Map<String, dynamic> json) {
//     serviceTypeId = json['service_type_id'];
//     name = json['name'];
//     pageTitle = json['page_title'];
//     description = json['description'];
//     showLogo = json['show_logo'];
//     bannerShow = json['banner_show'];
//     bannerAlt = json['banner_alt'];
//     theme = json['theme'] != null ? new Theme.fromJson(json['theme']) : null;
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
//     data['description'] = this.description;
//     data['show_logo'] = this.showLogo;
//     data['banner_show'] = this.bannerShow;
//     data['banner_alt'] = this.bannerAlt;
//     if (this.theme != null) {
//       data['theme'] = this.theme!.toJson();
//     }
//     if (this.products != null) {
//       data['products'] = this.products!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Theme {
//   Colors? colors;
//
//   Theme({this.colors});
//
//   Theme.fromJson(Map<String, dynamic> json) {
//     colors = json['colors'] != null
//         ? new Colors.fromJson(json['colors'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.colors != null) {
//       data['colors'] = this.colors!.toJson();
//     }
//     return data;
//   }
// }
//
// class Colors {
//   String? bg;
//   String? panel;
//   String? text;
//   String? muted;
//   String? accent;
//
//   Colors({this.bg, this.panel, this.text, this.muted, this.accent});
//
//   Colors.fromJson(Map<String, dynamic> json) {
//     bg = json['bg'];
//     panel = json['panel'];
//     text = json['text'];
//     muted = json['muted'];
//     accent = json['accent'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['bg'] = this.bg;
//     data['panel'] = this.panel;
//     data['text'] = this.text;
//     data['muted'] = this.muted;
//     data['accent'] = this.accent;
//     return data;
//   }
// }
//
// class Products {
//   String? name;
//   String? price;
//   String? des;
//
//   Products({this.name, this.price, this.des});
//
//   Products.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     price = json['price'];
//     des = json['des'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['price'] = this.price;
//     data['des'] = this.des;
//     return data;
//   }
// }

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
