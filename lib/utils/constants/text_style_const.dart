import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MTextStyle {
  static TextStyle ui_20Bold(Color color) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 20,
        height: 23.36 / 20,
        color: color,
      ),
    );
  }

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

  static final appBarTextStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18,
    height: 21.78 / 18,
    color: const Color(0xFF1E1E1E),
  );

  static TextStyle ui_30Semi(Color color) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 30,
        height: 36.31 / 30,
        color: color,
      ),
    );
  }

  static TextStyle ui_16Semi(Color color) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        height: 19.36 / 16,
        color: color,
      ),
    );
  }

  static TextStyle ui_16Medium(Color color) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        height: 19.36 / 16,
        color: color,
      ),
    );
  }

  static TextStyle ui_14Regular(Color color) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 16.94 / 14,
        color: color,
      ),
    );
  }

  static TextStyle ui_14Medium(Color color) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 16.94 / 14,
        color: color,
      ),
    );
  }

  static final Medium30 = GoogleFonts.inter(
    textStyle: const TextStyle(
        fontWeight: FontWeight.w500, fontSize: 24, color: Color(0xFF727372)),
  );

  static final Regular14 = GoogleFonts.inter(
    textStyle: const TextStyle(
        fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFF717372)),
  );
  static final h1_regular20 = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 20,
      color: Color(0xFF0C0C0C),
      height: 23.44 / 16,
    ),
  );

  static final h3_14Light = GoogleFonts.roboto(
    textStyle: const TextStyle(
        fontWeight: FontWeight.w300, fontSize: 14, color: Color(0xFF454545)),
  );

  static TextStyle h3_14Regular(Color color) {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 16.41 / 14,
        color: color,
      ),
    );
  }

  static final h3_14LightLineThroughColor = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 14,
      color: Color(0xFFABABAB),
      decoration: TextDecoration.lineThrough,
    ),
  );

  static TextStyle h4_18Medium(Color color) {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: color,
      ),
    );
  }
}
