import 'package:flutter/material.dart';
import 'package:start_journey/utils/constants/box_shadow.dart';
import 'package:start_journey/utils/constants/color_const.dart';
import 'package:start_journey/utils/constants/text_style_const.dart';

class TripJournal extends StatelessWidget {
  TripJournal({super.key});

  final List<String> list = [
    'Journal Screen\n',
    'I can write here, how man plans his journey.',
    'He can choose some places, which he wants to go.',
    'Our server will recommend, which place can he go first, second, third.',
    'With other words, he will build a route of places, with help of Latitude and Longtitude,'
  ];

  final String str =
      'This is Coconut, Tina and Rob\'s new pup! He is so adorable:-) He was running around in the mud yesterday and made a huge...';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              height: 300,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: MColor.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildData(),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          str,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: MTextStyle.Regular18,
                        ),
                        SizedBox(height: 15),
                        /* Container(
                          height: 500,
                          color: Colors.black,
                        ) */
                        SizedBox(
                          height: 130,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image(
                              fit: BoxFit.cover,
                              image: AssetImage('images/journal/dog.jpeg'),
                            ),
                          ),
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
    );
  }

  Widget _buildData() {
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        boxShadow: [
          MBoxShadow.regular,
        ],
        color: MColor.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(
          width: 2,
          color: MColor.yellow,
        ),
      ),
      child: Column(
        children: [
          Text(
            'SAT',
            //  style: MTextStyle.Medium30,
          ),
          Text('12'),
        ],
      ),
    );
  }
}
