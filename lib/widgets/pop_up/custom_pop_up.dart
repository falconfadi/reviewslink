import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/res/color.dart';

class CustomPopUp extends StatelessWidget {

  final bool open;
  final VoidCallback outSideOnTap;
  final Widget child;

  const CustomPopUp({
    required this.open,
    required this.outSideOnTap,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: open
          ? ClipRRect(
              key: const ValueKey(1),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: GestureDetector(
                  onTap: outSideOnTap,
                  child: Container(
                    width: Get.width,
                    height: Get.height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                        colors: [
                          black.withAlpha(130),
                          black.withAlpha(100),
                        ],
                      ),
                    ),
                    child: Center(child: child),
                  ),
                ),
              ),
            )
          : const SizedBox(key: ValueKey(2)),
    );
  }
}
