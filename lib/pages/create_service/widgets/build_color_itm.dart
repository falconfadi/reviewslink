import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/res/styles.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';

Widget buildColorItem({
  required String title,
  required Color color,
  required Function(Color) onColorChanged,
  required BuildContext context,
}) {
  return GestureDetector(
    onTap: () async {
      // Color pickedColor = color;
      await showDialog(
        context: context,
        builder: (context) {
          Color tempColor = color;
          TextEditingController hexController = TextEditingController(
            text: colorToHex(color),
          );

          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("Pick $title color"),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ColorPicker(
                        pickerColor: tempColor,
                        onColorChanged: (c) {
                          setState(() {
                            tempColor = c;
                            hexController.text = colorToHex(c);
                          });
                        },
                        enableAlpha: false,
                        displayThumbColor: true,
                      ),

                      SizedBox(height: 15),

                      TextField(
                        controller: hexController,
                        decoration: InputDecoration(
                          labelText: "Hex Color (#ffffff)",
                          border: OutlineInputBorder(),
                        ),
                        // onSubmitted: (value) {
                        //   try {
                        //     final buffer = StringBuffer();
                        //     if (value.length == 7) buffer.write('ff');
                        //     buffer.write(value.replaceFirst('#', ''));
                        //     final newColor =  Color(int.parse(buffer.toString(), radix: 16));;
                        //     setState(() {
                        //       tempColor = newColor;
                        //     });
                        //   } catch (e) {
                        //
                        //   }
                        // },
                        onChanged: (value) {
                          try {
                            final buffer = StringBuffer();
                            if (value.length == 7) buffer.write('ff');
                            buffer.write(value.replaceFirst('#', ''));
                            final newColor = Color(
                              int.parse(buffer.toString(), radix: 16),
                            );
                            ;
                            setState(() {
                              tempColor = newColor;
                            });
                          } catch (e) {}
                        },
                      ),
                    ],
                  ),
                ),
                actions: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: CustomButton(
                        width: 0.5,
                        height: 0.05,
                        color: primaryColor,
                        title: 'Select',
                        onTap: () {
                          onColorChanged(tempColor);
                          Navigator.pop(context);
                        },
                        textStyle: textStyleForPrimaryButton,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      );
      // await showDialog(
      //   context: context,
      //   builder: (context) {
      //     return AlertDialog(
      //       title: Text("Pick $title color"),
      //       content: SingleChildScrollView(
      //         child: ColorPicker(
      //           pickerColor: color,
      //           onColorChanged: (c) {
      //             pickedColor = c;
      //           },
      //           enableAlpha: false,
      //           displayThumbColor: true,
      //         ),
      //       ),
      //       actions: [
      //         Center(
      //           child: Padding(
      //             padding: const EdgeInsets.only(bottom: 20),
      //             child: CustomButton(
      //                 width: 0.5,
      //                 height: 0.05,
      //                 color: primaryColor,
      //                 title: 'Select',
      //                 onTap: (){
      //                   onColorChanged(pickedColor);
      //                   Navigator.pop(context);
      //                 },
      //                 textStyle: textStyleForPrimaryButton),
      //           ),
      //         ),
      //       ],
      //     );
      //   },
      // );
    },
    child: Container(
      width: Get.width * 0.4,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: white,
        border: Border.all(color: lightGrey, width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Container(
            height: 20,
            width: double.infinity,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          SizedBox(height: 5),
          Text(title),
        ],
      ),
    ),
  );
}
