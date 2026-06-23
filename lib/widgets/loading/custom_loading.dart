import 'package:flutter/material.dart';
import 'package:reviews_link_v2/res/color.dart';

class LoadingIndicator extends StatelessWidget {

  final double? width;
  final double? height;
  final Color? color;

  const LoadingIndicator({super.key,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width ?? null,
        height: height ?? null,
        child: CircularProgressIndicator(
          color: color ?? primaryColor,
        ),
      ),
    );
  }
}
