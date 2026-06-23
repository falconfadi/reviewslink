import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgImage extends StatelessWidget {

  final double width;
  final double height;
  final String image;
  final Color? color;

  const CustomSvgImage({
    required this.width,
    required this.height,
    required this.image,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: SvgPicture.asset(image, fit: BoxFit.contain, color: color),
    );
  }
}
