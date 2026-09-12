
class ServiceResponse {
  final int id;
  final String name;
  final dynamic jsonData;
  final int serviceTypeId;
  final int userId;
  final String creationDate;
  final ServiceType serviceType;
  final List<ServiceCode> codes;
  final List<ServiceReview> reviews;
  final int reviewsCount;

  ServiceResponse({
    required this.id,
    required this.name,
    required this.jsonData,
    required this.serviceTypeId,
    required this.userId,
    required this.creationDate,
    required this.serviceType,
    required this.codes,
    required this.reviews,
    required this.reviewsCount,
  });

  factory ServiceResponse.fromJson(Map<String, dynamic> json) {
    final type = ServiceType.fromJson(json['service_type'] ?? {});
    dynamic parsedJson;

    switch (type.name) {
      case "rating_form":
        parsedJson = RatingFormServiceData.fromJson(json['json_data'] ?? {});
        break;
      case "url":
        parsedJson = UrlServiceData.fromJson(json['json_data'] ?? {});
        break;
      case "social_media_cards_unlimited" || "social_media_cards_4" || "social_media_cards_8":
        parsedJson = SocialMediaServiceData.fromJson(json['json_data'] ?? {});
        break;
      default:
        parsedJson = json['json_data'];
    }

    return ServiceResponse(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      jsonData: parsedJson,
      serviceTypeId: json['service_type_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      creationDate: json['creation_date'] ?? '',
      serviceType: type,
      codes: (json['codes'] as List? ?? [])
          .map((e) => ServiceCode.fromJson(e))
          .toList(),
      reviews: (json['reviews'] as List? ?? [])
          .map((e) => ServiceReview.fromJson(e))
          .toList(),
      reviewsCount: json['reviews_count'] ?? 0,

    );
  }
}

class ServiceType {
  final int id;
  final String name;
  final String dataType;
  final String? tableName;

  ServiceType({
    required this.id,
    required this.name,
    required this.dataType,
    this.tableName,
  });

  factory ServiceType.fromJson(Map<String, dynamic> json) {
    return ServiceType(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      dataType: json['data_type'] ?? '',
      tableName: json['table_name'],
    );
  }
}

class ServiceCode {
  final int id;
  final String code;
  final int userId;
  final int serviceId;
  final int categoryId;
  final CodeCategory category;
  final int scans;
  final String claimDate;
  final int downloaded;
  final String? dateOfDownload;
  final int adminId;
  final String creationDate;

  ServiceCode({
    required this.id,
    required this.code,
    required this.userId,
    required this.serviceId,
    required this.categoryId,
    required this.category,
    required this.scans,
    required this.claimDate,
    required this.downloaded,
    this.dateOfDownload,
    required this.adminId,
    required this.creationDate,
  });

  factory ServiceCode.fromJson(Map<String, dynamic> json) {
    return ServiceCode(
      id: json['id'] ?? 0,
      code: json['code'] ?? '',
      userId: json['user_id'] ?? 0,
      serviceId: json['service_id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      category: CodeCategory.fromJson(json['category'] ?? {}),
      scans: json['scans'] ?? 0,
      claimDate: json['claim_date'] ?? '',
      downloaded: json['downloaded'] ?? 0,
      dateOfDownload: json['date_of_download'],
      adminId: json['admin_id'] ?? 0,
      creationDate: json['creation_date'] ?? '',
    );
  }
}

class ServiceReview {
  final int id;
  final int serviceId;
  final int rating;
  final String comment;
  final String createdAt;
  final String feedbackType;

  ServiceReview({
    required this.id,
    required this.serviceId,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.feedbackType,
  });

  factory ServiceReview.fromJson(Map<String, dynamic> json) {
    return ServiceReview(
      id: json['id'] ?? 0,
      serviceId: json['service_id'] ?? 0,
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      createdAt: json['created_at'] ?? '',
      feedbackType: json['feedback_type'] ?? '',
    );
  }
}

class CodeCategory {
  final int id;
  final String name;
  final String icon;

  CodeCategory({required this.id, required this.name, required this.icon});

  factory CodeCategory.fromJson(Map<String, dynamic> json) {
    return CodeCategory(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
    );
  }
}

class RatingFormServiceData {
  final String formTitle;
  final String formDescription;
  final bool allowComments;
  final int maxStars;
  final String providerImage;

  RatingFormServiceData({
    required this.formTitle,
    required this.formDescription,
    required this.allowComments,
    required this.maxStars,
    required this.providerImage,
  });

  factory RatingFormServiceData.fromJson(Map<String, dynamic> json) {
    return RatingFormServiceData(
        formTitle: json['form_title'] ?? '',
        formDescription: json['form_description'] ?? '',
        allowComments: json['allow_comments'] ?? '',
        maxStars: json['max_stars'] ?? '',
        providerImage: json['provider_image'] ?? '',

    );
  }
}

class UrlServiceData {

  final String url;
  final String title;

  UrlServiceData({required this.url, required this.title});

  factory UrlServiceData.fromJson(Map<String, dynamic> json) {
    return UrlServiceData(url: json['url'] ?? '', title: json['title'] ?? '');
  }
}

class SocialMediaServiceData {

  final SocialMediaProfileModel? profile;
  final SocialMediaSettingsModel? settings;
  final List<SocialMediaCardModel>? cards;
  final List<QuickIconModel>? quickIcons;

  SocialMediaServiceData({
    this.profile,
    this.settings,
    this.cards,
    this.quickIcons,
  });

  factory SocialMediaServiceData.fromJson(Map<String, dynamic> json) {
    return SocialMediaServiceData(
      profile: json['profile'] != null ? SocialMediaProfileModel.fromJson(json['profile']) : null,
      settings: json['settings'] != null ? SocialMediaSettingsModel.fromJson(json['settings']) : null,
      cards: json['cards'] != null ? List<SocialMediaCardModel>.from(json['cards'].map((x) =>
          SocialMediaCardModel.fromJson(x))) : null,
      quickIcons: json['quick_icons'] != null ? List<QuickIconModel>.from(json['quick_icons'].map((x) =>
          QuickIconModel.fromJson(x))) : null,
    );
  }
}

class SocialMediaProfileModel {

  final String? displayName;
  final String? handle;
  final String? bio;
  final String? avatar;
  final String? background;
  final String? bsAvatar;
  final bool? verified;

  SocialMediaProfileModel({
    this.displayName,
    this.handle,
    this.bio,
    this.avatar,
    this.background,
    this.bsAvatar,
    this.verified,
  });

  factory SocialMediaProfileModel.fromJson(Map<String, dynamic> json) {
    return SocialMediaProfileModel(
      displayName: json['display_name'],
      handle: json['handle'],
      bio: json['bio'],
      avatar: json['avatar'],
      background: json['background'],
      bsAvatar: json['bs_avatar'],
      verified: json['verified'],
    );
  }
}

class SocialMediaSettingsModel {

  final String? type;
  final int? maxCards;
  final bool? searchEnabled;
  final bool? showCopyButton;
  final bool? showQuickIcons;

  SocialMediaSettingsModel({
    this.type,
    this.maxCards,
    this.searchEnabled,
    this.showCopyButton,
    this.showQuickIcons,
  });

  factory SocialMediaSettingsModel.fromJson(Map<String, dynamic> json) {
    return SocialMediaSettingsModel(
      type: json['type'],
      maxCards: json['max_cards'],
      searchEnabled: json['search_enabled'],
      showCopyButton: json['show_copy_button'],
      showQuickIcons: json['show_quick_icons'],
    );
  }
}

class SocialMediaCardModel {

  final String? platform;
  final String? category;
  final String? icon;
  final String? title;
  final String? handle;
  final String? description;
  final String? url;
  final String? buttonText;

  SocialMediaCardModel({
    this.platform,
    this.category,
    this.icon,
    this.title,
    this.handle,
    this.description,
    this.url,
    this.buttonText,
  });

  factory SocialMediaCardModel.fromJson(Map<String, dynamic> json) {
    return SocialMediaCardModel(
      platform: json['platform'],
      category: json['category'],
      icon: json['icon'],
      title: json['title'],
      handle: json['handle'],
      description: json['description'],
      url: json['url'],
      buttonText: json['button_text'],
    );
  }
}

class QuickIconModel {

  final String? platform;
  final String? icon;
  final String? url;

  QuickIconModel({
    this.platform,
    this.icon,
    this.url,
  });

  factory QuickIconModel.fromJson(Map<String, dynamic> json) {
    return QuickIconModel(
      platform: json['platform'],
      icon: json['icon'],
      url: json['url'],
    );
  }
}