import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgNetwork extends StatelessWidget {
  final double width;
  final double height;
  final String image;
  final VoidCallback? onTap;
  final Color? color;

  const CustomSvgNetwork({
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
        // ignore: deprecated_member_use
        child: SvgPicture.network(image, fit: BoxFit.contain, color: color),
      ),
    );
  }
}
