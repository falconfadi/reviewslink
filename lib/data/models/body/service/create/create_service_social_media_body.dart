import 'dart:io';
import 'package:dio/dio.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/models/social_media_card_model.dart';

class CreateServiceSocialMediaBody {

  String? serviceTypeId;
  String? displayName;
  String? bio;
  bool? verified;
  bool? showQuickIcons;
  File? avatar;
  File? background;
  List<SocialMediaCardModel>? socialMediaCards;

  CreateServiceSocialMediaBody({
    this.serviceTypeId,
    this.displayName,
    this.bio,
    this.verified,
    this.showQuickIcons,
    this.avatar,
    this.background,
    this.socialMediaCards,
  });

  Future<FormData> toFormData() async {

    final formData = FormData();

    formData.fields.addAll([
      MapEntry('service_type_id', serviceTypeId ?? ''),
      MapEntry('sm_display_name', displayName ?? ''),
      MapEntry('sm_bio', bio ?? ''),
      MapEntry('sm_verified', (verified ?? false) ? '1' : '0'),
      MapEntry('sm_show_quick_icons',(showQuickIcons ?? false) ? '1' : '0'),
    ]);

    if (avatar != null && avatar!.path.isNotEmpty && await avatar!.exists()) {
      formData.files.add(
        MapEntry(
          'sm_avatar',
          await MultipartFile.fromFile(avatar!.path),
        ),
      );
    }

    if (background != null && background!.path.isNotEmpty && await background!.exists()) {
      formData.files.add(
        MapEntry(
          'sm_background',
          await MultipartFile.fromFile(background!.path),
        ),
      );
    }

    for (final card in socialMediaCards ?? []) {
      if (card.isFixed) {
        if (card.name == null || card.name!.trim().isEmpty) {
          continue;
        }

        final key = card.name!.trim().toLowerCase();

        formData.fields.add(
          MapEntry(
            'sm_enabled[$key]',
            card.enabled ? key : '0',
          ),
        );

        formData.fields.add(
          MapEntry(
            'sm_url[$key]',
            card.url?.trim() ?? '',
          ),
        );

        formData.fields.add(
          MapEntry(
            'sm_title[$key]',
            card.title?.trim() ?? '',
          ),
        );

        formData.fields.add(
          MapEntry(
            'sm_description[$key]',
            card.description?.trim() ?? '',
          ),
        );
      } else {
        final key = card.title?.trim().toLowerCase() ?? '';

        if (key.isEmpty) {
          continue;
        }

        formData.fields.add(
          MapEntry(
            'sm_custom_url[]',
            card.url?.trim() ?? '',
          ),
        );

        formData.fields.add(
          MapEntry(
            'sm_custom_title[]',
            card.title?.trim() ?? '',
          ),
        );

        formData.fields.add(
          MapEntry(
            'sm_custom_description[]',
            card.description?.trim() ?? '',
          ),
        );
      }
    }

    return formData;
  }
}

