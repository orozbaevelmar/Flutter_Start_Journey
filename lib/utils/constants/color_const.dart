import 'package:flutter/material.dart';

class MColor {
  static const dark = Color(0xFF6D7A77);
  static const black = Colors.black;
  static const yellow = Colors.yellow;

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
}
