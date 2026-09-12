import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/models/social_media_card_model.dart';
import 'package:reviews_link_v2/res/app_images.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:reviews_link_v2/widgets/check_box_list_tile/custom_check_box_list_tile.dart';
import 'package:reviews_link_v2/widgets/text_field/custom_text_field.dart';

class SocialMediaCardWidget extends StatefulWidget {

  final SocialMediaCardModel card;
  final VoidCallback? onRemove;

  SocialMediaCardWidget({
    super.key,
    required this.card,
    this.onRemove,
  });

  @override
  State<SocialMediaCardWidget> createState() => _SocialMediaCardWidgetState();
}

class _SocialMediaCardWidgetState extends State<SocialMediaCardWidget> {

  late final TextEditingController urlController;
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    urlController = TextEditingController(text: widget.card.url ?? '');
    titleController = TextEditingController(text: widget.card.title ?? '');
    descriptionController = TextEditingController(text: widget.card.description ?? '');
  }

  @override
  void dispose() {
    urlController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SocialMediaCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.card != widget.card) {
      urlController.text = widget.card.url ?? '';
      titleController.text = widget.card.title ?? '';
      descriptionController.text = widget.card.description ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: primaryColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.card.isFixed) ...[
            Row(
              children: [
                SizedBox(
                  width: 50.w,
                  height: 50.w,
                  child: Image.asset(
                    widget.card.icon!,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    widget.card.name!,
                    style: AppTheme.bodyLarge,
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.h),
          ],
          if (!widget.card.isFixed) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: widget.onRemove,
                  child: SvgPicture.asset(DELETE_ICON, width: 25.w),
                ),
              ],
            ),
          ],
          CustomTextField(
            controller: urlController,
            title: 'URL',
            required: widget.card.isFixed ? true : null,
            labelText: 'https://...',
            textInputType: TextInputType.url,
            onChanged: (value) {
              widget.card.url = value;
            },
          ),
          SizedBox(height: 20.h),
          CustomTextField(
            controller: titleController,
            title: 'Title',
            labelText: widget.card.isFixed
                ? null
                : 'Custom link title',
            textInputType: TextInputType.text,
            onChanged: (value) {
              widget.card.title = value;
            },
          ),
          SizedBox(height: 20.h),
          CustomTextField(
            controller: descriptionController,
            title: 'Description',
            labelText: 'Short description for this platform',
            textInputType: TextInputType.text,
            onChanged: (value) {
              widget.card.description = value;
            },
          ),
          SizedBox(height: 10),
          if (widget.card.isFixed)
            CustomCheckBoxListTile(
              value: widget.card.enabled,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                setState(() {
                  widget.card.enabled = value;
                });
              },
              title: 'Enable',
            ),
        ],
      ),
    );
  }
}