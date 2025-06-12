// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AttractionNameAndLocation extends StatelessWidget {
  final String name;
  final String location;
  const AttractionNameAndLocation({
    Key? key,
    required this.name,
    required this.location,
    required this.fontSizeMedium,
    required this.fontSizeSmall,
  }) : super(key: key);

  final double fontSizeMedium;
  final double fontSizeSmall;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          name,
          //mapKey,
          style: GoogleFonts.acme(
            // acme // yeonsung
            fontSize: fontSizeMedium,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 3),
                child: Icon(
                  Icons.location_on,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              Text(
                location,
                style: TextStyle(
                  fontSize: fontSizeSmall,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
