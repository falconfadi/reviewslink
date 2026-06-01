// class ServiceModel {
//   final int id;
//   final String name;
//   final dynamic jsonData;
//   final int serviceTypeId;
//   final int userId;
//   final String creationDate;
//   final ServiceType serviceType;
//
//   ServiceModel({
//     required this.id,
//     required this.name,
//     required this.jsonData,
//     required this.serviceTypeId,
//     required this.userId,
//     required this.creationDate,
//     required this.serviceType,
//   });
//
//   factory ServiceModel.fromJson(Map<String, dynamic> json) {
//     final type = ServiceType.fromJson(json['service_type'] ?? {});
//     dynamic parsedJson;
//
//     switch (type.name) {
//       case "restaurant_menu":
//         parsedJson = RestaurantMenuData.fromJson(json['json_data'] ?? {});
//         break;
//       case "list_of_products":
//         parsedJson = ListOfProductsData.fromJson(json['json_data'] ?? {});
//         break;
//       case "product":
//         parsedJson = SingleProductData.fromJson(json['json_data'] ?? {});
//         break;
//       case "url":
//         parsedJson = UrlServiceData.fromJson(json['json_data'] ?? {});
//         break;
//       default:
//         parsedJson = json['json_data'];
//     }
//
//     return ServiceModel(
//       id: json['id'] ?? 0,
//       name: json['name'] ?? '',
//       jsonData: parsedJson,
//       serviceTypeId: json['service_type_id'] ?? 0,
//       userId: json['user_id'] ?? 0,
//       creationDate: json['creation_date'] ?? '',
//       serviceType: type,
//     );
//   }
// }
//
// class ServiceType {
//   final int id;
//   final String name;
//   final String dataType;
//   final String? tableName;
//
//   ServiceType({
//     required this.id,
//     required this.name,
//     required this.dataType,
//     this.tableName,
//   });
//
//   factory ServiceType.fromJson(Map<String, dynamic> json) {
//     return ServiceType(
//       id: json['id'] ?? 0,
//       name: json['name'] ?? '',
//       dataType: json['data_type'] ?? '',
//       tableName: json['table_name'],
//     );
//   }
// }

/// ------------------------------ start

class ServiceModel {
  final int id;
  final String name;
  final dynamic jsonData;
  final int serviceTypeId;
  final int userId;
  final String creationDate;
  final ServiceType serviceType;
  final List<ServiceCode> codes;

  ServiceModel({
    required this.id,
    required this.name,
    required this.jsonData,
    required this.serviceTypeId,
    required this.userId,
    required this.creationDate,
    required this.serviceType,
    required this.codes,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    final type = ServiceType.fromJson(json['service_type'] ?? {});
    dynamic parsedJson;

    switch (type.name) {
      case "restaurant_menu":
        parsedJson = RestaurantMenuData.fromJson(json['json_data'] ?? {});
        break;
      case "list_of_products":
        parsedJson = ListOfProductsData.fromJson(json['json_data'] ?? {});
        break;
      case "product":
        parsedJson = SingleProductData.fromJson(json['json_data'] ?? {});
        break;
      case "url":
        parsedJson = UrlServiceData.fromJson(json['json_data'] ?? {});
        break;
      default:
        parsedJson = json['json_data'];
    }

    return ServiceModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      jsonData: parsedJson,
      serviceTypeId: json['service_type_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      creationDate: json['creation_date'] ?? '',
      serviceType: type,
      codes: (json['codes'] as List? ?? [])
          .map((e) => ServiceCode.fromJson(e))
          .toList(),
    );
  }
}

class ServiceType {
  final int id;
  final String name;
  final String dataType;
  final String? tableName;

  ServiceType({
    required this.id,
    required this.name,
    required this.dataType,
    this.tableName,
  });

  factory ServiceType.fromJson(Map<String, dynamic> json) {
    return ServiceType(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      dataType: json['data_type'] ?? '',
      tableName: json['table_name'],
    );
  }
}

/// ------------------------------ end
class ServiceCode {
  final int id;
  final String code;
  final int userId;
  final int serviceId;
  final int categoryId;
  final CodeCategory category;
  final int scans;
  final String claimDate;
  final int downloaded;
  final String? dateOfDownload;
  final int adminId;
  final String creationDate;

  ServiceCode({
    required this.id,
    required this.code,
    required this.userId,
    required this.serviceId,
    required this.categoryId,
    required this.category,
    required this.scans,
    required this.claimDate,
    required this.downloaded,
    this.dateOfDownload,
    required this.adminId,
    required this.creationDate,
  });

  factory ServiceCode.fromJson(Map<String, dynamic> json) {
    return ServiceCode(
      id: json['id'] ?? 0,
      code: json['code'] ?? '',
      userId: json['user_id'] ?? 0,
      serviceId: json['service_id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      category: CodeCategory.fromJson(json['category'] ?? {}),
      scans: json['scans'] ?? 0,
      claimDate: json['claim_date'] ?? '',
      downloaded: json['downloaded'] ?? 0,
      dateOfDownload: json['date_of_download'],
      adminId: json['admin_id'] ?? 0,
      creationDate: json['creation_date'] ?? '',
    );
  }
}

class CodeCategory {
  final int id;
  final String name;
  final String icon;

  CodeCategory({required this.id, required this.name, required this.icon});

  factory CodeCategory.fromJson(Map<String, dynamic> json) {
    return CodeCategory(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
    );
  }
}

class RestaurantMenuData {
  final String pageTitle;
  final String description;
  final Header header;
  final ThemeColors theme;
  final BannerModel banner;
  final List<MenuProduct> products;

  RestaurantMenuData({
    required this.pageTitle,
    required this.description,
    required this.header,
    required this.theme,
    required this.banner,
    required this.products,
  });

  factory RestaurantMenuData.fromJson(Map<String, dynamic> json) {
    return RestaurantMenuData(
      pageTitle: json['page_title'] ?? '',
      description: json['description'] ?? '',
      header: Header.fromJson(json['header'] ?? {}),
      theme: ThemeColors.fromJson(json['theme'] ?? {}),
      banner: BannerModel.fromJson(json['banner'] ?? {}),
      products: (json['products'] as List? ?? [])
          .map((e) => MenuProduct.fromJson(e))
          .toList(),
    );
  }
}

class MenuProduct {
  final String name;
  final String price;
  final String description;
  final String? image;

  MenuProduct({
    required this.name,
    required this.price,
    required this.description,
    this.image,
  });

  factory MenuProduct.fromJson(Map<String, dynamic> json) {
    return MenuProduct(
      name: json['name'] ?? '',
      price: json['price'] ?? '',
      description: json['des'] ?? '',
      image: json['image'],
    );
  }
}

class Header {
  final String? logo;
  final int showLogo;

  Header({this.logo, required this.showLogo});

  factory Header.fromJson(Map<String, dynamic> json) {
    return Header(logo: json['logo'], showLogo: json['show_logo'] ?? 0);
  }
}

class ThemeColors {
  final ColorSet colors;

  ThemeColors({required this.colors});

  factory ThemeColors.fromJson(Map<String, dynamic> json) {
    return ThemeColors(colors: ColorSet.fromJson(json['colors'] ?? {}));
  }
}

class ColorSet {
  final String bg;
  final String panel;
  final String text;
  final String muted;
  final String accent;

  ColorSet({
    required this.bg,
    required this.panel,
    required this.text,
    required this.muted,
    required this.accent,
  });

  factory ColorSet.fromJson(Map<String, dynamic> json) {
    return ColorSet(
      bg: json['bg'] ?? '',
      panel: json['panel'] ?? '',
      text: json['text'] ?? '',
      muted: json['muted'] ?? '',
      accent: json['accent'] ?? '',
    );
  }
}

class BannerModel {
  final String? image;
  final String alt;
  final int show;

  BannerModel({this.image, required this.alt, required this.show});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      image: json['image'],
      alt: json['alt'] ?? '',
      show: json['show'] ?? 0,
    );
  }
}

class ListOfProductsData {
  final String pageTitle;
  final String? logo;
  final List<ListProduct> products;

  ListOfProductsData({
    required this.pageTitle,
    this.logo,
    required this.products,
  });

  factory ListOfProductsData.fromJson(Map<String, dynamic> json) {
    return ListOfProductsData(
      pageTitle: json['page_title'] ?? '',
      logo: json['logo'],
      products: (json['products'] as List? ?? [])
          .map((e) => ListProduct.fromJson(e))
          .toList(),
    );
  }
}

class ListProduct {
  final String title;
  final String description;
  final String price;
  final String? image;

  ListProduct({
    required this.title,
    required this.description,
    required this.price,
    this.image,
  });

  factory ListProduct.fromJson(Map<String, dynamic> json) {
    return ListProduct(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? '',
      image: json['image'],
    );
  }
}

class SingleProductData {
  final int currencyId;
  final bool multiCurrency;
  final List<SupermarketProduct> supermarket;

  SingleProductData({
    required this.currencyId,
    required this.multiCurrency,
    required this.supermarket,
  });

  factory SingleProductData.fromJson(Map<String, dynamic> json) {
    return SingleProductData(
      currencyId: json['currency_id'] ?? 0,
      multiCurrency: json['multi_currency'] ?? false,
      supermarket: (json['supermarket'] as List? ?? [])
          .map((e) => SupermarketProduct.fromJson(e))
          .toList(),
    );
  }
}

class SupermarketProduct {
  final String name;
  final String description;
  final String productId;
  final String price;
  final String? image;

  SupermarketProduct({
    required this.name,
    required this.description,
    required this.productId,
    required this.price,
    this.image,
  });

  factory SupermarketProduct.fromJson(Map<String, dynamic> json) {
    return SupermarketProduct(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      productId: json['product_id'] ?? '',
      price: json['price'] ?? '',
      image: json['image'],
    );
  }
}

class UrlServiceData {
  final String url;
  final String title;

  UrlServiceData({required this.url, required this.title});

  factory UrlServiceData.fromJson(Map<String, dynamic> json) {
    return UrlServiceData(url: json['url'] ?? '', title: json['title'] ?? '');
  }
}
