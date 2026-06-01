import 'package:flutter/material.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/res/styles.dart';

class SupportFooterWidget extends StatelessWidget {
  final String text;
  final String link;
  final VoidCallback? linkTap;

  const SupportFooterWidget({
    required this.text,
    required this.link,
    this.linkTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: textStyleForTinyGrayRegularText),
        SizedBox(width: 5),
        InkWell(
          onTap: linkTap,
          child: Text(
            link,
            style: textStyleForSmallGraySemiBoldText.copyWith(
              fontWeight: FontWeight.w500,
              color: primaryColor,
              decoration: TextDecoration.underline,
              decorationColor: primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
