import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductModel {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController productId = TextEditingController();
  TextEditingController components = TextEditingController();
  Rx<File> image = File('').obs;
  String? imageUrl;
}
