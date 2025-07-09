import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:start_journey/moveToCleanArch/core/constants/color_const.dart';

class MToast {
  showRed(message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: MColor.red,
      textColor: Colors.white,
      fontSize: 16,
    );
  }

  showBlack(message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: MColor.gray,
      textColor: Colors.white,
      fontSize: 16,
    );
  }
}
