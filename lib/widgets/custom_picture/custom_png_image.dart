import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPngImage extends StatelessWidget {

  final double width;
  final double height;
  final String image;

  const CustomPngImage({
    required this.width,
    required this.height,
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset(image, fit: BoxFit.contain),
    );
  }
}
