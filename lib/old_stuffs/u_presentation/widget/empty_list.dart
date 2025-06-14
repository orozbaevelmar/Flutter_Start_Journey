import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyListy extends StatelessWidget {
  final String text;
  const EmptyListy({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black26,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            text,
            style: GoogleFonts.frankRuhlLibre(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
