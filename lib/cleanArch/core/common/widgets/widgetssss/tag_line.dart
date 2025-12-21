import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:start_journey/cleanArch/core/extensions/context_extension.dart';

class CustomTagLine extends StatelessWidget {
  final String hintText;
  const CustomTagLine({
    super.key,
    required this.fontSizeBig,
    required this.hintText,
  });

  final double fontSizeBig;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.startJourneyTheme;
    return Container(
      alignment: Alignment.centerLeft,
      height: appTheme.scaledSize(65),
      padding: EdgeInsets.symmetric(
          horizontal: appTheme.paddingM, vertical: appTheme.paddingXS),
      child: Text(
        hintText, // hospitable hotels are waiting for you //hotels for all desires
        style: appTheme.cardLabel.copyWith(
          fontWeight: FontWeight.w500,
        ),
        // GoogleFonts.frankRuhlLibre(),
      ),
    );
  }
}
