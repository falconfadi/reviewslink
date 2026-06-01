import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPngImage extends StatelessWidget {
  final double width;
  final double height;
  final String image;
  final VoidCallback? onTap;
  final double? radius;

  const CustomPngImage({
    required this.width,
    required this.height,
    required this.image,
    this.radius,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        // ignore: deprecated_member_use
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius ?? 0),
          child: Image.asset(image, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
