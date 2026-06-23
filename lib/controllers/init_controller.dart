import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/controllers/app_storage.dart';
import 'package:reviews_link_v2/data/models/response/auth/login_response.dart';
import 'package:reviews_link_v2/data/models/response/init/init_response.dart';
import 'package:reviews_link_v2/extensions/context_localization.dart';
import 'package:reviews_link_v2/res/color.dart';

class InitController extends GetxController {

  User? userData;
  DateTime timeBackPressed = DateTime.now();

  RxList<ServiceType> servicesTypeList = <ServiceType>[].obs;
  RxList<Currencies> currencyList = <Currencies>[].obs;

  logout() async {
    await AppStorage.deleteUser();
    userData = null;
    Get.offAllNamed('/login');
  }

  Future<bool> backButton(BuildContext context) async {
    final difference = DateTime.now().difference(timeBackPressed);
    final isExitWarning = difference >= const Duration(seconds: 2);
    timeBackPressed = DateTime.now();
    if (isExitWarning) {
      Fluttertoast.showToast(
        msg: context.localizations.press_back_to_exit,
        fontSize: 14,
        textColor: white,
        backgroundColor: secondaryColor,
      );
      return false;
    } else {
      Fluttertoast.cancel();
      return true;
    }
  }

  String formatPriceWithConversion({required double price, required int productCurrencyId}) {
    final baseCurrency = currencyList.firstWhere(
      (c) => int.parse(c.id!) == productCurrencyId,
    );

    final otherCurrency = currencyList.firstWhere(
      (c) => c.id != baseCurrency.id,
    );

    double rate = double.tryParse(baseCurrency.rate ?? "1") ?? 1;

    double convertedPrice;

    if (baseCurrency.rate != null) {
      convertedPrice = price * rate;
    } else {
      double otherRate = double.tryParse(otherCurrency.rate ?? "1") ?? 1;
      convertedPrice = price / otherRate;
    }
    return "${convertedPrice.toStringAsFixed(2)} ${otherCurrency.symbol}";
  }
}
