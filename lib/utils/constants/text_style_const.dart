import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MTextStyle {
  static TextStyle body_1(Color color) {
    return GoogleFonts.ubuntu(
      textStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 22.4 / 16,
        letterSpacing: 2 / 100 * 16, //Figma letter 2%
        color: color,
      ),
    );
  }

  static TextStyle description(Color color) {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 20,
        height: 1.5,
        color: color,
      ),
    );
  }
}
