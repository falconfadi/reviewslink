import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/button/custom_button.dart';

Widget buildColorItem ({

  required String title,
  required Color color,
  required Function(Color) onColorChanged,
  required BuildContext context,

}) {
  return GestureDetector(
    onTap: () async {
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
                title: Text("Pick $title color",style: AppTheme.bodyLarge),
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
                      SizedBox(height: 20.h),
                      TextField(
                        controller: hexController,
                        decoration: InputDecoration(
                          labelText: "Hex Color (#ffffff)",
                          border: OutlineInputBorder(),
                        ),
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
                      padding: EdgeInsets.only(bottom: 25.h),
                      child: CustomButton(
                        width: 0.5,
                        height: 0.05,
                        color: primaryColor,
                        title: 'Select',
                        onTap: () {
                          onColorChanged(tempColor);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      );
    },
    child: Container(
      width: 1.sw * 0.35,
      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
      decoration: BoxDecoration(
        color: white,
        border: Border.all(color: lightGrey, width: 2),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Container(
            height: 25.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(5.r),
            ),
          ),
          SizedBox(height: 10.h),
          Text(title,style: AppTheme.labelMedium),
        ],
      ),
    ),
  );
}
