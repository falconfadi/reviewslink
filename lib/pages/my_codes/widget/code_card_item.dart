import 'package:flutter/material.dart';
import 'package:reviews_link_v2/res/styles.dart';

class CodeCardItem extends StatelessWidget {
  final String title;
  final String subTitle;

  CodeCardItem({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$title:", style: textStyleForMediumWhiteRegularText),
        SizedBox(width: 5),
        Expanded(
          child: Text(subTitle, style: textStyleForSmallWhiteRegularText),
        ),
      ],
    );
  }
}
