import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:start_journey/old_stuffs/utils/constants/box_shadow.dart';
import 'package:start_journey/old_stuffs/utils/constants/color_const.dart';
import 'package:start_journey/old_stuffs/utils/constants/text_style_const.dart';

class TripJournal extends StatelessWidget {
  TripJournal({super.key});

  final List<String> list = [
    'Journal Screen\n',
    'I can write here, how man plans his journey.',
    'He can choose some places, which he wants to go.',
    'Our server will recommend, which place can he go first, second, third.',
    'With other words, he will build a route of places, with help of Latitude and Longtitude,'
  ];

  final someWordsList = ['love', 'friends', 'hightlight'];

  final String str =
      'This is Coconut, Tina and Rob\'s new pup! He is so adorable:-) He was running around in the mud yesterday and made a huge...';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Journal',
                style: GoogleFonts.workSans(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 40,
                    letterSpacing: 2,
                    color: MColor.black_shade300,
                  ),
                ),
              ),
              SizedBox(height: 20),
              for (int i = 0; i < 3; i++)
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: MColor.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildData(i == 0),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              str,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15,
                                  height: 1.5,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            /* Container(
                            height: 500,
                            color: Colors.black,
                          ) */
                            SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage('images/journal/dog.jpeg'),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                for (int i = 0; i < someWordsList.length; i++)
                                  Container(
                                    margin: i != someWordsList.length
                                        ? EdgeInsets.only(right: 8)
                                        : EdgeInsets.zero,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: MColor.gray_02,
                                    ),
                                    child: Text(
                                      someWordsList[i].toUpperCase(),
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                          height: 2,
                                          letterSpacing: 1,
                                          color: MColor.gray,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildData(bool isSelected) {
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        boxShadow: [
          MBoxShadow.regular,
        ],
        color: isSelected ? MColor.white : Colors.white54,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: isSelected
            ? Border.all(
                width: 2,
                color: Colors.amber.shade400,
              )
            : Border(),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'SAT',
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 10,
                //eight: 1,
                color: Colors.black45,
                letterSpacing: 2,
              ),
            ),
          ),
          Text(
            '12',
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                letterSpacing: 2.5,
                //eight: 1,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
