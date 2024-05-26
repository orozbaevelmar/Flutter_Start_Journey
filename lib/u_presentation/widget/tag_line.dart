import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTagLine extends StatelessWidget {
  final String hintText;
  const CustomTagLine(
      {super.key, required this.fontSizeBig, required this.hintText});

  final double fontSizeBig;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 65, // _height
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        hintText, // hospitable hotels are waiting for you //hotels for all desires
        style: GoogleFonts.frankRuhlLibre(
          fontSize: fontSizeBig,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
