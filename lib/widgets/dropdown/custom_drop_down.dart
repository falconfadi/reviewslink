import 'package:flutter/material.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/res/styles.dart';
//
// class CustomDropDown extends StatelessWidget {
//   final double width;
//   final double height;
//   final String text;
//   final dynamic value;
//   final String? title;
//   final List<DropdownMenuItem<dynamic>>? items;
//   final void Function(dynamic)? onChanged;
//
//   const CustomDropDown({
//     super.key,
//     required this.width,
//     required this.height,
//     required this.text,
//     required this.value,
//     this.title,
//     required this.items,
//     required this.onChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         title == null
//             ? const SizedBox()
//             : Text(title ?? "", style: textStyleForTextField),
//         SizedBox(height: title == null ? 0 : 6),
//         Container(
//           width: width,
//           height: height,
//           decoration: BoxDecoration(
//             color: white,
//             borderRadius: BorderRadius.circular(5),
//             border: Border.all(color: grey, width: 0.5),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(5),
//             child: DropdownButton(
//               dropdownColor: white,
//               isExpanded: true,
//               hint: Text(text, style: textStyleForSmallBlackRegularText),
//               icon: const Icon(Icons.keyboard_arrow_down_outlined, size: 22),
//               iconEnabledColor: grey,
//               value: value,
//               items: items,
//               underline: Container(),
//               onChanged: onChanged,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class CustomDropDown<T> extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final T? value;
  final String? title;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final bool? required;
  final Color? dropdownColor;

  const CustomDropDown({
    super.key,
    required this.width,
    required this.height,
    required this.text,
    required this.value,
    this.title,
    required this.items,
    required this.onChanged,
    this.required,
    this.dropdownColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title == null ? const SizedBox()
        : Text.rich(
          TextSpan(
            text: title!,
            style: textStyleForTextField,
            children: [
              if (required == true)
                TextSpan(
                  text: ' *',
                  style: textStyleForTextField.copyWith(color: red),
                ),
            ],
          ),
        ),
            // : Text(title!, style: textStyleForTextField),
        SizedBox(height: title == null ? 0 : 6),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: dropdownColor ?? white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: grey, width: 0.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: DropdownButton<T>(
              dropdownColor: white,
              isExpanded: true,
              hint: Text(text, style: textStyleForSmallBlackRegularText),
              icon: const Icon(Icons.keyboard_arrow_down_outlined, size: 22),
              iconEnabledColor: grey,
              value: value,
              items: items,
              underline: const SizedBox(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
