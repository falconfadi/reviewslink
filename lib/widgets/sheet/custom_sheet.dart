import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:reviews_link_v2/res/Keys.dart';
import 'package:reviews_link_v2/res/color.dart';

class CustomSheet<T> extends StatelessWidget {

  final Widget child;
  final Widget header;
  final Widget? action;
  final bool? isDismissible;
  final bool? addHeader;
  final double? padding;

  const CustomSheet._({super.key,
    required this.child,
    required this.header,
    this.action,
    this.isDismissible,
    this.addHeader = true,
    this.padding
  });


  static Future<T?> show<T>({
    required BuildContext? context,
    required Widget child,
    required Widget header,
    Widget? action,
    bool addHeader = true,
    double? padding,
    ValueChanged<BuildContext>? onClose,
    Color? closeButtonColor,
    TextStyle? headerStyle,
    double? topTitle,
    bool isDismissible = true,
  }) => showModalBottomSheet<T>(
    context: context ?? Keys.navigatorKey.currentContext!,
    enableDrag: true,
    isDismissible: isDismissible,
    isScrollControlled: true,
    barrierColor: grey.withOpacity(0.30),
    backgroundColor: white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(50))),
    builder: (_) => CustomSheet._(
      header: header,
      action: action,
      addHeader: addHeader,
      padding: padding,
      child: child,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Container(
        decoration: BoxDecoration(
            color: white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(50))
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding == null ? 0 : padding!),
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                addHeader == false ? const Center() :
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(onTap: () => Navigator.pop(context) ,child: Icon(Icons.arrow_back_outlined,color: black,size: 25)),
                      header,
                      action ?? SizedBox(width: 25,height: 25)
                    ],
                  )
                ),
                Flexible(
                  child: SingleChildScrollView(child: child),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget? closeWidget() => null;
}
