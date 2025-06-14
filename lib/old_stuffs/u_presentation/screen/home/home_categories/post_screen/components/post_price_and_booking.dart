import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:start_journey/old_stuffs/utils/constants/adaptive_font_size.dart';

class PriceAndBooking extends StatelessWidget {
  const PriceAndBooking({
    super.key,
    required this.price,
  });

  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20,
        left: 10,
        right: 10,
      ),
      padding: EdgeInsets.all(5),
      height: 90,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            child: Text(
              price,
              style: GoogleFonts.lobster(
                  fontSize: 25, fontWeight: FontWeight.normal),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(3),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.green.shade300,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                  )
                ],
              ),
              child: Text(
                'Book Now',
                textAlign: TextAlign.center,
                style: GoogleFonts.libreBaskerville(
                  textStyle: Theme.of(context).textTheme.headlineLarge,
                ),
                textScaler:
                    TextScaler.linear(ScaleSize.textScaleFactor(context)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
