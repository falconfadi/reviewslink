import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/controllers/app_storage.dart';
import 'package:reviews_link_v2/controllers/init_controller.dart';
import 'package:reviews_link_v2/data/models/body/auth/update_profile_body.dart';
import 'package:reviews_link_v2/data/models/response/auth/login_response.dart';
import 'package:reviews_link_v2/data/repository/auth_repo.dart';
import 'package:reviews_link_v2/extensions/context_localization.dart';
import 'package:reviews_link_v2/widgets/snack_bar/top_snack_bar.dart';

class ProfileController extends GetxController {

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  Rx<File?> pickedImage = Rx<File?>(null);
  RxString imageUrl = ''.obs;
  RxBool loading = false.obs;
  RxString countryDialCode = "+971".obs;
  RxBool showPassword = true.obs;
  RxBool removeImage = false.obs;

  final InitController initController = Get.find();
  AuthRepo authRepo = AuthRepo();

  @override
  void onInit() async {
    await fillFields();
    super.onInit();
  }

  fillFields() {
    fullNameController.text = initController.userData!.userName ?? "";
    emailController.text = initController.userData!.userEmail ?? "";
    phoneNumberController.text = initController.userData!.mobile ?? "";
    companyNameController.text = initController.userData!.companyName ?? "";
    jobTitleController.text = initController.userData!.jobTitle ?? "";
    imageUrl.value = initController.userData!.img ?? "";
    countryDialCode.value = initController.userData!.mobileCode ?? "+971";
  }

  Future<File?> selectImage({required ImageSource imageSource}) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
      source: imageSource,
      imageQuality: 25,
    );
    if (pickedFile != null) {
      removeImage.value = false;
      return File(pickedFile.path);
    }
    return null;
  }

  User mergeUser(User oldUser, User newUser) {
    return User(
      adminId: newUser.adminId ?? oldUser.adminId,
      username: newUser.username ?? oldUser.username,
      img: newUser.img ?? oldUser.img,
      superAdmin: newUser.superAdmin ?? oldUser.superAdmin,
      adminStatus: newUser.adminStatus ?? oldUser.adminStatus,
      jobTitle: newUser.jobTitle ?? oldUser.jobTitle,
      userId: newUser.userId ?? oldUser.userId,
      userName: newUser.userName ?? oldUser.userName,
      userEmail: newUser.userEmail ?? oldUser.userEmail,
      mobile: newUser.mobile ?? oldUser.mobile,
      mobileCode: newUser.mobileCode ?? oldUser.mobileCode,
      companyName: newUser.companyName ?? "",
      userStatus: newUser.userStatus ?? oldUser.userStatus,
      creationDate: newUser.creationDate ?? oldUser.creationDate,
      token: oldUser.token,
    );
  }

  updateProfile(BuildContext context) async {
    if (!loading.value) {
      Constant.closeKeyBoard();
      if (isUserDataValid()) {
        loading.value = true;
        authRepo.updateProfile(
              UpdateProfileBody(
                name: fullNameController.text,
                mobileCode: countryDialCode.value,
                mobile: phoneNumberController.text,
                companyName: companyNameController.text,
                image: removeImage.value ? null : pickedImage.value,
                defaultImage: removeImage.value ? 1 : null,
              ),
            ).then((value) async {
              if (value.code == 200) {
                final oldUser = await AppStorage.getUser();
                final updatedUser = User.fromJson(value.body['user']);
                final mergedUser = mergeUser(oldUser!, updatedUser);
                await AppStorage.saveUser(mergedUser);
                initController.userData = await AppStorage.getUser();
                fillFields();
                loading.value = false;
                TopSnackBar.success(context, value.message);
              } else {
                loading.value = false;
                TopSnackBar.warning(context, value.message);
              }
            });
      } else {
        TopSnackBar.warning(context, context.localizations.empty_field);
      }
    }
  }

  void removeUserImage() {
    pickedImage.value = null;
    imageUrl.value = '';
    removeImage.value = true;
  }

  bool isUserDataValid() {
    if (fullNameController.text.trim().isEmpty) return false;
    if (phoneNumberController.text.trim().isEmpty) return false;
    if (countryDialCode.trim().isEmpty) return false;

    return true;
  }
}
