import 'package:flutter/material.dart';

class AppColor {
  static const dark = Color(0xFF6D7A77);
  static const black = Colors.black;
  static const black_shade300 = Colors.black87;
  static const black54 = Colors.black54;
  static const yellow = Color.fromARGB(255, 253, 234, 59);
  static const yellow2 = Color.fromARGB(255, 255, 255, 0);

  static const blue = Color.fromARGB(255, 33, 148, 242);

  static const greenPrimary = Color(0xFF5DB075);
  static const greenSecondary = Color(0xFF4B9460);
  //static const black = Color(0xFF1E1E1E);
  static const white = Color(0xFFffffff);
  static const red = Color(0xFFF74242);
  static const gray_04 = Color(0xFF666666);
  static const gray_03 = Color(0xFFBDBDBD);
  static const gray_02 = Color(0xFFE8E8E8);
  static const gray_01 = Color(0xFFF6F6F6);
  static const gray = Color(0xFF4A4A4A);

  static const greyBackGroundColor = Color.fromARGB(255, 245, 245, 245);

  static const primaryGradientColor = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.center,
    colors: [Color(0xFFC1DDC5), Color(0xFFEDEDED)],
  );
  static const borderGradientColor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF92C196), Color(0xFFECEDEC)],
  );

  static const Color backgroundColor = Color.fromRGBO(24, 24, 32, 1);
  static const Color gradient1 = Color.fromRGBO(187, 63, 221, 1);
  static const Color gradient2 = Color.fromRGBO(251, 109, 169, 1);
  static const Color gradient3 = Color.fromRGBO(255, 159, 124, 1);
  static const Color borderColor = Color.fromRGBO(52, 51, 67, 1);
  static const Color whiteColor = Colors.white;
  static const Color greyColor = Colors.grey;
  static const Color errorColor = Colors.redAccent;
  static const Color transparentColor = Colors.transparent;
}
