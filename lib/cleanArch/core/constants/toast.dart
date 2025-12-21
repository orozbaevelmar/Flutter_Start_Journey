import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:start_journey/cleanArch/core/theme/app_color.dart';
import 'package:start_journey/cleanArch/core/theme/app_color.dart';

class MToast {
  showRed(message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColor.red,
      textColor: Colors.white,
      fontSize: 16,
    );
  }

  showBlack(message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColor.gray,
      textColor: Colors.white,
      fontSize: 16,
    );
  }
}
