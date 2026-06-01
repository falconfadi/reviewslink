// class ServicesResponse {
//   User? user;
//   Pagination? pagination;
//   List<ServiceModel>? services;
//
//   ServicesResponse({this.user, this.pagination, this.services});
//
//   ServicesResponse.fromJson(Map<String, dynamic> json) {
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     pagination = json['pagination'] != null
//         ? new Pagination.fromJson(json['pagination'])
//         : null;
//     if (json['services'] != null) {
//       services = <ServiceModel>[];
//       json['services'].forEach((v) {
//         services!.add(new ServiceModel.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     if (this.pagination != null) {
//       data['pagination'] = this.pagination!.toJson();
//     }
//     // if (this.services != null) {
//     //   data['services'] = this.services!.map((v) => v.toJson()).toList();
//     // }
//     return data;
//   }
// }
//
// class User {
//   int? id;
//   String? name;
//   String? email;
//   String? mobile;
//   String? mobileCode;
//   Null? companyName;
//   int? status;
//   String? creationDate;
//
//   User({
//     this.id,
//     this.name,
//     this.email,
//     this.mobile,
//     this.mobileCode,
//     this.companyName,
//     this.status,
//     this.creationDate,
//   });
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     mobile = json['mobile'];
//     mobileCode = json['mobile_code'];
//     companyName = json['company_name'];
//     status = json['status'];
//     creationDate = json['creation_date'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['mobile'] = this.mobile;
//     data['mobile_code'] = this.mobileCode;
//     data['company_name'] = this.companyName;
//     data['status'] = this.status;
//     data['creation_date'] = this.creationDate;
//     return data;
//   }
// }
//
// class Pagination {
//   int? page;
//   int? perPage;
//   int? totalServices;
//   int? totalPages;
//   bool? hasNextPage;
//   bool? hasPrevPage;
//
//   Pagination({
//     this.page,
//     this.perPage,
//     this.totalServices,
//     this.totalPages,
//     this.hasNextPage,
//     this.hasPrevPage,
//   });
//
//   Pagination.fromJson(Map<String, dynamic> json) {
//     page = json['page'];
//     perPage = json['per_page'];
//     totalServices = json['total_services'];
//     totalPages = json['total_pages'];
//     hasNextPage = json['has_next_page'];
//     hasPrevPage = json['has_prev_page'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['page'] = this.page;
//     data['per_page'] = this.perPage;
//     data['total_services'] = this.totalServices;
//     data['total_pages'] = this.totalPages;
//     data['has_next_page'] = this.hasNextPage;
//     data['has_prev_page'] = this.hasPrevPage;
//     return data;
//   }
// }
//
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
//     final type = ServiceType.fromJson(json['service_type']);
//     dynamic parsedJson;
//     switch (type.name) {
//       case "restaurant_menu":
//         parsedJson = RestaurantMenuData.fromJson(json['json_data']);
//         break;
//       case "list_of_products":
//         parsedJson = ListOfProductsData.fromJson(json['json_data']);
//         break;
//       case "product":
//         parsedJson = SingleProductData.fromJson(json['json_data']);
//         break;
//       case "url":
//         parsedJson = UrlServiceData.fromJson(json['json_data']);
//         break;
//       default:
//         parsedJson = json['json_data'];
//     }
//
//     return ServiceModel(
//       id: json['id'],
//       name: json['name'],
//       jsonData: parsedJson,
//       serviceTypeId: json['service_type_id'],
//       userId: json['user_id'],
//       creationDate: json['creation_date'],
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
//       id: json['id'],
//       name: json['name'],
//       dataType: json['data_type'],
//       tableName: json['table_name'],
//     );
//   }
// }
//
// class RestaurantMenuData {
//   final String pageTitle;
//   final String description;
//   final Header header;
//   final ThemeColors theme;
//   final BannerModel banner;
//   final List<MenuProduct> products;
//
//   RestaurantMenuData({
//     required this.pageTitle,
//     required this.description,
//     required this.header,
//     required this.theme,
//     required this.banner,
//     required this.products,
//   });
//
//   factory RestaurantMenuData.fromJson(Map<String, dynamic> json) {
//     return RestaurantMenuData(
//       pageTitle: json['page_title'],
//       description: json['description'],
//       header: Header.fromJson(json['header']),
//       theme: ThemeColors.fromJson(json['theme']),
//       banner: BannerModel.fromJson(json['banner']),
//       products: (json['products'] as List)
//           .map((e) => MenuProduct.fromJson(e))
//           .toList(),
//     );
//   }
// }
//
// class MenuProduct {
//   final String name;
//   final String price;
//   final String description;
//   final String image;
//
//   MenuProduct({
//     required this.name,
//     required this.price,
//     required this.description,
//     required this.image,
//   });
//
//   factory MenuProduct.fromJson(Map<String, dynamic> json) {
//     return MenuProduct(
//       name: json['name'],
//       price: json['price'],
//       description: json['des'],
//       image: json['image'],
//     );
//   }
// }
//
// class Header {
//   final String logo;
//   final int showLogo;
//
//   Header({required this.logo, required this.showLogo});
//
//   factory Header.fromJson(Map<String, dynamic> json) {
//     return Header(logo: json['logo'], showLogo: json['show_logo']);
//   }
// }
//
// class ThemeColors {
//   final ColorSet colors;
//
//   ThemeColors({required this.colors});
//
//   factory ThemeColors.fromJson(Map<String, dynamic> json) {
//     return ThemeColors(colors: ColorSet.fromJson(json['colors']));
//   }
// }
//
// class ColorSet {
//   final String bg;
//   final String panel;
//   final String text;
//   final String muted;
//   final String accent;
//
//   ColorSet({
//     required this.bg,
//     required this.panel,
//     required this.text,
//     required this.muted,
//     required this.accent,
//   });
//
//   factory ColorSet.fromJson(Map<String, dynamic> json) {
//     return ColorSet(
//       bg: json['bg'],
//       panel: json['panel'],
//       text: json['text'],
//       muted: json['muted'],
//       accent: json['accent'],
//     );
//   }
// }
//
// class BannerModel {
//   final String image;
//   final String alt;
//   final int show;
//
//   BannerModel({required this.image, required this.alt, required this.show});
//
//   factory BannerModel.fromJson(Map<String, dynamic> json) {
//     return BannerModel(
//       image: json['image'],
//       alt: json['alt'],
//       show: json['show'],
//     );
//   }
// }
//
// class ListOfProductsData {
//   final String pageTitle;
//   final String logo;
//   final List<ListProduct> products;
//
//   ListOfProductsData({
//     required this.pageTitle,
//     required this.logo,
//     required this.products,
//   });
//
//   factory ListOfProductsData.fromJson(Map<String, dynamic> json) {
//     return ListOfProductsData(
//       pageTitle: json['page_title'],
//       logo: json['logo'],
//       products: (json['products'] as List)
//           .map((e) => ListProduct.fromJson(e))
//           .toList(),
//     );
//   }
// }
//
// class ListProduct {
//   final String title;
//   final String description;
//   final String price;
//   final String image;
//
//   ListProduct({
//     required this.title,
//     required this.description,
//     required this.price,
//     required this.image,
//   });
//
//   factory ListProduct.fromJson(Map<String, dynamic> json) {
//     return ListProduct(
//       title: json['title'],
//       description: json['description'],
//       price: json['price'],
//       image: json['image'],
//     );
//   }
// }
//
// class SingleProductData {
//   final int currencyId;
//   final bool multiCurrency;
//   final List<SupermarketProduct> supermarket;
//
//   SingleProductData({
//     required this.currencyId,
//     required this.multiCurrency,
//     required this.supermarket,
//   });
//
//   factory SingleProductData.fromJson(Map<String, dynamic> json) {
//     return SingleProductData(
//       currencyId: json['currency_id'],
//       multiCurrency: json['multi_currency'],
//       supermarket: (json['supermarket'] as List)
//           .map((e) => SupermarketProduct.fromJson(e))
//           .toList(),
//     );
//   }
// }
//
// class SupermarketProduct {
//   final String name;
//   final String description;
//   final String productId;
//   final String price;
//   final String image;
//
//   SupermarketProduct({
//     required this.name,
//     required this.description,
//     required this.productId,
//     required this.price,
//     required this.image,
//   });
//
//   factory SupermarketProduct.fromJson(Map<String, dynamic> json) {
//     return SupermarketProduct(
//       name: json['name'],
//       description: json['description'],
//       productId: json['product_id'],
//       price: json['price'],
//       image: json['image'],
//     );
//   }
// }
//
// class UrlServiceData {
//   final String url;
//   final String title;
//
//   UrlServiceData({required this.url, required this.title});
//
//   factory UrlServiceData.fromJson(Map<String, dynamic> json) {
//     return UrlServiceData(url: json['url'], title: json['title']);
//   }
// }
