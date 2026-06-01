import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgImage extends StatelessWidget {
  final double width;
  final double height;
  final String image;
  final VoidCallback? onTap;
  final Color? color;

  const CustomSvgImage({
    required this.width,
    required this.height,
    required this.image,
    this.onTap,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: SvgPicture.asset(image, fit: BoxFit.contain, color: color),
      ),
    );
  }
}
