import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostName extends StatelessWidget {
  const PostName({
    super.key,
    required this.attractionName,
  });

  final String attractionName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      alignment: Alignment.centerLeft,
      child: Text(
        attractionName,
        style: GoogleFonts.frankRuhlLibre(
            textStyle: Theme.of(context).textTheme.headlineLarge),
        //textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
      ),
    );
  }
}
