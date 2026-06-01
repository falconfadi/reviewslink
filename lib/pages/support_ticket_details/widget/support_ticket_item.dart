import 'package:flutter/material.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/res/styles.dart';

class SupportTicketItem extends StatelessWidget {

  final String title;
  final String subTitle;

  SupportTicketItem({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$title:", style: textStyleForMediumBlackRegularText.copyWith(
          color: primaryColor
        )),
        SizedBox(width: 5),
        Expanded(
          child: Text(subTitle, style: textStyleForSmallBlackRegularText),
        ),
      ],
    );
  }
}
