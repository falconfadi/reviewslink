import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';

class TabsWidget extends StatefulWidget {

  final int selectedTab;
  final ValueChanged<int> onTabChanged;

  TabsWidget({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  State<TabsWidget> createState() => _TabsWidgetState();
}

class _TabsWidgetState extends State<TabsWidget> {

  final InitController initController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 1.sw,
          height: 1.sh * 0.05,
          child: Center(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: initController.servicesTypeList.length,
              itemBuilder: (context, index) {
                final tab = initController.servicesTypeList[index];
                return InkWell(
                  onTap: () => widget.onTabChanged(index),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1,
                          color: widget.selectedTab == index
                              ? black : Colors.transparent,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          tab.name
                              .toString()
                              .replaceAll('_', ' ')
                              .capitalize1(),
                          style: AppTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

extension StringExtension on String {
  String capitalize1() {
    if (this.isEmpty) return this;
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
