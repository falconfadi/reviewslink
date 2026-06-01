import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Constant {
  static double radius = 15;

  static closeKeyBoard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static removeSpaces(context) {
    return (MediaQuery.of(context).padding.bottom +
        MediaQuery.of(context).padding.top);
  }

  static String changeNumberFormat(number) {
    NumberFormat formatter = NumberFormat("#,###");

    // Format the number using the format method
    String formattedNumber = formatter.format(number);
    return formattedNumber;
  }
}
