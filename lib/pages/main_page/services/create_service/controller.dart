import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/data/models/body/service/create/create_service_rating_form_body.dart';
import 'package:reviews_link_v2/data/models/body/service/create/create_service_social_media_body.dart';
import 'package:reviews_link_v2/data/models/body/service/create/create_service_url_body.dart';
import 'package:reviews_link_v2/data/models/body/service/update/update_service_rating_form_body.dart';
import 'package:reviews_link_v2/data/models/body/service/update/update_service_social_media_body.dart';
import 'package:reviews_link_v2/data/models/body/service/update/update_service_url_body.dart';
import 'package:reviews_link_v2/data/models/response/init/init_response.dart';
import 'package:reviews_link_v2/data/repository/service_repo.dart';
import 'package:reviews_link_v2/extensions/context_localization.dart';
import 'package:reviews_link_v2/pages/main_page/services/controller.dart';
import 'package:reviews_link_v2/data/models/response/service/service_response.dart' as serviceModelResponse;
import 'package:reviews_link_v2/pages/main_page/services/create_service/models/social_media_card_model.dart';
import 'package:reviews_link_v2/res/app_images.dart';
import 'package:reviews_link_v2/widgets/snack_bar/top_snack_bar.dart';

class CreateServiceController extends getx.GetxController {

  InitController initController = getx.Get.find();
  ServiceController serviceController = getx.Get.find();
  ServiceRepo serviceRepo = ServiceRepo();

  ServiceType? selectedType;
  getx.RxBool loading = false.obs;
  /// url
  TextEditingController titleController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  /// rating form
  TextEditingController formRatingTitleController = TextEditingController();
  TextEditingController formRatingDescriptionController = TextEditingController();
  RxBool allowComments = true.obs;
  RxInt maxStars = 5.obs;
  /// social media
  TextEditingController displayNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  getx.Rx<File> avatar = File('').obs;
  String? avatarUrl;
  getx.Rx<File> background = File('').obs;
  String? backgroundUrl;
  RxBool verified = false.obs;
  RxBool showQuickIcons = false.obs;
  RxList<SocialMediaCardModel> availableSocialMediaCards  = <SocialMediaCardModel>[
    SocialMediaCardModel(
        name: 'Instagram',
        title: 'Instagram',
        icon: INSTAGRAM,
        isFixed: true
    ),
    SocialMediaCardModel(
        title: 'Google',
        name: 'Google',
        icon: GOOGLE,
        isFixed: true
    ),
    SocialMediaCardModel(
        title: 'Youtube',
        name: 'Youtube',
        icon: YOUTUBE,
        isFixed: true
    ),
    SocialMediaCardModel(
        title: 'Facebook',
        name: 'Facebook',
        icon: FACEBOOK,
        isFixed: true
    ),
    SocialMediaCardModel(
        title: 'Whatsapp',
        name: 'Whatsapp',
        icon: WHATSAPP,
        isFixed: true
    ),
    SocialMediaCardModel(
        title: 'Tiktok',
        name: 'Tiktok',
        icon: TIKTOK,
        isFixed: true
    ),
    SocialMediaCardModel(
        title: 'LinkedIn',
        name: 'LinkedIn',
        icon: LINKEDIN,
        isFixed: true
    ),
    SocialMediaCardModel(
        title: 'Booking.com',
        name: 'Booking.com',
        icon: BOOKING,
        isFixed: true
    ),
    SocialMediaCardModel(
        title: 'Tripadvisor',
        name: 'Tripadvisor',
        icon: TRIPADVISOR,
        isFixed: true
    ),
    SocialMediaCardModel(
        title: 'Trustpilot',
        name: 'Trustpilot',
        icon: TRUSTPILOT,
        isFixed: true
    ),
    SocialMediaCardModel(
        title: 'WeChat',
        name: 'WeChat',
        icon: WECHAT,
        isFixed: true
    ),
  ].obs;
  RxList<SocialMediaCardModel> socialMediaCardsList = <SocialMediaCardModel>[].obs;

  final allowedTypes = [
    "url",
    "social_media_cards_4",
    "social_media_cards_8",
    "social_media_cards_unlimited",
    "rating_form"
  ];
  bool? editStatus;
  serviceModelResponse.ServiceResponse? chosenServiceToEdit;

  @override
  void onInit() {
    editStatus = getx.Get.arguments[0];
    if (editStatus == true) {
      print('@@@@@@@@@@@');
      chosenServiceToEdit = getx.Get.arguments[1];
      selectedType = chosenServiceToEdit?.serviceType.toInitModel();
      if (selectedType!.id == 2) {
        fillUrlFields();
      } else if (selectedType!.id == 8) {
        fillRatingFormFields();
      } else if (selectedType!.id == 5 || selectedType!.id == 6 || selectedType!.id == 7) {
        fillSocialMediaFields();
      }
      print('@@@@@@@@@@@');
    }
    super.onInit();
  }

  /// for Edit
  fillUrlFields() {
    urlController.text = (chosenServiceToEdit!.jsonData as serviceModelResponse.UrlServiceData).url;
    titleController.text = (chosenServiceToEdit!.jsonData as serviceModelResponse.UrlServiceData).title;
  }
  fillRatingFormFields() {
    formRatingTitleController.text = (chosenServiceToEdit!.jsonData as serviceModelResponse.RatingFormServiceData).formTitle;
    formRatingDescriptionController.text = (chosenServiceToEdit!.jsonData as serviceModelResponse.RatingFormServiceData).formDescription;
    allowComments.value = (chosenServiceToEdit!.jsonData as serviceModelResponse.RatingFormServiceData).allowComments;
    maxStars.value = (chosenServiceToEdit!.jsonData as serviceModelResponse.RatingFormServiceData).maxStars;
  }
  fillSocialMediaFields() {
    final socialMediaData = chosenServiceToEdit!.jsonData as serviceModelResponse.SocialMediaServiceData;

    displayNameController.text = socialMediaData.profile!.displayName ?? '';
    bioController.text = socialMediaData.profile!.bio ?? '';
    avatarUrl = socialMediaData.profile!.avatar;
    backgroundUrl = socialMediaData.profile!.background;
    verified.value = socialMediaData.profile!.verified ?? false;
    showQuickIcons.value = socialMediaData.settings?.showQuickIcons ?? false;
    initializeSocialMediaCardsForEdit(socialMediaData.cards ?? []);
  }

  choseSaveOption(BuildContext context) async {
    if (selectedType!.name == 'url') {
      await createServiceURL(context);
    } else if (selectedType!.name == 'rating_form') {
      await createServiceRatingForm(context);
    } else if (selectedType!.name == "social_media_cards_4" ||
        selectedType!.name == "social_media_cards_8" ||
        selectedType!.name == "social_media_cards_unlimited") {
      await createServiceSocialMedia(context);
    }
  }

  Future<File?> selectImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    if (pickedFile != null) {
      print(pickedFile.path);
      return File(pickedFile.path);
    }
    return null;
  }

  Future<void> createServiceURL(BuildContext context) async {
    Constant.closeKeyBoard();
    if (!loading.value) {
      if (urlController.text.isNotEmpty) {
        loading.value = true;
        await serviceRepo.createServiceUrl(
          CreateServiceUrlBody(
            title: titleController.text,
            serviceTypeId: selectedType!.id.toString(),
            url: urlController.text,
          ),
        ).then((value) {
          if (value.code == 201) {
            loading.value = false;
            titleController.clear();
            urlController.clear();
            serviceController.allServices.insert(0,
              serviceModelResponse.ServiceResponse.fromJson(
                value.body['service'],
              ),
            );
            TopSnackBar.success(context, value.message);
          }
        });
      } else {
        loading.value = false;
        TopSnackBar.warning(context, context.localizations.empty_field);
      }
    }
  }

  Future<void> createServiceRatingForm(BuildContext context) async {
    Constant.closeKeyBoard();
    if (!loading.value) {
      if (formRatingTitleController.text.isNotEmpty) {
        loading.value = true;
        await serviceRepo.createServiceRatingForm(
          CreateServiceRatingFormBody(
              serviceTypeId: selectedType!.id.toString(),
              title: formRatingTitleController.text,
              description: formRatingDescriptionController.text,
              allowComments: allowComments.value == true ? 1 : 0,
              maxStars: maxStars.value
          ),
        ).then((value) {
          if (value.code == 201) {
            loading.value = false;
            clearFormRatingData();
            serviceController.allServices.insert(0,
              serviceModelResponse.ServiceResponse.fromJson(
                value.body['service'],
              ),
            );
            TopSnackBar.success(context, value.message);
          }
        });
      } else {
        loading.value = false;
        TopSnackBar.warning(context, context.localizations.empty_field);
      }
    }
  }

  bool validateSocialMediaCards(BuildContext context) {

    final enabledCards = socialMediaCardsList.where((card) => card.enabled == true);

    if (selectedType?.name == "social_media_cards_8") {
      if (enabledCards.length > 8) {
        TopSnackBar.warning(context, "You can enable up to 8 social media cards only");
        return false;
      }
    }

    final isUnlimited = selectedType?.name == "social_media_cards_unlimited";

    if (isUnlimited) {
      final fixedCards = socialMediaCardsList.where((card) => card.isFixed);
      final customCards = socialMediaCardsList.where((card) => !card.isFixed);
      final enabledFixedCards = fixedCards.where((card) => card.enabled == true);

      for (final card in enabledFixedCards) {
        if (!_validateCardFields(context, card)) {
          return false;
        }
      }

      bool hasValidCustomCard = false;

      for (final card in customCards) {
        if (card.title!.trim().isEmpty && card.url!.trim().isEmpty) {
          continue;
        }

        if (card.title!.trim().isEmpty || card.url!.trim().isEmpty) {
          TopSnackBar.warning(context, context.localizations.empty_field);
          return false;
        }
        hasValidCustomCard = true;
      }

      if (enabledFixedCards.isEmpty && !hasValidCustomCard) {
        TopSnackBar.warning(context, "Enable at least one social media card");
        return false;
      }
      return true;
    }

    if (enabledCards.isEmpty) {
      TopSnackBar.warning(context, "Enable at least one social media card");
      return false;
    }

    for (final card in enabledCards) {
      if (!_validateCardFields(context, card)) {
        return false;
      }
    }
    return true;
  }

  bool _validateCardFields(BuildContext context, SocialMediaCardModel card) {
    if (card.title?.trim().isEmpty ?? true) {
      TopSnackBar.warning(context, context.localizations.empty_field);
      return false;
    }

    if (card.url?.trim().isEmpty ?? true) {
      TopSnackBar.warning(context, context.localizations.empty_field);
      return false;
    }

    return true;
  }

  Future<void> createServiceSocialMedia(BuildContext context) async {
    Constant.closeKeyBoard();
    if (loading.value) {
      return;
    }
    if (displayNameController.text.trim().isEmpty ||
        bioController.text.trim().isEmpty) {
      TopSnackBar.warning(context, context.localizations.empty_field);
      return;
    }

    if (!validateSocialMediaCards(context)) {
      return;
    }
    loading.value = true;
    await serviceRepo.createServiceSocialMedia(
      CreateServiceSocialMediaBody(
        serviceTypeId: selectedType!.id.toString(),
        displayName: displayNameController.text,
        bio: bioController.text,
        avatar: avatar.value,
        background: background.value,
        verified: verified.value,
        showQuickIcons: showQuickIcons.value,
        socialMediaCards: socialMediaCardsList.toList(),
      ),
    ).then((value) {
      if (value.code == 201) {
        loading.value = false;
        clearSocialMediaData();
        serviceController.allServices.insert(
          0,
          serviceModelResponse.ServiceResponse.fromJson(
            value.body['service'],
          ),
        );
        TopSnackBar.success(context, value.message);
      } else {
        loading.value = false;
        TopSnackBar.alert(context, value.message);
      }
    });
  }

  choseUpdateOption(BuildContext context) async {
    if (selectedType!.name == 'url') {
      await updateServiceURL(context);
    } else if (selectedType!.name == 'rating_form') {
      await updateServiceRatingForm(context);
    } else if (selectedType!.name == "social_media_cards_4" ||
        selectedType!.name == "social_media_cards_8" ||
        selectedType!.name == "social_media_cards_unlimited") {
      await updateServiceSocialMedia(context);
    }
  }

  void initializeSocialMediaCardsForEdit(List<serviceModelResponse.SocialMediaCardModel> apiCards) {
    final typeName = selectedType?.name;

    int fixedCount;

    if (typeName == "social_media_cards_4") {
      fixedCount = 4;
    } else if (typeName == "social_media_cards_8") {
      fixedCount = 8;
    } else if (typeName == "social_media_cards_unlimited") {
      fixedCount = 11;
    } else {
      return;
    }
    initializeSocialMediaCards(fixedCount);

    for (final apiCard in apiCards) {
      final platform = apiCard.platform?.trim().toLowerCase();

      if (platform == null || platform.isEmpty) {
        continue;
      }

      final index = socialMediaCardsList.indexWhere(
            (card) => card.name?.trim().toLowerCase() == platform,
      );

      if (index != -1) {
        final currentCard = socialMediaCardsList[index];

        socialMediaCardsList[index] = SocialMediaCardModel(
          name: currentCard.name,
          icon: currentCard.icon,
          title: apiCard.title ?? currentCard.title,
          url: apiCard.url ?? '',
          description: apiCard.description ?? '',
          enabled: true,
          isFixed: true,
        );
      } else if (typeName == "social_media_cards_unlimited") {
        socialMediaCardsList.add(
          SocialMediaCardModel(
            name: null,
            icon: null,
            title: apiCard.title ?? '',
            url: apiCard.url ?? '',
            description: apiCard.description ?? '',
            enabled: false,
            isFixed: false,
          ),
        );
      }
    }

    socialMediaCardsList.refresh();
  }

  Future<void> updateServiceURL(BuildContext context) async {
    Constant.closeKeyBoard();
    if (!loading.value) {
      if (urlController.text.isNotEmpty) {
        loading.value = true;
        await serviceRepo.updateServiceUrl(
          UpdateServiceUrlBody(
            title: titleController.text,
            serviceId: chosenServiceToEdit!.id.toString(),
            url: urlController.text,
          ),
        ).then((value) async {
          if (value.code == 200) {
            await serviceController.getServicesList();
            loading.value = false;
            getx.Get.back();
            TopSnackBar.success(context, value.message);
          }
        });
      } else {
        loading.value = false;
        TopSnackBar.warning(context, context.localizations.empty_field);
      }
    }
  }

  Future<void> updateServiceRatingForm(BuildContext context) async {
    Constant.closeKeyBoard();
    if (!loading.value) {
      if (formRatingTitleController.text.isNotEmpty) {
        loading.value = true;
        await serviceRepo.updateServiceRatingForm(
          UpdateServiceRatingFormBody(
            title: formRatingTitleController.text,
            description: formRatingDescriptionController.text,
            allowComments: allowComments.value == true ? 1 : 0,
            maxStars: maxStars.value,
            serviceId: chosenServiceToEdit!.id,
          ),
        ).then((value) async {
          if (value.code == 200) {
            await serviceController.getServicesList();
            loading.value = false;
            getx.Get.back();
            TopSnackBar.success(context, value.message);
          }
        });
      } else {
        loading.value = false;
        TopSnackBar.warning(context, context.localizations.empty_field);
      }
    }
  }

  Future<void> updateServiceSocialMedia(BuildContext context) async {
    Constant.closeKeyBoard();
    if (loading.value) {
      return;
    }
    if (displayNameController.text.trim().isEmpty ||
        bioController.text.trim().isEmpty) {
      TopSnackBar.warning(context, context.localizations.empty_field);
      return;
    }

    if (!validateSocialMediaCards(context)) {
      return;
    }
    loading.value = true;
    await serviceRepo.updateServiceSocialMedia(
      UpdateServiceSocialMediaBody(
        serviceId: chosenServiceToEdit!.id.toString(),
        displayName: displayNameController.text,
        bio: bioController.text,
        avatar: avatar.value,
        background: background.value,
        verified: verified.value,
        showQuickIcons: showQuickIcons.value,
        socialMediaCards: socialMediaCardsList.toList(),
      ),
    ).then((value) async {
      if (value.code == 200) {
        await serviceController.getServicesList();
        getx.Get.back();
        TopSnackBar.success(context, value.message);
      } else {
        TopSnackBar.alert(context, value.message);
      }
    });
  }

  void clearFormRatingData() {
    formRatingTitleController.clear();
    formRatingDescriptionController.clear();
    allowComments.value = true;
    maxStars.value = 5;
  }

  void clearSocialMediaData() {
    displayNameController.clear();
    bioController.clear();
    avatar.value = File('');
    avatarUrl = null;
    background.value = File('');
    backgroundUrl = null;
    verified.value = false;
    showQuickIcons.value = false;

    final typeName = selectedType?.name;

    if (typeName == "social_media_cards_4") {
      initializeSocialMediaCards(4);
    } else if (typeName == "social_media_cards_8") {
      initializeSocialMediaCards(8);
    } else if (typeName == "social_media_cards_unlimited") {
      initializeSocialMediaCards(11);
    }
  }

  clearData() {
    titleController.clear();
    urlController.clear();
    clearFormRatingData();
    clearSocialMediaData();
  }

  void initializeSocialMediaCards(int count) {
    socialMediaCardsList.value = availableSocialMediaCards
        .take(count).map((card) => SocialMediaCardModel(
      name: card.name,
      title: card.title,
      icon: card.icon,
      url: '',
      description: '',
      enabled: false,
      isFixed: true,
    )).toList();
  }

  void addSocialMediaCard() {
    socialMediaCardsList.add(
      SocialMediaCardModel(
        name: null,
        title: '',
        icon: null,
        url: '',
        description: '',
        enabled: false,
        isFixed: false,
      ),
    );
  }

  void removeSocialMediaCard(int index) {
    if (index < 0 || index >= socialMediaCardsList.length) {
      return;
    }
    final card = socialMediaCardsList[index];

    if (card.isFixed) {
      return;
    }
    socialMediaCardsList.removeAt(index);
  }

}

extension ServiceTypeMapper on serviceModelResponse.ServiceType {
  ServiceType toInitModel() {
    return ServiceType(
      id: id,
      name: name,
      tableName: tableName,
      dataType: dataType,
    );
  }
}
