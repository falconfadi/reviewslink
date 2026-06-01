// class UpdateProfileBody {
//   String? name;
//   String? companyName;
//   String? mobile;
//   String? mobileCode;
//   int? gender;
//
//   UpdateProfileBody({
//     this.name,
//     this.companyName,
//     this.mobile,
//     this.mobileCode,
//     this.gender,
//   });
//
//   UpdateProfileBody.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     companyName = json['company_name'];
//     mobile = json['mobile'];
//     mobileCode = json['mobile_code'];
//     gender = json['gender'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['company_name'] = this.companyName;
//     data['mobile'] = this.mobile;
//     data['mobile_code'] = this.mobileCode;
//     data['gender'] = this.gender;
//     return data;
//   }
// }

import 'dart:io';
import 'package:dio/dio.dart';

class UpdateProfileBody {
  String? name;
  String? companyName;
  String? mobile;
  String? mobileCode;
  int? gender;
  File? image;
  int? defaultImage;

  UpdateProfileBody({
    this.name,
    this.companyName,
    this.mobile,
    this.mobileCode,
    this.gender,
    this.image,
    this.defaultImage
  });

  FormData toFormData() {
    final formData = FormData();

    formData.fields
      ..add(MapEntry('name', name ?? ''))
      ..add(MapEntry('company_name', companyName ?? ''))
      ..add(MapEntry('mobile', mobile ?? ''))
      ..add(MapEntry('mobile_code', mobileCode ?? ''))
      ..add(MapEntry('gender', gender?.toString() ?? ''));

    if (defaultImage != null) {
      formData.fields.add(
        MapEntry(
          'default_image',
          defaultImage.toString(),
        ),
      );
    }

    if (image != null) {
      formData.files.add(
        MapEntry('img', MultipartFile.fromFileSync(image!.path)),
      );
    }

    return formData;
  }
}
