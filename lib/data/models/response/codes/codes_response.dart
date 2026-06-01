import 'package:reviews_link_v2/pages/services/models/service_model.dart';

class CodesResponse {
  final int id;
  final String code;
  final int userId;
  final int serviceId;
  final int? categoryId;
  final Category? category;
  final int scans;
  final String claimDate;
  final int downloaded;
  final String? dateOfDownload;
  final int adminId;
  final String creationDate;
  final ServiceModel service;

  CodesResponse({
    required this.id,
    required this.code,
    required this.userId,
    required this.serviceId,
    this.categoryId,
    this.category,
    required this.scans,
    required this.claimDate,
    required this.downloaded,
    this.dateOfDownload,
    required this.adminId,
    required this.creationDate,
    required this.service,
  });

  factory CodesResponse.fromJson(Map<String, dynamic> json) {
    return CodesResponse(
      id: json['id'] ?? 0,
      code: json['code'] ?? '',
      userId: json['user_id'] ?? 0,
      serviceId: json['service_id'] ?? 0,
      categoryId: json['category_id'],
      category: json['category'] != null
          ? Category.fromJson(json['category'])
          : null,
      scans: json['scans'] ?? 0,
      claimDate: json['claim_date'] ?? '',
      downloaded: json['downloaded'] ?? 0,
      dateOfDownload: json['date_of_download'],
      adminId: json['admin_id'] ?? 0,
      creationDate: json['creation_date'] ?? '',
      service: ServiceModel.fromJson(json['service'] ?? {}),
    );
  }
}

class Category {
  final int? id;
  final String? name;
  final String? icon;

  Category({this.id, this.name, this.icon});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'], name: json['name'], icon: json['icon']);
  }
}
